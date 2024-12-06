import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AdminManageCouriersScreen extends StatefulWidget {
  const AdminManageCouriersScreen({Key? key}) : super(key: key);

  @override
  State<AdminManageCouriersScreen> createState() => _AdminManageCouriersScreenState();
}

class _AdminManageCouriersScreenState extends State<AdminManageCouriersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _activeCouriers = [
    {
      'name': 'Ahmed Mohamed',
      'status': 'Active',
      'location': LatLng(30.0444, 31.2357),
      'current_delivery': 'Food Donation to Masr El-Kheir',
      'rating': 4.8,
      'deliveries_completed': 150,
      'average_delivery_time': '25 mins',
    },
    {
      'name': 'Sara Ahmed',
      'status': 'On Break',
      'location': LatLng(30.0450, 31.2360),
      'current_delivery': 'None',
      'rating': 4.9,
      'deliveries_completed': 200,
      'average_delivery_time': '22 mins',
    },
  ];

  final List<Map<String, String>> _pendingDeliveries = [
    {
      'id': 'DEL001',
      'pickup': 'Downtown Cairo',
      'dropoff': 'Masr El-Kheir Foundation',
      'type': 'Food Donation',
      'urgency': 'High',
    },
    {
      'id': 'DEL002',
      'pickup': 'Nasr City',
      'dropoff': 'Resala Charity',
      'type': 'Medical Supplies',
      'urgency': 'Medium',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Couriers",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Live Tracking"),
            Tab(text: "Assign Deliveries"),
            Tab(text: "Performance"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLiveTrackingTab(),
          _buildAssignDeliveriesTab(),
          _buildPerformanceTab(),
        ],
      ),
    );
  }

  Widget _buildLiveTrackingTab() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(30.0444, 31.2357),
              initialZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _activeCouriers.map((courier) => Marker(
                  point: courier['location'],
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.delivery_dining,
                    color: courier['status'] == 'Active' 
                        ? Theme.of(context).colorScheme.primary 
                        : Colors.grey,
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: ListView.builder(
            itemCount: _activeCouriers.length,
            itemBuilder: (context, index) {
              final courier = _activeCouriers[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(courier['name']),
                subtitle: Text('Status: ${courier['status']}\n${courier['current_delivery']}'),
                isThreeLine: true,
                trailing: Icon(
                  Icons.circle,
                  color: courier['status'] == 'Active' ? Colors.green : Colors.orange,
                  size: 12,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAssignDeliveriesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _pendingDeliveries.length,
      itemBuilder: (context, index) {
        final delivery = _pendingDeliveries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery #${delivery['id']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Chip(
                      label: Text(
                        delivery['urgency']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: delivery['urgency'] == 'High' 
                          ? Colors.red 
                          : Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Type: ${delivery['type']}'),
                Text('Pickup: ${delivery['pickup']}'),
                Text('Dropoff: ${delivery['dropoff']}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _showAssignCourierDialog(context, delivery);
                  },
                  child: const Text('Assign Courier'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPerformanceTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _activeCouriers.length,
      itemBuilder: (context, index) {
        final courier = _activeCouriers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courier['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPerformanceMetric(
                  'Rating',
                  '${courier['rating']} / 5.0',
                  courier['rating'] / 5,
                ),
                _buildPerformanceMetric(
                  'Deliveries Completed',
                  courier['deliveries_completed'].toString(),
                  courier['deliveries_completed'] / 200,
                ),
                _buildPerformanceMetric(
                  'Average Delivery Time',
                  courier['average_delivery_time'],
                  0.85,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPerformanceMetric(String label, String value, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showAssignCourierDialog(BuildContext context, Map<String, String> delivery) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Assign Courier'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _activeCouriers
                .map((courier) => ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(courier['name']),
                      subtitle: Text('Status: ${courier['status']}'),
                      onTap: () {
                        // Handle courier assignment
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ),
        );
      },
    );
  }
} 