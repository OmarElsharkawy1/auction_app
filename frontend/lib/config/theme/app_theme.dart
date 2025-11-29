import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Color(0xFF2962FF); // Electric Blue
  static const _backgroundColor = Color(0xFFF5F5F7); // Off-White
  static const _surfaceColor = Colors.white;
  static const _textColor = Colors.black;

  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _backgroundColor,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      primary: _primaryColor,
      surface: _surfaceColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _surfaceColor,
      foregroundColor: _textColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: _textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
    ),
    cardTheme: CardThemeData(
      color: _surfaceColor,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.zero,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _primaryColor, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.grey[600]),
      prefixStyle: const TextStyle(color: _textColor),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: _textColor,
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
      ),
      headlineMedium: TextStyle(
        color: _textColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        color: _textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: _textColor, fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(
        color: Color(0xFF424242), // Slightly softer black for body
        fontSize: 14,
        height: 1.5,
      ),
    ),
  );
}
