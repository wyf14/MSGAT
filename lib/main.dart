import 'package:fakih/Model/themes.dart';
import 'package:fakih/Model/wyf_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'Model/ad_helper.dart';
import 'Model/language_provider.dart';
import 'Model/theme_provider.dart';
import 'Features/splash/presantation/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  final languageProvider = LanguageProvider();
  await languageProvider.loadLanguage(); // تحميل اللغة المحفوظة

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdManager()),
        ChangeNotifierProvider(create: (context) => languageProvider),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: WYFApp.APP_NAME,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
