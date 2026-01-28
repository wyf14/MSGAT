import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'check_for_update.dart';

Future<File?> downloadCsvFromUrl(String url, String fileName) async {
  try {
    final response = await HttpClient().getUrl(Uri.parse(url));
    final result = await response.close();

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$fileName");

    await result.pipe(file.openWrite());
    return file;
  } catch (e) {
    showToast("❌ فشل تحميل الملف: $e");
    return null;
  }
}
