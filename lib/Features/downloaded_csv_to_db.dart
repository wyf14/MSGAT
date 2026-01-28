import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/DatabaseHelper.dart';
import 'check_for_update.dart';

Future<void> importCsvToDatabase(File file, String tableName) async { //TODO accept table name to insert
  final input = await file.readAsString();
  final rows = const CsvToListConverter().convert(input, eol: '\n');
  print("✅ تم استيراد البيانات بنجاح.$input");
  Clipboard.setData(ClipboardData(text: input));
  List<List<String>> data = DatabaseHelper.csvStringToList(input);
  await DatabaseHelper.insertListToDB(data, tableName);

  if (rows.length <= 1) return;

  final db = await DatabaseHelper.getDatabase();

  // for (int i = 1; i < rows.length; i++) {
  //   final row = rows[i];
  //   if (row.length >= 3) {
  //     final int sectionId = int.tryParse(row[0].toString()) ?? 0;
  //     final String messageAr = row[1].toString();
  //     final String messageEn = row[2].toString();
  //
  //     await db.insert(
  //       'messages',
  //       {
  //         'section_id': sectionId,
  //         'message_ar': messageAr,
  //         'message_en': messageEn,
  //       },
  //       conflictAlgorithm: ConflictAlgorithm.ignore,
  //     );
  //   }
  // }

  // showToast("✅ تم استيراد البيانات بنجاح.${rows.length}");
}
