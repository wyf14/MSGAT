import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdWidgetItem extends StatelessWidget {
  final BannerAd ad;
  final bool loaded;

  const AdWidgetItem({Key? key, required this.ad, required this.loaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Container(
            width: ad.size.width.toDouble(),
            height: 72.0,
            alignment: Alignment.center,
            child: AdWidget(ad: ad),
          )
        : SizedBox(height: 72.0);
  }
}
