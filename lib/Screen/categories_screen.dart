import 'package:flutter/material.dart';

import '../Model/DatabaseHelper.dart';
import '../Widgets/bannerAdWidget.dart';
import 'section_screen.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key, required this.appLanguage});
  final String appLanguage;
  var categories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            (appLanguage == 'العربية') ? Text('التصنيفات') : Text('Categories'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getCategories(), // جلب التصنيفات من قاعدة البيانات
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("خطأ في تحميل البيانات"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("لا توجد تصنيفات"));
          }

          categories = snapshot.data!; // البيانات التي تم جلبها

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // بطاقة واحدة في كل صف
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    mainAxisExtent: 150, // ارتفاع ثابت للبطاقة
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SectionsPage(
                              categoryId: categories[index]['id'],
                              catName: getCatName(index),
                              appLanguage: appLanguage,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              categories[index]['background']!,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: Colors.black.withAlpha(90),
                              child: Center(
                                child: Positioned(
                                  bottom: 20,
                                  left: 10,
                                  child: Text(
                                    getCatName(index),
                                    style: TextStyle(
                                      fontSize: 30,
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              BannerAdWidget()
            ],
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await DatabaseHelper.getDatabase(); // الوصول إلى قاعدة البيانات
    return await db
        .query('categories'); // استعلام جلب التصنيفات من جدول categories
  }

  getCatName(int index) {
    return (appLanguage == 'العربية')
        ? categories[index]['name_ar']
        : categories[index]['name_en'];
  }
}
