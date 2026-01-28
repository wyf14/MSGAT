import 'package:fakih/Widgets/bannerAdWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Model/DatabaseHelper.dart';
import '../Model/ad_helper.dart';
import '../Model/wyf_app.dart';


class MessagesPage extends StatefulWidget {
  final int sectionId;
  final String appLanguage;

  final String sectionName;

  const MessagesPage( {Key? key, required this.sectionId,required this.sectionName, required this.appLanguage}) : super(key: key);

  @override
  _MessagesPagePageState createState() => _MessagesPagePageState();
}

class _MessagesPagePageState extends State<MessagesPage> {
  late String col;
  List<Map<String, dynamic>> messages = [];
  List<BannerAd> ads = [];
  List<bool> adsLoaded = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    col = (widget.appLanguage == 'العربية') ? 'message_ar' : 'message_en';
    loadMessages();
  }

  Future<void> loadMessages() async {
    final db = await DatabaseHelper.getDatabase();
    List<Map<String, dynamic>> fetchedMessages = await db.query(
      'messages',
      columns: [col],
      where: 'section_id = ?',
      whereArgs: [widget.sectionId],
    );

    setState(() {
      messages = fetchedMessages;
      isLoading = false;
      setupAds();
    });
  }

  void setupAds() {
    int adCount = (messages.length / 6).floor();
    ads = List.generate(adCount, (index) => createBannerAd());
    adsLoaded = List.filled(adCount, false);

    for (int i = 0; i < ads.length; i++) {
      ads[i].load();
    }
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            adsLoaded[ads.indexOf(ad as BannerAd)] = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('فشل تحميل الإعلان: ${error.message}');
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var ad in ads) {
      ad.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.sectionName)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        appBar: AppBar(title: Text(widget.sectionName)),
        body:
        Column(
          children: [
            Expanded(
              child: 
              ListView.builder(
                itemCount: messages.length + ads.length,
                itemBuilder: (context, index) {
                  int adIndex = ((index + 1) / 7).floor() - 1;

                  if ((index + 1) % 7 == 0 && adIndex >= 0 && adIndex < ads.length) {
                    return adsLoaded[adIndex]
                        ? Container(
                      width: ads[adIndex].size.width.toDouble(),
                      height: 72.0,
                      alignment: Alignment.center,
                      child: AdWidget(ad: ads[adIndex]),
                    )
                        : SizedBox(height: 72.0);
                  } else {
                    int messageIndex = index - (adIndex + 1);
                    return Card(
                      margin: EdgeInsets.all(8),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              messages[messageIndex][col] ?? "خطأ في تحميل البيانات",
                              style: TextStyle(fontSize: MediaQuery.textScalerOf(context).scale(16)),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      // مشاركة الرسالة
                                      shareText(messages[messageIndex][col]);
                                    },
                                  ),
                                  IconButton(
                                    icon: isFavorite(messages[index]['id'])?Icon(Icons.favorite,
                                      color: Colors.red,):Icon(Icons.favorite),
                                    onPressed: () {
                                      // مشاركة الرسالة
                                      addToFav(messages[messageIndex]['id']);
                                      setState(() {

                                      });
                                    },
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            BannerAdWidget()
          ],
        )
    );
  }

  void addToFav(msgId) {
    DatabaseHelper.addFav(msgId);
  }

  bool isFavorite(msg_id) {
    return true;
  }
} 