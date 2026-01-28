import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../Model/ad_helper.dart';

class BannerAdWidget extends StatelessWidget {
  static final GlobalKey _adKey = GlobalKey(); // ✅ يمنع تكرار `AdWidget`

  BannerAdWidget({Key? key}) : super(key: _adKey);

  @override
  Widget build(BuildContext context) {
    final adManager = Provider.of<AdManager>(context, listen: true);

    return adManager.isAdLoaded
        ? Container(
      width: adManager.bannerAd!.size.width.toDouble(),
      height: adManager.bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: adManager.bannerAd!),
    )
        : const SizedBox(); //TODO custom ads ✅ لا يعرض الإعلان إلا عند تحميله
  }
}
