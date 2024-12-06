import 'package:flutter/material.dart';
import 'package:prototype3/screens/User/saved_addresses_screen.dart';
import 'package:prototype3/theme/theme_provider.dart';
import 'language_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // State variable for dark mode

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
        title: const Text("Settings"),
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
                MaterialPageRoute(builder: (context) => const LanguageScreen()),
              );
            },
          ),
          ListTile(
            title: const Text("Saved Addresses"),
            onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedAddressesScreen(),
            ),
            );
            },
          ),
        ],
      ),
    );
  }
} 