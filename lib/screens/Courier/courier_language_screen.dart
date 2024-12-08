import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prototype3/theme/theme_provider.dart';

class CourierLanguageScreen extends StatefulWidget {
  const CourierLanguageScreen({Key? key}) : super(key: key);

  @override
  _CourierLanguageScreenState createState() => _CourierLanguageScreenState();
}

class _CourierLanguageScreenState extends State<CourierLanguageScreen> {
  String? selectedLanguage;

  void _selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
    // Implement logic to change app language here
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Language",
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
              child: InkWell(
                onTap: () => _selectLanguage("English"),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: selectedLanguage == "English"
                        ? theme.getTheme().colorScheme.primary.withOpacity(0.1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/english_flag.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "English",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: selectedLanguage == "English"
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: theme.getTheme().colorScheme.onBackground,
                        ),
                      ),
                      const Spacer(),
                      if (selectedLanguage == "English")
                        Icon(
                          Icons.check_circle,
                          color: theme.getTheme().colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => _selectLanguage("Arabic"),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: selectedLanguage == "Arabic"
                        ? theme.getTheme().colorScheme.primary.withOpacity(0.1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/arabic_flag.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "العربية",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: selectedLanguage == "Arabic"
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: theme.getTheme().colorScheme.onBackground,
                        ),
                      ),
                      const Spacer(),
                      if (selectedLanguage == "Arabic")
                        Icon(
                          Icons.check_circle,
                          color: theme.getTheme().colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 