import 'package:flutter/material.dart';
import '../Model/language_provider.dart';
import '../Model/wyf_app.dart';
import '../Screen/contactUs_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class CustomAppDrawer extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageToggle;
  final VoidCallback onContact;
  final VoidCallback onShare;
  final String selectedLanguage;

  const CustomAppDrawer({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
    required this.onLanguageToggle,
    required this.onContact,
    required this.onShare,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black.withOpacity(0.50),
      elevation: 0,
      child: Column(
        children: [
          const SizedBox(height: 40),
          // زر تبديل الثيم (شمس/قمر)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: ListTile(
              leading: Icon(isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round, color: Colors.orange, size: 30),
              title: Text(
                isDark
                    ? (selectedLanguage == 'العربية' ? 'وضع النهار' : 'Light Mode')
                    : (selectedLanguage == 'العربية' ? 'وضع الليل' : 'Dark Mode'),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: onThemeToggle,
              shape: StadiumBorder(side: BorderSide(color: Colors.orange, width: 1)),
              tileColor: Colors.orange.withOpacity(0.13),
              hoverColor: Colors.orange.withOpacity(0.18),
            ),
          ),
          // زر تبديل اللغة
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: ListTile(
              leading: Icon(Icons.language, color: Colors.orange, size: 28),
              title: Text(
                selectedLanguage == 'العربية' ? 'English' : 'العربية',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: onLanguageToggle,
              shape: StadiumBorder(side: BorderSide(color: Colors.orange, width: 1)),
              tileColor: Colors.orange.withOpacity(0.13),
              hoverColor: Colors.orange.withOpacity(0.18),
            ),
          ),
          // زر تواصل
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: ListTile(
              leading: Icon(Icons.email_outlined, color: Colors.orange, size: 28),
              title: Text(
                selectedLanguage == 'العربية' ? 'تواصل معنا' : 'Contact Us',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: onContact,
              shape: StadiumBorder(side: BorderSide(color: Colors.orange, width: 1)),
              tileColor: Colors.orange.withOpacity(0.13),
              hoverColor: Colors.orange.withOpacity(0.18),
            ),
          ),
          // زر مشاركة التطبيق
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: ListTile(
              leading: Icon(Icons.share, color: Colors.orange, size: 28),
              title: Text(
                selectedLanguage == 'العربية' ? 'مشاركة التطبيق' : 'Share App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: onShare,
              shape: StadiumBorder(side: BorderSide(color: Colors.orange, width: 1)),
              tileColor: Colors.orange.withOpacity(0.13),
              hoverColor: Colors.orange.withOpacity(0.18),
            ),
          ),
        ],
      ),
    );
  }
}
