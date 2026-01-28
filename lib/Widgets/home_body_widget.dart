import 'package:flutter/material.dart';
import '../Features/check_for_update.dart';
import '../Model/DatabaseHelper.dart';
import '../Model/app_data.dart';
import '../Model/wyf_app.dart';
import '../Screen/app_info_page.dart';
import '../Screen/categories_screen.dart';
import '../Widgets/my_cards_widget.dart';
import 'package:fakih/Widgets/bannerAdWidget.dart';
class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
    required String selectedLanguage,
  }) : _selectedLanguage = selectedLanguage;

  final String _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset('assets/images/icon.png', width: 100, height: 100),
              ),
              SizedBox(height: 10),
              Text(
                localizedValues[_selectedLanguage]!['app_name']!,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Container(
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(alignment: Alignment.topLeft, child: Text('ads')),
                    Center(
                      child: Text(
                        localizedValues[_selectedLanguage]!['ad_text']!,
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    buildNavButton(Icons.message, localizedValues[_selectedLanguage]!['enter']!, () {
                      navigateWithAd(context, CategoriesPage(appLanguage: _selectedLanguage,));

                    }),
                    buildNavButton(Icons.star, localizedValues[_selectedLanguage]!['rate']!, requestReview),
                    buildNavButton(Icons.info, localizedValues[_selectedLanguage]!['about_app']!, () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => AppInfoPage()));
                    }),

                    buildNavButton(Icons.apps, localizedValues[_selectedLanguage]!['more']!,openDeveloperPage),
                    buildNavButton(Icons.developer_mode, localizedValues[_selectedLanguage]!['about_us']!, () {
                      //TODO
                      checkAndUpdateMessages("messages");

                      // DatabaseHelper.loadCsvToDatabase();//done
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => AboutPage()),
                      // );
                    }),
                    buildNavButton(Icons.apps, localizedValues[_selectedLanguage]!['share']!, shareApp),
                  ],
                ),
              ),
            ],
          ),
        ),
        BannerAdWidget()

      ],
    );
  }
}