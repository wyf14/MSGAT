import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("عنّا")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/makeen.png"), // استبدلها بصورة مناسبة لك
              onBackgroundImageError: (exception, stackTrace) {
                // Handle image load failure
                print('Error loading profile image');
              },
            ),
            SizedBox(height: 16),
            Text(
              "Waleed AlFakih",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Professional app developer with a strong background in team management and artificial intelligence. Previously worked as a teaching assistant and software developer, contributing to the development of innovative technological solutions in various fields."  ,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.email),
              label: Text("تواصل معي"),
              onPressed: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'w.fakih@asasmakeen.com',
                  query: 'subject=استفسار&body=مرحبا وليد،',
                );
                if (await canLaunch(emailUri.toString())) {
                  await launch(emailUri.toString());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("لا يمكن فتح البريد الإلكتروني")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
