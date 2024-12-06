import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = _lightTheme;

  static final ThemeData _lightTheme = ThemeData(
    primaryColor: const Color(0xFF424242), // Dark Gray
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF424242)),
      bodyMedium: TextStyle(color: Color(0xFF424242)),
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF90CAF9), // Soft Blue
      secondary: Color(0xFFA5D6A7), // Light Mint
      background: Colors.white,
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xFF424242), // Dark Gray
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF90CAF9), // Soft Blue
      secondary: Color(0xFFA5D6A7), // Light Mint
      background: Color(0xFF424242), // Dark Gray
    ),
  );

  ThemeData getTheme() => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == _lightTheme ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
