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
    final theme = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.getTheme().colorScheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              theme.getTheme().colorScheme.primary.withOpacity(0.1),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Dark/Light Mode",
                      style: TextStyle(
                        color: theme.getTheme().colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Icon(
                      Icons.brightness_6,
                      color: theme.getTheme().colorScheme.primary,
                    ),
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: _toggleDarkMode,
                      activeColor: theme.getTheme().colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Notifications",
                      style: TextStyle(
                        color: theme.getTheme().colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Icon(
                      Icons.notifications,
                      color: theme.getTheme().colorScheme.primary,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.getTheme().colorScheme.primary,
                    ),
                    onTap: () {
                      // Handle Notifications settings
                    },
                  ),
                  Divider(
                    height: 1,
                    color: theme.getTheme().colorScheme.outline.withOpacity(0.2),
                  ),
                  ListTile(
                    title: Text(
                      "Language",
                      style: TextStyle(
                        color: theme.getTheme().colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Icon(
                      Icons.language,
                      color: theme.getTheme().colorScheme.primary,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.getTheme().colorScheme.primary,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CourierLanguageScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 