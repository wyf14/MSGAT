import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:csv/csv.dart'; // حزمة CSV لقراءة الملف

class DatabaseHelper {
  static Database? _database;
  static const String dbName = "MsgatDB.db";

  // دالة لجلب قاعدة البيانات
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  // دالة لتهيئة قاعدة البيانات
  static Future<Database> initDatabase() async {
    // تحديد مسار قاعدة البيانات في التخزين المحلي
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, dbName);

    // التحقق مما إذا كانت قاعدة البيانات موجودة مسبقًا
    bool dbExists = await File(dbPath).exists();

    if (!dbExists) {
      // نسخ قاعدة البيانات من الـ assets إلى المسار المحلي
      ByteData data = await rootBundle.load("assets/$dbName");
      List<int> bytes = data.buffer.asUint8List();
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    // فتح قاعدة البيانات
    return await openDatabase(dbPath);
  }

  // دالة لإغلاق قاعدة البيانات
  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // دالة لتحميل بيانات CSV إلى قاعدة البيانات
  static Future<void> loadCSVData() async {
    // تحميل البيانات من الملفات الثلاثة
    await loadCategories();
    await loadSections();
    await loadMessages();
  }

  // دالة لتحميل بيانات categories
  static Future<void> loadCategories() async {
    final ByteData data = await rootBundle.load('assets/csv/categories.csv');
    final List<int> bytes = data.buffer.asUint8List();
    final String csvString = String.fromCharCodes(bytes);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

    final db = await getDatabase();

    for (int i = 1; i < csvTable.length; i++) {
      var row = csvTable[i];
      Map<String, dynamic> data = {
        'id': row[0],
        'name_ar': row[1],
        'name_en': row[2],
        'background': row[3],
        'timestamp': row[4],
      };
      await db.insert('categories', data, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // دالة لتحميل بيانات sections
  static Future<void> loadSections() async {
    final ByteData data = await rootBundle.load('assets/csv/sections.csv');
    final List<int> bytes = data.buffer.asUint8List();
    final String csvString = String.fromCharCodes(bytes);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

    final db = await getDatabase();

    for (int i = 1; i < csvTable.length; i++) {
      var row = csvTable[i];
      Map<String, dynamic> data = {
        'id': row[0],
        'category_id': row[1],
        'name_ar': row[2],
        'name_en': row[3],
        'background': row[4],
        'timestamp': row[5],
      };
      await db.insert('sections', data, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // دالة لتحميل بيانات messages
  static Future<void> loadMessages() async {
    final ByteData data = await rootBundle.load('assets/csv/messages.csv');
    final List<int> bytes = data.buffer.asUint8List();
    final String csvString = String.fromCharCodes(bytes);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

    final db = await getDatabase();

    for (int i = 1; i < csvTable.length; i++) {
      var row = csvTable[i];
      Map<String, dynamic> data = {
        'id': row[0],
        'section_id': row[1],
        'message_ar': row[2],
        'message_en': row[3],
        'timestamp': row[4],
      };
      await db.insert('messages', data, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
