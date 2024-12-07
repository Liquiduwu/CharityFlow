import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:prototype3/theme/theme_provider.dart';

enum DeliveryStatus {
  pending,
  inProgress,
  completed
}

class CourierViewRequestsScreen extends StatefulWidget {
  const CourierViewRequestsScreen({Key? key}) : super(key: key);

  @override
  _CourierViewRequestsScreenState createState() => _CourierViewRequestsScreenState();
}

class _CourierViewRequestsScreenState extends State<CourierViewRequestsScreen> {
  late Timer _timer;
  double _progress = 0.0;
  
  // Add status tracking
  Map<int, DeliveryStatus> _deliveryStatuses = {};
  Map<int, String> _estimatedTimes = {};
  
  // Courier's inventory with realistic quantities
  final Map<String, int> _courierInventory = {
    'Food Boxes': 15,      // Food donation boxes
    'Medicine Packs': 8,   // Medical supplies
    'Clothing Bags': 10,   // Clothing donations
    'School Supplies': 12, // Educational materials
  };

  // Charities data with actual locations in Cairo
  final List<Map<String, dynamic>> _charities = [
    {
      'name': 'Egyptian Food Bank',
      'category': 'Food Boxes',
      'location': LatLng(30.0566, 31.2269),  // Tahrir Square area
    },
    {
      'name': 'Cairo Children\'s Hospital',
      'category': 'Medicine Packs',
      'location': LatLng(30.0445, 31.2384),  // Downtown Cairo
    },
    {
      'name': 'Resala Charity',
      'category': 'Clothing Bags',
      'location': LatLng(30.0700, 31.2824),  // Heliopolis
    },
    {
      'name': 'Hope Village Society',
      'category': 'School Supplies',
      'location': LatLng(30.0288, 31.2624),  // Maadi
    },
  ];

  // Starting position - Cairo Tower area
  final LatLng _startingPosition = LatLng(30.0459, 31.2243);

  List<LatLng> _routePoints = [];
  List<Map<String, dynamic>> _routePlan = [];
  List<Map<String, String>> _requestInfo = [];

  // Calculate distance between two points
  double calculateDistance(LatLng point1, LatLng point2) {
    return sqrt(
      pow(point1.latitude - point2.latitude, 2) +
      pow(point1.longitude - point2.longitude, 2)
    );
  }

  LatLng _calculateCurrentPosition() {
    if (_routePoints.isEmpty) return _startingPosition;
    
    int currentSegment = (_progress * (_routePoints.length - 1)).floor();
    double segmentProgress = (_progress * (_routePoints.length - 1)) - currentSegment;
    
    if (currentSegment >= _routePoints.length - 1) return _routePoints.last;
    
    LatLng start = _routePoints[currentSegment];
    LatLng end = _routePoints[currentSegment + 1];
    
    return LatLng(
      start.latitude + (end.latitude - start.latitude) * segmentProgress,
      start.longitude + (end.longitude - start.longitude) * segmentProgress,
    );
  }

  // Calculate ETA based on distance
  String _calculateETA(double distance) {
    // Assuming average speed of 30 km/h in Cairo traffic
    // Convert the coordinate distance to approximate kilometers (rough estimation)
    double distanceInKm = distance * 111; // Convert coordinate difference to km
    double timeInHours = distanceInKm / 30;
    int minutes = (timeInHours * 60).round();
    
    if (minutes < 1) return "Less than a minute";
    if (minutes < 60) return "$minutes minutes";
    
    int hours = minutes ~/ 60;
    minutes = minutes % 60;
    return "$hours h ${minutes} min";
  }

  void _updateDeliveryStatuses() {
    int currentSegment = (_progress * (_routePoints.length - 1)).floor();
    
    _deliveryStatuses.clear();
    for (int i = 0; i < _routePlan.length; i++) {
      if (i < currentSegment) {
        _deliveryStatuses[i] = DeliveryStatus.completed;
      } else if (i == currentSegment) {
        _deliveryStatuses[i] = DeliveryStatus.inProgress;
      } else {
        _deliveryStatuses[i] = DeliveryStatus.pending;
      }
    }
  }

