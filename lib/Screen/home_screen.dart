import 'package:fakih/l10n/localized_values.dart';
import 'package:flutter/material.dart';
import '../Features/check_for_update.dart';
import '../Model/wyf_app.dart';
import '../Widgets/home_body_widget.dart';
import '../Widgets/custom_app_drawer.dart';
import '../AppLifecycleReactor.dart';
// import '../AppOpenAdManager.dart';
import '../Screen/contactUs_screen.dart';
import 'package:provider/provider.dart';
import '../Model/theme_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDark = false;
  late AppLifecycleReactor _appLifecycleReactor;
  bool _isLoaded = false;
  String _selectedLanguage = 'العربية'; // اللغة الافتراضية

  @override
  void initState() {
    super.initState();

    // checkAndUpdateMessages();//TODO app open ads
    // AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    // _appLifecycleReactor = AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    // loadBanner();
    LanguagePreferences.getLanguage().then((lang) {
      setState(() {
        _selectedLanguage = lang;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _selectedLanguage == 'العربية'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizedValues[_selectedLanguage]!['app_name']!),
          leading: Builder(
            builder: (context) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: isDark ? Colors.orange : Colors.white,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
        ),
        drawer: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) => CustomAppDrawer(
            isDark: themeProvider.themeMode == ThemeMode.dark,
            selectedLanguage: _selectedLanguage,
            onThemeToggle: () {
              final newIsDark = themeProvider.themeMode != ThemeMode.dark;
              themeProvider.toggleTheme(newIsDark);
              setState(() {
                _isDark = newIsDark;
              });
            },
            onLanguageToggle: () {
              setState(() {
                _selectedLanguage =
                    _selectedLanguage == 'العربية' ? 'English' : 'العربية';
                LanguagePreferences.saveLanguage(_selectedLanguage);
              });
            },
            onContact: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => ContactUsPage()));
            },
            onShare: () {
              shareApp();
            },
          ),
        ),
        body: HomeBodyWidget(selectedLanguage: _selectedLanguage),
      ),
    );
  }

  // BannerAd? _bannerAd;
// void loadBanner() {
//   _bannerAd = BannerAd(
//     adUnitId: AdHelper.bannerAdUnitId(),
//     request: const AdRequest(),
//     size: AdSize.banner,
//     listener: BannerAdListener(
//       onAdLoaded: (ad) {
//         debugPrint('$ad loaded.');
//         setState(() {
//           _isLoaded = true;
//         });
//       },
//       onAdFailedToLoad: (ad, err) {
//         debugPrint('BannerAd failed to load: $err');
//         ad.dispose();
//       },
//     ),
//   )..load();
// }
}
