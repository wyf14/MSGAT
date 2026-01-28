import 'package:flutter/material.dart';

class splash_body extends StatelessWidget {
  const splash_body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // اللون الأبيض للمؤشر
          ),
          SizedBox(height: 20),
          Text(
            "جارٍ تحميل البيانات...",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
