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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDrawerDark = theme.brightness == Brightness.dark;
    final drawerBg = isDrawerDark
        ? colorScheme.surface.withOpacity(0.85)
        : colorScheme.surface.withOpacity(0.65);
    final iconColor = colorScheme.primary;
    final borderColor = colorScheme.primary;
    final tileColor = colorScheme.primary.withOpacity(0.13);
    final hoverColor = colorScheme.primary.withOpacity(0.18);
    final textColor =
        isDrawerDark ? colorScheme.onSurface : colorScheme.onSurface;

    return Drawer(
      backgroundColor: drawerBg,
      elevation: 0,
      child: Column(
        children: [
          const SizedBox(height: 40),
          // زر تبديل الثيم (شمس/قمر)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: ListTile(
              leading: Icon(
                  isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round,
                  color: iconColor,
                  size: 30),
              title: Text(
                isDark
                    ? (selectedLanguage == 'العربية'
                        ? 'وضع النهار'
                        : 'Light Mode')
                    : (selectedLanguage == 'العربية'
                        ? 'وضع الليل'
                        : 'Dark Mode'),
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              onTap: onThemeToggle,
              shape:
                  StadiumBorder(side: BorderSide(color: borderColor, width: 1)),
              tileColor: tileColor,
              hoverColor: hoverColor,
            ),
          ),
          // زر تبديل اللغة
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: ListTile(
              leading: Icon(Icons.language, color: iconColor, size: 28),
              title: Text(
                selectedLanguage == 'العربية' ? 'English' : 'العربية',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              onTap: onLanguageToggle,
              shape:
                  StadiumBorder(side: BorderSide(color: borderColor, width: 1)),
              tileColor: tileColor,
              hoverColor: hoverColor,
            ),
          ),
          // زر تواصل
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: ListTile(
              leading: Icon(Icons.email_outlined, color: iconColor, size: 28),
              title: Text(
                selectedLanguage == 'العربية' ? 'تواصل معنا' : 'Contact Us',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              onTap: onContact,
              shape:
                  StadiumBorder(side: BorderSide(color: borderColor, width: 1)),
              tileColor: tileColor,
              hoverColor: hoverColor,
            ),
          ),
          // زر مشاركة التطبيق
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: ListTile(
              leading: Icon(Icons.share, color: iconColor, size: 28),
              title: Text(
                selectedLanguage == 'العربية' ? 'مشاركة التطبيق' : 'Share App',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              onTap: onShare,
              shape:
                  StadiumBorder(side: BorderSide(color: borderColor, width: 1)),
              tileColor: tileColor,
              hoverColor: hoverColor,
            ),
          ),
        ],
      ),
    );
  }
}
