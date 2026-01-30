import 'package:flutter/material.dart';

class MyThemes {
  // ---------------- LIGHT THEME (Copilot Colors) ----------------
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color(0xFF6B4EFF), // Copilot Purple
      secondary: Color(0xFFA58CFF), // Light Purple
      surface: Color(0xFFF7F7F8), // Light Surface
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF1C1C1E), // Soft Black
    ),
    scaffoldBackgroundColor: Color(0xFFF7F7F8),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF7F7F8),
      foregroundColor: Color(0xFF6B4EFF),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF6B4EFF)),
      titleTextStyle: TextStyle(
        fontFamily: 'Tajawal',
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Color(0xFF6B4EFF),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Tajawal',
        color: Color(0xFF6B4EFF),
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Tajawal',
        color: Color(0xFF1C1C1E),
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Tajawal',
        color: Color(0xFF6B4EFF),
      ),
      bodySmall: TextStyle(
        fontFamily: 'Tajawal',
        color: Color(0xFFA58CFF),
      ),
    ),
    cardTheme: CardThemeData(
      color: Color.fromARGB(255, 236, 231, 255),
      elevation: 0,
      shadowColor: Color(0xFF6B4EFF).withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6B4EFF),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF6B4EFF),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      filled: true,
      fillColor: Color(0xFFEDEBFF),
      hintStyle: TextStyle(color: Color(0xFFA58CFF)),
    ),
    iconTheme: IconThemeData(color: Color(0xFF6B4EFF)),
    dividerColor: Color(0xFF6B4EFF).withOpacity(0.15),
  );

  // ---------------- DARK THEME (Copilot Colors) ----------------
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFFFFFFF),
      secondary: Color.fromARGB(255, 249, 248, 251),
      surface: Color(0xFF1A1A24),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF0F0F14),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF23232F),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: 'Tajawal',
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Tajawal',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Tajawal',
        color: Colors.white,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Tajawal',
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Tajawal',
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF1A1A24),
      elevation: 0,
      shadowColor: Color(0xFF6B4EFF).withOpacity(0.10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6A4CD4),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF6A4CD4),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      filled: true,
      fillColor: Color(0xFF1A1A24),
      hintStyle: TextStyle(color: Color(0xFFA58CFF)),
    ),
    iconTheme: IconThemeData(color: Color(0xFF6B4EFF)),
    dividerColor: Color(0xFF6B4EFF).withOpacity(0.15),
  );
}
