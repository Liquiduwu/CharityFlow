import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Language"),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => _selectLanguage("English"),
            child: Container(
              color: selectedLanguage == "English" ? Colors.blue[100] : Colors.transparent,
              child: ListTile(
                leading: Image.asset('assets/images/english_flag.png'),
                title: const Text("English"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _selectLanguage("Arabic"),
            child: Container(
              color: selectedLanguage == "Arabic" ? Colors.blue[100] : Colors.transparent,
              child: ListTile(
                leading: Image.asset('assets/images/arabic_flag.png'),
                title: const Text("Arabic"),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 