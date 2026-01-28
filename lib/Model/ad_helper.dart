import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper{
static String bannerAdUnitId() {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/9214589741'; // وحدة اختبارية لـ Android
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2435281174'; // وحدة اختبارية لـ iOS
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

static String interstitialAdUnitId() {
if (Platform.isAndroid) {
return 'ca-app-pub-3940256099942544/1033173712'; // وحدة اختبارية لـ Android
} else if (Platform.isIOS) {
return 'ca-app-pub-3940256099942544/4411468910'; // وحدة اختبارية لـ iOS
} else {
throw UnsupportedError('Unsupported platform');
}
}
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw UnsupportedError("Unsupported platform");
  }
}

class AdManager extends ChangeNotifier {
  static final AdManager _instance = AdManager._internal();

  factory AdManager() => _instance;

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  bool _isAdLoaded = false;

  AdManager._internal() {
    _loadBannerAd();
    _loadInterstitialAd();
  }

  void _loadBannerAd() {
    if (_bannerAd == null) {
      _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _isAdLoaded = true;
              notifyListeners();
            });
          },
          onAdFailedToLoad: (ad, error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _isAdLoaded = false;
              ad.dispose();
              _bannerAd = null;
              notifyListeners();
              _loadBannerAd();
            });
          },
        ),
        request: const AdRequest(),
      )
        ..load();
    }
  }

  BannerAd? get bannerAd => _bannerAd;

  bool get isAdLoaded => _isAdLoaded;

  InterstitialAd? get interstitialAd => _interstitialAd;

  /// Loads an interstitial ad.
  void _loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉 Interstitial Ad Loaded Successfully!');

            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌ Failed to load interstitial ad: $error');
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }
  void showInterstitialAd(VoidCallback onAdClosed) {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _loadInterstitialAd(); // تحميل إعلان جديد بعد إغلاق الإعلان الحالي
          onAdClosed(); // تنفيذ الإجراء بعد إغلاق الإعلان
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          ad.dispose();
          _loadInterstitialAd();
          onAdClosed(); // في حالة فشل العرض، انتقل مباشرةً للصفحة التالية
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null; // تجنب عرض نفس الإعلان أكثر من مرة
    } else {
      onAdClosed(); // إذا لم يكن الإعلان محملاً، انتقل مباشرةً للصفحة التالية
    }
  }


}
