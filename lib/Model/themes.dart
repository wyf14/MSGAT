import 'package:flutter/material.dart';

class MyThemes {
  // ثيم لايت: برتقالي على أبيض
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color(0xFFFF9800), // برتقالي أساسي
      secondary: Color(0xFFFFB74D), // برتقالي فاتح
      surface: Color(0xFFFFFFFF),
      onPrimary: Colors.white,
      onSecondary: Color(0xFF333333),
      onSurface: Color(0xFF222222),
    ),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFF9800),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFFF9800)),
      titleTextStyle: TextStyle(
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Tajawal',
          color: Color(0xFFFF9800),
          fontWeight: FontWeight.bold,
          fontSize: 28),
      bodyLarge: TextStyle(
          fontFamily: 'Tajawal', color: Color(0xFF222222), fontSize: 18),
      bodyMedium: TextStyle(fontFamily: 'Tajawal', color: Color(0xFFFF9800)),
      bodySmall: TextStyle(fontFamily: 'Tajawal', color: Color(0xFFFFB74D)),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shadowColor: Color(0xFFFF9800).withOpacity(0.10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF9800),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFFF9800),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      filled: true,
      fillColor: Color(0xFFFFF3E0),
      hintStyle: TextStyle(color: Color(0xFFFFB74D)),
    ),
    iconTheme: IconThemeData(color: Color(0xFFFF9800)),
    dividerColor: Color(0xFFFF9800).withOpacity(0.15),
  );

  // ثيم دارك: برتقالي على أسود
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFFF9800), // برتقالي أساسي
      secondary: Color(0xFFFFB74D), // برتقالي فاتح
      surface: Color(0xFF23232F),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF181820),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF23232F),
      foregroundColor: Color(0xFFFF9800),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFFF9800)),
      titleTextStyle: TextStyle(
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Color(0xFFFF9800)),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Tajawal',
          color: Color(0xFFFF9800),
          fontWeight: FontWeight.bold,
          fontSize: 28),
      bodyLarge:
          TextStyle(fontFamily: 'Tajawal', color: Colors.white, fontSize: 18),
      bodyMedium: TextStyle(fontFamily: 'Tajawal', color: Color(0xFFFF9800)),
      bodySmall: TextStyle(fontFamily: 'Tajawal', color: Color(0xFFFFB74D)),
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF23232F),
      elevation: 4,
      shadowColor: Color(0xFFFF9800).withOpacity(0.10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF9800),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFFF9800),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      filled: true,
      fillColor: Color(0xFF23232F),
      hintStyle: TextStyle(color: Color(0xFFFFB74D)),
    ),
    iconTheme: IconThemeData(color: Color(0xFFFF9800)),
    dividerColor: Color(0xFFFF9800).withOpacity(0.15),
  );
}
