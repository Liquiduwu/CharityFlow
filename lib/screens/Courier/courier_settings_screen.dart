import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prototype3/theme/theme_provider.dart';
import 'courier_language_screen.dart';

class CourierSettingsScreen extends StatefulWidget {
  const CourierSettingsScreen({Key? key}) : super(key: key);

  @override
  _CourierSettingsScreenState createState() => _CourierSettingsScreenState();
}

class _CourierSettingsScreenState extends State<CourierSettingsScreen> {
  bool _isDarkMode = false;

  void _toggleDarkMode(bool? value) {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
    setState(() {
      _isDarkMode = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courier Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Dark/Light Mode"),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: _toggleDarkMode,
            ),
          ),
          ListTile(
            title: const Text("Notifications"),
            onTap: () {
              // Handle Notifications settings
            },
          ),
          ListTile(
            title: const Text("Language"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CourierLanguageScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
} 