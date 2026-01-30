import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import '../Features/check_for_update.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = "MsgatDB.db";

  // للحصول على قاعدة البيانات
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // تهيئة قاعدة البيانات
  static Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, dbName);

    bool dbExists = await File(dbPath).exists();

    if (!dbExists) {
      ByteData data = await rootBundle.load("assets/$dbName");
      List<int> bytes = data.buffer.asUint8List();
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(dbPath);
  }

  // إدخال البيانات في الجدول
  static Future<void> insertData(
      String tableName, Map<String, dynamic> data) async {
    final db = await getDatabase();
    await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // تحميل ملف CSV وإضافته إلى قاعدة البيانات
  static Future<void> loadCsvToDatabase() async {
    // await processCsvFile("messages", "hadith_messages");
    // await processCsvFile("messages", "ataab_messages");
    // await processCsvFile("messages", "feraq_messages");
    // await processCsvFile("messages", "gazal_messages");
    // await processCsvFile("messages", "ishq_messages");
    // await processCsvFile("messages", "nsay7_hekm");

    await processCsvFile("messages", "baby_messages");
    await processCsvFile("messages", "tips_messages");
    await processCsvFile("messages", "optimism_messages");
    await processCsvFile("messages", "blessing_messages");
    await processCsvFile("messages", "be_positive_messages");
    await processCsvFile("messages", "marriage_messages");
    await processCsvFile("messages", "eid_alfitr_messages");
    await processCsvFile("messages", "eid_aladha_messages");
    await processCsvFile("messages", "friday_messages");
    await processCsvFile("messages", "success_messages");
    await processCsvFile("messages", "house_messages");
    await processCsvFile("messages", "car_messages");
    await processCsvFile("messages", "secondary_messages");
    await processCsvFile("messages", "medical_university_messages");
    await processCsvFile("messages", "technology_university_messages");
    await processCsvFile("messages", "shoq_messages");
  }

  // معالجة ملف CSV وإدخال بياناته في قاعدة البيانات
  static Future<void> processCsvFile(
      String tableName, String csvFileName) async {
    try {
      // استخدام الدالة المعدلة لتحميل البيانات مع الصف الأول
      List<List<String>> rows = await loadCSVFromAssets(csvFileName);

      await insertListToDB(rows, tableName);
    } catch (e) {
      print('حدث خطأ أثناء إدخال بيانات CSV إلى قاعدة البيانات: $e');
      showToast("حدث خطأ أثناء تحميل البيانات: $e");
    }
  }

  static Future<void> insertListToDB(
      List<List<String>> rows, String tableName) async {
    if (rows.isNotEmpty) {
      // استخراج أسماء الأعمدة من أول صف
      List<String> columnNames = rows.first.map((e) => e.toString()).toList();
      rows.removeAt(0); // إزالة الصف الأول (أسماء الأعمدة)

      // التحقق من وجود بيانات بعد الصف الأول
      if (rows.isEmpty) {
        print("الملف لا يحتوي على بيانات بعد أسماء الأعمدة.");
        showToast("لا توجد بيانات لتحميلها!");
        return;
      }

      showToast("تم تحميل ${rows.length} صفوف");

      // إدخال البيانات في قاعدة البيانات
      final db = await getDatabase();
      await db.transaction((txn) async {
        for (var row in rows) {
          Map<String, dynamic> rowData = {}; // خريطة لتخزين البيانات

          // تعيين القيم بناءً على أسماء الأعمدة
          for (int i = 0; i < columnNames.length; i++) {
            // التأكد من أن الصف يحتوي على القيمة المتوقعة في نفس الموضع
            if (i < row.length) {
              rowData[columnNames[i]] = row[i]; // إضافة القيم من الصف الحالي
            }
          }

          // إدخال البيانات في قاعدة البيانات
          await txn.insert(tableName, rowData,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      });

      return;
    } else {
      print("الملف فارغ أو لا يحتوي على بيانات.");
      showToast("الملف فارغ أو لا يحتوي على بيانات");
      return;
    }
  }

  // دالة تحميل CSV مع الصف الأول
  static Future<List<List<String>>> loadCSVFromAssets(
      String csvFileName) async {
    String csvFilePath = "assets/csv/$csvFileName.csv";
    String csvData = await rootBundle.loadString(csvFilePath);

    // تقسيم البيانات إلى صفوف
    List<List<String>> data = csvStringToList(csvData);

    return data;
  }

  static List<List<String>> csvStringToList(String csvData) {
    // تقسيم البيانات إلى صفوف
    List<String> rows = csvData.split('\n');

    // تخزين جميع الصفوف بما في ذلك الصف الأول (الرؤوس)
    List<List<String>> data = [];
    for (int i = 0; i < rows.length; i++) {
      List<String> columns = rows[i].split(','); //   الفواصل هي الفاصلة (',')
      data.add(columns);
    }
    return data;
  }

  // دالة للتحقق إذا كانت الرسالة موجودة في المفضلة
  static Future<bool> isFavorite(int messageId) async {
    final db = await getDatabase();
    final result = await db.query(
      'favs', // اسم جدول المفضلة
      where: 'msg_id = ?',
      whereArgs: [messageId],
    );
    return result.isNotEmpty;
  }

  // دالة لإضافة رسالة إلى المفضلة
  static Future<void> addToFavorites(int messageId) async {
    final db = await getDatabase();
    await db.insert(
      'favs', // اسم جدول المفضلة
      {
        'msg_id': messageId
      }, // هنا نفترض أن هناك عمود message_id في جدول المفضلة
      conflictAlgorithm:
          ConflictAlgorithm.replace, // في حالة وجود نفس السجل يتم استبداله
    );
  }

  // دالة لحذف الرسالة من المفضلة
  static Future<void> removeFromFavorites(int messageId) async {
    final db = await getDatabase();
    await db.delete(
      'favs', // اسم جدول المفضلة
      where: 'msg_id = ?',
      whereArgs: [messageId],
    );
  }

  // دالة لإضافة أو إزالة الرسالة من المفضلة بناءً على حالتها
  static Future<void> addFav(int messageId) async {
    bool alreadyFav = await isFavorite(messageId);

    if (!alreadyFav) {
      await addToFavorites(messageId);
      print('✅ تمت الإضافة إلى المفضلة');
    } else {
      await removeFromFavorites(messageId);
      print('❌ تمت الإزالة من المفضلة');
    }
  }

  static Future<List<Map<String, dynamic>>> loadMessagesBySection(
      int sectionId, String messageColumn) async {
    final db = await getDatabase();
    final fetchedMessages = await db.query(
      'messages',
      columns: [messageColumn, 'id'],
      where: 'section_id = ?',
      whereArgs: [sectionId],
    );
    return fetchedMessages;
  }

  static Future<Set<int>> loadFavorites() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> favs = await db.query('favs');
    return favs.map((f) => f['msg_id'] as int).toSet();
  }
}
