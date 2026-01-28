import 'package:fakih/Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'widgets/splash_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate(); // بدأ تحميل البيانات
  }

  // تحميل البيانات والتحقق منها
  Future<void> _loadDataAndNavigate() async {
    // await loadInitialData();

    // إذا كانت عملية تحميل البيانات تحتاج وقتًا أطول، يمكنك وضعها هنا.
    await Future.delayed(Duration(seconds: 2)); // محاكاة تحميل البيانات لمدة 2 ثانية
    Timer(Duration(seconds: 2), () {
      // بعد التحميل، ننتقل إلى الصفحة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'title')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,  // اللون الأساسي لشاشة التحميل
      body:
      splash_body(),
    );
  }
}

