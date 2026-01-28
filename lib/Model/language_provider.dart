import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _language = 'ar'; // اللغة الافتراضية (العربية)

  String get language => _language;

  // تغيير اللغة
  Future<void> setLanguage(String language) async {
    _language = language;
    notifyListeners(); // إعادة بناء الواجهة

    // حفظ اللغة في SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  // تحميل اللغة المحفوظة
  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? 'ar'; // اللغة الافتراضية
    notifyListeners();
  }
}