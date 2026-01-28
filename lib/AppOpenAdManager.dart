import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:fluttertoast/fluttertoast.dart';
class AppOpenAdManager {

  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;


  String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-3940256099942544/5575463023';

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.load(
      adUnitId: adUnitId,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
          // _appOpenAd?.show();
          print('loaded..............................................................................................................AppOpenAd  load: ');
            showAdIfAvailable();
        },
        onAdFailedToLoad: (error) {
          print('.............................................AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }
   void showAdIfAvailable() {
     if (!isAdAvailable) {
       print("Tried to show ad before available.");
       loadAd();
       return;
     }
     if (_isShowingAd) {
       print('Tried to show ad while already showing an ad.');
       return;
     }
     if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
       print('Maximum cache duration exceeded. Loading another ad.');
       _appOpenAd!.dispose();
       _appOpenAd = null;
       loadAd();
       return;
     }
     // Set the fullScreenContentCallback and show the ad.
     _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
       onAdShowedFullScreenContent: (ad) {
         _isShowingAd = true;
         print('$ad onAdShowedFullScreenContent');
       },
       onAdFailedToShowFullScreenContent: (ad, error) {
         print('$ad : $error');
         _isShowingAd = false;
         ad.dispose();
         _appOpenAd = null;
       },
       onAdDismissedFullScreenContent: (ad) {
         print('$ad onAdDismissedFullScreenContent');
         _isShowingAd = false;
         ad.dispose();
         _appOpenAd = null;
         //loadAd();
       },
     );
     _appOpenAd!.show();
   }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }
   void showToast(String msg){
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
}