  // Implement the allocation algorithm
  void allocateResources() {
    Map<String, int> inventory = Map.from(_courierInventory);
    List<Map<String, dynamic>> routePlan = [];
    List<LatLng> routePoints = [];
    
    LatLng courierLocation = _startingPosition;  // Start from Cairo Tower
    routePoints.add(courierLocation);

    while (inventory.isNotEmpty) {
      Map<String, dynamic>? nearestCharity;
      double nearestDistance = double.infinity;

      for (var charity in _charities) {
        if (inventory.containsKey(charity['category'])) {
          double distance = calculateDistance(courierLocation, charity['location'] as LatLng);
          if (distance < nearestDistance) {
            nearestCharity = charity;
            nearestDistance = distance;
          }
        }
      }

      if (nearestCharity != null) {
        String category = nearestCharity['category'];
        routePlan.add({
          'charity': nearestCharity['name'],
          'category': category,
          'quantity': inventory[category],
          'distance': nearestDistance,
          'location': nearestCharity['location'],
        });

        routePoints.add(nearestCharity['location'] as LatLng);
        inventory.remove(category);
        courierLocation = nearestCharity['location'] as LatLng;
      } else {
        break;
      }
    }

    // Calculate ETAs for each stop
    _estimatedTimes.clear();
    double totalDistance = 0;
    
    for (int i = 0; i < routePlan.length; i++) {
      if (i == 0) {
        totalDistance = calculateDistance(_startingPosition, routePlan[i]['location'] as LatLng);
      } else {
        totalDistance += calculateDistance(
          routePlan[i-1]['location'] as LatLng,
          routePlan[i]['location'] as LatLng
        );
      }
      _estimatedTimes[i] = _calculateETA(totalDistance);
    }

    setState(() {
      _routePoints = routePoints;
      _routePlan = routePlan;
      _requestInfo = _routePlan.map((stop) {
        LatLng loc = stop['location'] as LatLng;
        return {
          'Pickup Location': '${stop['charity']}',
          'Package Type': '${stop['category']} (${stop['quantity']} units)',
        };
      }).toList();
      _updateDeliveryStatuses();
    });
  }

  @override
  void initState() {
    super.initState();
    allocateResources();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 0.005;
        if (_progress >= 1.0) _progress = 0.0;
        _updateDeliveryStatuses();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildStatusIcon(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case DeliveryStatus.inProgress:
        return const Icon(Icons.delivery_dining, color: Colors.blue, size: 20);
      case DeliveryStatus.pending:
        return const Icon(Icons.schedule, color: Colors.grey, size: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = _calculateCurrentPosition();
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delivery Route",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.getTheme().colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: allocateResources,
            tooltip: 'Recalculate Route',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _startingPosition,  // Center on Cairo Tower
                initialZoom: 12,  // Adjusted zoom to show more of Cairo
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 4.0,
                      color: theme.getTheme().colorScheme.primary,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: _routePoints.map((point) {
                    bool isStartingPoint = point == _startingPosition;
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: point,
                      child: Icon(
                        isStartingPoint ? Icons.home : Icons.location_pin,
                        color: isStartingPoint 
                          ? Colors.green 
                          : theme.getTheme().colorScheme.primary,
                        size: isStartingPoint ? 35 : 45,
                      ),
                    );
                  }).toList()
                    ..add(
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: currentPosition,
                        child: const Icon(
                          Icons.delivery_dining,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.getTheme().scaffoldBackgroundColor,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Schedule",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.getTheme().colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: allocateResources,
                      tooltip: 'Recalculate Route',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ..._requestInfo.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> info = entry.value;
                  DeliveryStatus status = _deliveryStatuses[index] ?? DeliveryStatus.pending;
                  
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      children: [
                        _buildStatusIcon(status),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stop ${index + 1}: ${info['Pickup Location']}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: theme.getTheme().colorScheme.onBackground,
                                ),
                              ),
                              Text(
                                "${info['Package Type']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.getTheme().colorScheme.onBackground.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                "ETA: ${_estimatedTimes[index] ?? 'Calculating...'}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.getTheme().colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 