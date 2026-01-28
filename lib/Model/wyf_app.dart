import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ad_helper.dart';

class WYFApp{
  static final String APP_NAME="Msgat";
}
class MyCards{
  final String id;
  final String icon;
  final String title;

  const MyCards({required this.id, required this.icon, required this.title});
}
class Msg{
 final String id,msg,background,type;
  const Msg({required this.id,required this.msg, required this.background,required this.type});
}

final InAppReview inAppReview = InAppReview.instance;

Future<void> requestReview() async {
  if (false) {//await inAppReview.isAvailable()
    inAppReview.requestReview();
  } else {
    openStore();
  }

}
  final String developerId = "6907030538659156649"; // ضع معرف المطور الخاص بك هنا

  Future<void> openDeveloperPage() async {
    final Uri url = Uri.parse("https://play.google.com/store/apps/dev?id=$developerId");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "لا يمكن فتح الرابط: $url";
    }
  }
Future<void> openStore() async {
  final String appStoreUrl = 'https://play.google.com/store/apps/details?id=com.wyf.app'; // لتطبيق Android
  // final String appStoreUrl = 'https://apps.apple.com/us/app/your-app-id'; // لتطبيق iOS

  if (await canLaunch(appStoreUrl)) {
    await launch(appStoreUrl);
  } else {
    throw 'Could not open the app store.';
  }
}
Future<void> shareApp() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String packageName = packageInfo.packageName;
  String appUrl = 'https://play.google.com/store/apps/details?id=$packageName';

  String shareText = 'جرب تطبيقي الآن: $appUrl';
  if (shareText.isNotEmpty) {
    Share.share(shareText);
  }
  // final Uri uri = Uri.parse('sms:?&body=$shareText'); // مشاركة عبر SMS
  //
  // if (await canLaunchUrl(uri)) {
  //   await launchUrl(uri);
  // } else {
  //   print("لا يمكن فتح رابط المشاركة");
  // }
}
void rate() {
  requestReview();
}

const Map<String, Map<String, String>> _localizedValues = {
  'العربية': {
    'app_name': 'تطبيق المسجات',
    'enter': 'دخول',
    'rate': 'التقييم',
    'about_app': 'عن التطبيق',
    'contact_us': 'اتصل بنا',
    'more': 'المزيد',
    'about_us': 'عنا',
    'share': 'مشاركة',
    'ad_text': 'إعلان خاص بك هنا',
  },
  'English': {
    'app_name': 'Messages App',
    'enter': 'Enter',
    'rate': 'Rate',
    'about_app': 'About App',
    'contact_us': 'Contact Us',
    'more': 'More',
    'about_us': 'About Us',
    'share': 'Share',
    'ad_text': 'Your ad here',
  },
};


void shareText(String text) {
  if (text.isNotEmpty) {
    Share.share(text);
  }
}
  class LanguagePreferences {
    static const String _key = 'selectedLanguage';

    // حفظ اللغة
    static Future<void> saveLanguage(String language) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, language);
    }

    // استعادة اللغة
    static Future<String> getLanguage() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_key) ?? 'العربية'; // الافتراضي العربية
    }

  }
// ميثود لإنشاء أيقونة المسجات باستخدام SVG
Widget buildAppIcon({double width = 200, double height = 200}) {
  final String svgIcon = '''
  <svg width="512" height="512" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg">
    <!-- تعريف التدرج اللوني -->
    <defs>
      <linearGradient id="bgGrad" x1="0" y1="0" x2="1" y2="1">
        <stop offset="0%" stop-color="#4e54c8"/>
        <stop offset="100%" stop-color="#8f94fb"/>
      </linearGradient>
    </defs>
    
    <!-- الخلفية الدائرية -->
    <circle cx="256" cy="256" r="256" fill="url(#bgGrad)"/>
    
    <!-- رمز فقاعة الدردشة -->
    <path d="M176,210 
             h160 
             a16,16 0 0 1 16,16 
             v112 
             a16,16 0 0 1 -16,16 
             h-48 
             l-40,40 
             -40,-40 
             h-16 
             a16,16 0 0 1 -16,-16 
             v-112 
             a16,16 0 0 1 16,-16 
             z" fill="#ffffff"/>
  </svg>
  ''';

  return SvgPicture.string(
    svgIcon,
    width: width,
    height: height,
    semanticsLabel: 'أيقونة المسجات',
  );
}

void navigateWithAd(BuildContext context, Widget nextPage) {
  AdManager().showInterstitialAd(() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  });
}
