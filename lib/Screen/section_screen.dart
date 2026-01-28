import 'dart:convert';
import 'package:fakih/Model/wyf_app.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../Model/DatabaseHelper.dart';
import '../Model/ad_helper.dart';
import '../Widgets/bannerAdWidget.dart';
import 'messages_dart.dart';

class SectionsPage extends StatelessWidget {
  final int categoryId;
  var sections;// معرّف التصنيف
   SectionsPage({super.key, required this.categoryId, required this.appLanguage, required this.catName});
  final String appLanguage;

  final String catName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text(catName),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getSections(categoryId),  // جلب الأقسام بناءً على categoryId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("خطأ في تحميل البيانات"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("لا توجد أقسام"));
          }

            sections = snapshot.data!;

          return
            Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.2
                    ),
                    itemCount: sections.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap:  () {
                            // عند النقر على القسم، يمكنك الانتقال إلى صفحة الرسائل
                           // navigateWithAd(context, BannerInlinePage(sectionId: sections[index]['id'], appLanguage: appLanguage,),
                           // );
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => MessagesPage(sectionId: sections[index]['id'],sectionName: getSectionName(index), appLanguage: appLanguage),
                            ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                      fit: StackFit.expand,
                      children: [
                    // خلفية الصورة من الشبكة
                    Image.network(
                    sections[index]['background']!,
                      fit: BoxFit.cover,
                    ),
                          // النص على الصورة
                          Container(
                            color: Colors.black.withAlpha(80),
                            child: Center(
                              child: Positioned(
                                bottom: 20,
                                left: 10,
                                child: Text(
                                  getSectionName(index), // عرض العنوان باللغة العربية   utf8.decode(categories[index]['name_ar'].toString().codeUnits)
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black.withOpacity(0.7),
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ]
                      )
                      )
                    );




                          },
                        ),
                ),
                BannerAdWidget()
              ],
            );


    })
    );
  }

  // دالة جلب الأقسام بناءً على categoryId
  Future<List<Map<String, dynamic>>> getSections(int categoryId) async {
    final db = await DatabaseHelper.getDatabase();  // الوصول إلى قاعدة البيانات
    return await db.query(
      'sections',
      where: 'category_id = ?',  // تصفية الأقسام بناءً على categoryId
      whereArgs: [categoryId],
    );
  }
  Future<List<Map<String, dynamic>>> getSections1(int categoryId) async {
    final db = await DatabaseHelper.getDatabase();  // الوصول إلى قاعدة البيانات
    final List<Map<String, dynamic>> sections = await db.query(
      'sections',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );

    return sections.map((section) {
      return {
        'id': section['id'],
        'name_ar': utf8.decode(section['name_ar'].toString().codeUnits),  // فك الترميز
      };
    }).toList();
  }

  String getSectionName(int index) {
    return (appLanguage=='العربية')?  sections[index]['name_ar']:sections[index]['name_en'];
  }


}
