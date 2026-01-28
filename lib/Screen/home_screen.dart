import 'package:flutter/material.dart';
import '../Features/check_for_update.dart';
import '../Model/wyf_app.dart';
import '../Model/app_data.dart';
import '../Widgets/home_body_widget.dart';
import '../AppLifecycleReactor.dart';
import '../AppOpenAdManager.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      textDirection: _selectedLanguage == 'العربية' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizedValues[_selectedLanguage]!['app_name']!),
          actions: [
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                  LanguagePreferences.saveLanguage(newValue);
                });
              },
              items: <String>['العربية', 'English']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
          leading: buildAppIcon(width: 40, height: 40),
        ),

        body:
        HomeBodyWidget(selectedLanguage: _selectedLanguage),
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

