import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'downloadCsv.dart';
import 'downloaded_csv_to_db.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
// الزامي في كل جدول من الـ فايربيس يوجد فيرجن و يو ار ال
Future<void> checkAndUpdateMessages(String tableName) async {
  final dbRef = FirebaseDatabase.instance.ref('updates/$tableName');
  final snapshot = await dbRef.get();

  if (!snapshot.exists) {
    showToast("⚠️ لم يتم العثور على بيانات التحديث.");
    return;
  }

  final data = snapshot.value as Map;
  final int remoteVersion = data['version'] ?? 0;
  final List<String> fileUrls =List<String>.from(data['urls'] ?? '');

  final prefs = await SharedPreferences.getInstance();
  final int localVersion = prefs.getInt('local_version') ?? 0;

  if (true) {// TODO remoteVersion > localVersion && fileUrl.isNotEmpty
    showToast("📥 تحديث جديد متاح، جاري التحميل...");
    var file;
    for(String fileUrl in fileUrls) {
      file = await downloadCsvFromUrl(fileUrl, '$tableName.csv');
      if (file != null) {
        await importCsvToDatabase(file, tableName);
        await saveNewVersion(remoteVersion);
        showToast("✅ تم تحديث الرسائل إلى النسخة $remoteVersion");
      } else {
        showToast("❌ فشل تحميل الملف من الرابط.");
      }
    }
  } else {
    showToast("ℹ️ لا يوجد تحديث جديد.");
  }
}
Future<void> saveNewVersion(int newVersion) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('local_version', newVersion);
}
