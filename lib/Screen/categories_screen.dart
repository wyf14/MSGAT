import 'package:flutter/material.dart';

import '../Model/DatabaseHelper.dart';
import '../Widgets/bannerAdWidget.dart';
import 'section_screen.dart';

class CategoriesPage extends StatelessWidget {
   CategoriesPage({super.key, required this.appLanguage});
 final String appLanguage ;
  var categories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (appLanguage=='العربية')?Text('التصنيفات'):Text('Categories'),
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getCategories(),  // جلب التصنيفات من قاعدة البيانات
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("خطأ في تحميل البيانات"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("لا توجد تصنيفات"));
          }

           categories = snapshot.data!;  // البيانات التي تم جلبها

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عرض بطاقتين في السطر
                    crossAxisSpacing: 8.0, // المسافة بين الأعمدة
                    mainAxisSpacing: 8.0, // المسافة بين الصفوف
                    childAspectRatio: 1.2, // تعديل حجم البطاقات
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // عند النقر على التصنيف، الانتقال إلى صفحة الأقسام
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SectionsPage(categoryId: categories[index]['id'],catName:getCatName(index),appLanguage: appLanguage,),
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
                            // خلفية الصورة من الشبكة
                            Image.network(
                              categories[index]['background']!,
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
                                    getCatName(index), // عرض العنوان باللغة العربية   utf8.decode(categories[index]['name_ar'].toString().codeUnits)
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
    final db = await DatabaseHelper.getDatabase();  // الوصول إلى قاعدة البيانات
    return await db.query('categories');  // استعلام جلب التصنيفات من جدول categories
  }

  getCatName(int index) {
   return (appLanguage=='العربية')?categories[index]['name_ar']:categories[index]['name_en'];
  }

}
