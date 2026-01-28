import 'package:flutter/material.dart';

class MyThemes{
  static ThemeData pastelTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFEBEE),
    scaffoldBackgroundColor: Color(0xFFFFEBEE),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF424242)),
      bodyMedium: TextStyle(color: Color(0xFF757575)),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFA5D6A7),
      textTheme: ButtonTextTheme.primary,
    ),
  );
  static ThemeData neutralTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFF5F5F5),
    secondaryHeaderColor: Color(0xFF607D8B),
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Color(0xFF424242)),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF1565C0),
      textTheme: ButtonTextTheme.primary,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF1E1E2C),
    secondaryHeaderColor: Color(0xFFBB86FC),
    scaffoldBackgroundColor: Color(0xFF1E1E2C),
    textTheme: TextTheme(
      labelLarge: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white70),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF03DAC5),
      textTheme: ButtonTextTheme.primary,
    ),
  );
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    secondaryHeaderColor: Color(0xFF2196F3),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF333333)),
      bodySmall: TextStyle(color: Color(0xFF666666)),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFFF9800),
      textTheme: ButtonTextTheme.primary,
    ),
  );
}