import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('معلومات عن التطبيق'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان المعلومات
            Text(
              'معلومات عن تطبيق المسجات',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // مقدمة عن التطبيق داخل إطار
            _buildSectionTitle('مقدمة عن التطبيق:'),
            _buildRightBorderContainer(
              Text(              'تطبيق المسجات هو تطبيق مميز يهدف إلى توفير مجموعة متنوعة من الرسائل المتخصصة لتناسب كل مناسبة. يتميز التطبيق بواجهة بسيطة وسهلة الاستخدام تتيح للمستخدمين الوصول إلى رسائل مخصصة في مختلف التصنيفات.',
              )
            ),
            SizedBox(height: 20),

            // المميزات الرئيسية داخل إطار
            _buildSectionTitle('المميزات الرئيسية للتطبيق:'),
            _buildFeatureList(),

            SizedBox(height: 20),

            // كيفية استخدام التطبيق داخل إطار
            _buildSectionTitle('كيفية استخدام التطبيق:'),
            _buildUsageInstructions(),

            SizedBox(height: 20),

            // التقييم والدعم داخل إطار
            _buildSectionTitle('التقييم والدعم:'),
            _buildSupportInfo(),
          ],
        ),
      ),
    );
  }

  // دالة لبناء عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }



  // دالة لإضافة إطار إضافي على الجهة اليمنى
  Widget _buildRightBorderContainer(Widget content) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          right: BorderSide(color: Colors.blueAccent, width: 4.0), // تعديل هنا
        ),
      ),
      child: content
    );
  }

  // دالة لبناء قائمة المميزات داخل إطارات مع تعديل الإطار من الجهة اليمنى
  Widget _buildFeatureList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeatureItem('تصنيفات متنوعة: يحتوي التطبيق على عدة تصنيفات من الرسائل التي تشمل: رسائل حب، رسائل تحفيزية، رسائل تهنئة، ورسائل إسلامية.'),
        _buildFeatureItem('تخزين الرسائل: يتم تخزين آلاف الرسائل داخل التطبيق بحيث يكون لديك وصول دائم لأفضل الرسائل التي يمكن أن تشاركها مع الآخرين.'),
        _buildFeatureItem('التحديثات المستمرة: يتم تحديث التطبيق بشكل دوري لإضافة رسائل جديدة في التصنيفات المختلفة.'),
        _buildFeatureItem('واجهة مستخدم بسيطة: التطبيق يحتوي على تصميم احترافي ونظيف مع واجهة رئيسية سهلة الاستخدام.'),
        _buildFeatureItem('إمكانية التقييم: يمكن للمستخدمين تقييم التطبيق مباشرة من داخل التطبيق أو عبر فتح متجر التطبيقات.'),
      ],
    );
  }

  // دالة لبناء عنصر في قائمة المميزات داخل إطار مع تعديل الإطار من الجهة اليمنى
  Widget _buildFeatureItem(String feature) {
    return
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: _buildRightBorderContainer(
            Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 18),
              SizedBox(width: 8),
              Expanded(child: Text(feature, style: TextStyle(fontSize: 16))),
            ],

        )
            ),
      );
  }

  // دالة لبناء تعليمات الاستخدام داخل إطار مع تعديل الإطار من الجهة اليمنى
  Widget _buildUsageInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstructionItem('قم بفتح التطبيق لتصفح التصنيفات المتاحة.'),
        _buildInstructionItem('اختر التصنيف الذي ترغب في تصفحه.'),
        _buildInstructionItem('اختر الرسالة المناسبة وشاركها مع من تحب.'),
        _buildInstructionItem('يمكنك التبديل بين التصنيفات بسهولة عبر الأزرار الموجودة في واجهة التطبيق.'),
      ],
    );
  }

  // دالة لبناء عنصر في تعليمات الاستخدام داخل إطار مع تعديل الإطار من الجهة اليمنى
  Widget _buildInstructionItem(String instruction) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: _buildRightBorderContainer( Row(
          children: [
            Icon(Icons.arrow_forward, color: Colors.blueAccent, size: 18),
            SizedBox(width: 8),
            Expanded(child: Text(instruction, style: TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }

  // دالة لبناء معلومات التقييم والدعم داخل إطار مع تعديل الإطار من الجهة اليمنى
  Widget _buildSupportInfo() {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blueAccent, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'نحن نحرص على تحسين تجربتك في استخدام التطبيق، لذلك ندعوك لتقييم التطبيق ومشاركة آرائك. إذا كان لديك أي استفسار أو اقتراح، يمكنك التواصل معنا عبر البريد الإلكتروني أو عبر وسائل التواصل الاجتماعي.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
