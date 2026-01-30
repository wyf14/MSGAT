import 'package:fakih/Model/wyf_app.dart';
import 'package:flutter/material.dart';
import 'package:fakih/l10n/localized_values.dart';

class AppInfoPage extends StatelessWidget {
  late ThemeData theme;
  String _selectedLanguage = 'العربية'; // اللغة الافتراضية

  initState() {
    // تحديد اللغة المختارة من الثيم أو التطبيق
    LanguagePreferences.getLanguage().then((lang) {
      _selectedLanguage = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizedValues[_selectedLanguage]!['about_app_title'] ??
            'معلومات عن التطبيق'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizedValues[_selectedLanguage]!['about_app_header'] ??
                  'معلومات عن تطبيق المسجات',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle(
                localizedValues[_selectedLanguage]!['about_app_intro_title'] ??
                    'مقدمة عن التطبيق:'),
            _buildRightBorderContainer(Text(
                localizedValues[_selectedLanguage]!['about_app_intro'] ??
                    'تطبيق المسجات هو تطبيق مميز...')),
            SizedBox(height: 20),
            _buildSectionTitle(localizedValues[_selectedLanguage]![
                    'about_app_features_title'] ??
                'المميزات الرئيسية للتطبيق:'),
            _buildFeatureList(_selectedLanguage),
            SizedBox(height: 20),
            _buildSectionTitle(
                localizedValues[_selectedLanguage]!['about_app_usage_title'] ??
                    'كيفية استخدام التطبيق:'),
            _buildUsageInstructions(_selectedLanguage),
            SizedBox(height: 20),
            _buildSectionTitle(localizedValues[_selectedLanguage]![
                    'about_app_support_title'] ??
                'التقييم والدعم:'),
            _buildSupportInfo(_selectedLanguage),
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
        // color: Colors.blueAccent,
      ),
    );
  }

  // دالة لإضافة إطار إضافي على الجهة اليمنى
  Widget _buildRightBorderContainer(Widget content) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          // USE COLOR FROM THEME
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            bottom: BorderSide(color: Colors.blueAccent, width: 1.0),
            right: BorderSide(color: Colors.blueAccent, width: 4.0),
          ),
        ),
        child: content);
  }

  // دالة لبناء قائمة المميزات داخل إطارات مع تعديل الإطار من الجهة اليمنى
  Widget _buildFeatureList(String lang) {
    final lz = localizedValues[lang]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeatureItem(lz['about_app_feature1'] ?? ''),
        _buildFeatureItem(lz['about_app_feature2'] ?? ''),
        _buildFeatureItem(lz['about_app_feature3'] ?? ''),
        _buildFeatureItem(lz['about_app_feature4'] ?? ''),
        _buildFeatureItem(lz['about_app_feature5'] ?? ''),
      ],
    );
  }

  // دالة لبناء عنصر في قائمة المميزات داخل إطار مع تعديل الإطار من الجهة اليمنى
  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: _buildRightBorderContainer(Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 18),
          SizedBox(width: 8),
          Expanded(child: Text(feature, style: TextStyle(fontSize: 16))),
        ],
      )),
    );
  }

  // دالة لبناء تعليمات الاستخدام داخل إطار مع تعديل الإطار من الجهة اليمنى
  Widget _buildUsageInstructions(String lang) {
    final lz = localizedValues[lang]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstructionItem(lz['about_app_usage1'] ?? ''),
        _buildInstructionItem(lz['about_app_usage2'] ?? ''),
        _buildInstructionItem(lz['about_app_usage3'] ?? ''),
        _buildInstructionItem(lz['about_app_usage4'] ?? ''),
      ],
    );
  }

  // دالة لبناء عنصر في تعليمات الاستخدام داخل إطار مع تعديل الإطار من الجهة اليمنى
  Widget _buildInstructionItem(String instruction) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: _buildRightBorderContainer(
        Row(
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
  Widget _buildSupportInfo(String lang) {
    final lz = localizedValues[lang]!;
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          right: BorderSide(color: Colors.blueAccent, width: 4.0),
          bottom: BorderSide(color: Colors.blueAccent, width: 1.0),
          top: BorderSide(color: Colors.blueAccent, width: 1.0),
          left: BorderSide(color: Colors.blueAccent, width: 4.0),
        ),
      ),
      child: Text(
        lz['about_app_support'] ?? '',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
