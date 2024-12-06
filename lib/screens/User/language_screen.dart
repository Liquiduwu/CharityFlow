import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? selectedLanguage;

  void _selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
    // Implement logic to change app language here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Language"),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => _selectLanguage("English"),
            child: Container(
              color: selectedLanguage == "English" ? Colors.blue[100] : Colors.transparent, // Highlight color
              child: ListTile(
                leading: Image.asset('assets/images/english_flag.png'), // Add your English flag image
                title: const Text("English"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _selectLanguage("Arabic"),
            child: Container(
              color: selectedLanguage == "Arabic" ? Colors.blue[100] : Colors.transparent, // Highlight color
              child: ListTile(
                leading: Image.asset('assets/images/arabic_flag.png'), // Add your Arabic flag image
                title: const Text("Arabic"),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 