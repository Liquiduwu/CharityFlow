import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:prototype3/theme/theme_provider.dart';

class CourierViewRequestsScreen extends StatefulWidget {
  const CourierViewRequestsScreen({Key? key}) : super(key: key);

  @override
  _CourierViewRequestsScreenState createState() => _CourierViewRequestsScreenState();
}

class _CourierViewRequestsScreenState extends State<CourierViewRequestsScreen> {
  late Timer _timer;
  double _progress = 0.0;
  
  final List<LatLng> _routePoints = [
    LatLng(30.0444, 31.2357),
    LatLng(30.0450, 31.2360),
    LatLng(30.0460, 31.2370),
  ];

  final List<Map<String, String>> _requestInfo = [
    {
      'Pickup Location': '30.0444° N, 31.2357° E',
      'Package Type': 'Food Donation',
    },
    {
      'Pickup Location': '30.0450° N, 31.2360° E',
      'Package Type': 'Medical Supplies',
    },
    {
      'Pickup Location': '30.0460° N, 31.2370° E',
      'Package Type': 'Clothing',
    },
  ];

  LatLng _calculateCurrentPosition() {
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

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 0.005; // Faster movement
        if (_progress >= 1.0) _progress = 0.0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = _calculateCurrentPosition();
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Requests"),
        backgroundColor: theme.getTheme().colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(30.0444, 31.2357),
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: _routePoints.map((point) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: point,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 45,
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
                Text(
                  "Available Requests",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.getTheme().colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                ..._requestInfo.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> info = entry.value;
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Text(
                      "Point ${index + 1}: ${info['Pickup Location']} - ${info['Package Type']}",
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.getTheme().colorScheme.onBackground,
                      ),
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