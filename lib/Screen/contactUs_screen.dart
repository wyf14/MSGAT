import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  Future<void> _sendEmail() async {
    final message = _messageController.text;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'wyf1414@gmail.com',
      queryParameters: {
        'subject': 'تطبيق المسجات',
        'body':message,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر إرسال البريد الإلكتروني')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تواصل معنا')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'الموضوع'),
                maxLines: 4,

              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'رسالتك'),
                maxLines: 4,
                validator: (value) => value!.isEmpty ? 'يرجى إدخال رسالة' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendEmail();
                  }
                },
                child: Text('إرسال'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
