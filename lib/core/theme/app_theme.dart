import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00695C); // Teal 800
  static const Color secondaryColor = Color(0xFFAD1457); // Pink 800
  static const Color accentColor = Color(0xFFFFD740); // Amber A200
  static const Color backgroundColor = Color(0xFFF5F5F5); // Grey 100
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF263238); // Blue Grey 900
  static const Color subtitleColor = Color(0xFF78909C); // Blue Grey 400

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
      ),
      fontFamily:
          'Roboto', // Using default, can be replaced with Google Fonts later
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textColor,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textColor),
        bodyMedium: TextStyle(fontSize: 14, color: subtitleColor),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
