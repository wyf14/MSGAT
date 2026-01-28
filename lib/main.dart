import 'package:fakih/Model/themes.dart';
import 'package:fakih/Model/wyf_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'Model/ad_helper.dart';
import 'Model/language_provider.dart';
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
        ChangeNotifierProvider(create: (context) => AdManager()),  // مزود الإعلانات
        ChangeNotifierProvider(create: (context) => languageProvider), // مزود اللغة
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: WYFApp.APP_NAME,
      theme: MyThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

}
