import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async'; // Add this import for Timer
import 'package:provider/provider.dart'; // Add this import for Provider
import 'package:prototype3/theme/theme_provider.dart'; // Adjust the import path as necessary

class ViewRequestsScreen extends StatefulWidget {
  const ViewRequestsScreen({Key? key}) : super(key: key);

  @override
  _ViewRequestsScreenState createState() => _ViewRequestsScreenState();
}

class _ViewRequestsScreenState extends State<ViewRequestsScreen> {
  double _angle = 0; // Angle for circular movement
  late Timer _timer; // Declare the timer

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _angle += 0.1; // Increment angle for movement
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context); // Get the current theme

    return Scaffold(
      appBar: AppBar(
        title: const Text("Courier Information"),
        backgroundColor: theme.getTheme().colorScheme.primary, // Use theme color
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(30.0444, 31.2357), // Cairo, Egypt
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(30.0444, 31.2357), // Courier's position
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          buildPinIcon(),
                          Transform.translate(
                            offset: Offset(30 * cos(_angle), 30 * sin(_angle)), // Circular movement
                            child: buildCourierIcon(), // New courier icon
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.getTheme().scaffoldBackgroundColor, // Use theme background color
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Courier Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text("Name: John Doe"),
                const Text("License Plate: ABC 1234"),
                const Text("Phone Number: +20 123 456 7890"),
                const Text("Rating: ⭐ 4.5"),
                const Text("Total Deliveries: 50"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCourierIcon() {
    return Icon(Icons.delivery_dining, color: Colors.blue, size: 30); // Courier icon
  }
}

Widget buildPinIcon({Color color = Colors.red, double size = 45}){

  return Icon(Icons.location_pin,
  color: color,
  size: size,);
}