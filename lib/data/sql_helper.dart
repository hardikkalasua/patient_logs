import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:core';
import 'models.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE patients (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        sex TEXT,
        avatar TEXT,
        age INTEGER,
        complaint TEXT,
        contact TEXT,
        notes TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);

    await database.execute("""
      CREATE TABLE case_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        uri TEXT,
        title TEXT,
        description TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        notes TEXT,
        patient_id INTEGER NOT NULL,
        FOREIGN KEY (patient_id) REFERENCES patients (id)
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'patient_logs_database.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createPatient(Patient patient) async {
    final db = await SQLHelper.db();
    final data = patient.toMap();
    final id = await db.insert('patients', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Patient>> getPatients() async {
    final db = await SQLHelper.db();
    final data = await db.query('patients', orderBy: "id");
    return data.map((patient) => Patient.fromMap(patient)).toList();
  }

  static Future<int> updatePatient(Patient patient) async {
    final db = await SQLHelper.db();
    final data = patient.toMap();
    final result = await db
        .update('patients', data, where: "id = ?", whereArgs: [patient.id]);
    return result;
  }

  static Future<void> deletePatient(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("patients", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a patient: $err");
    }
  }

  static Future<int> createCaseImage(CaseImage caseImage) async {
    final db = await SQLHelper.db();
    final data = caseImage.toMap();
    final id = await db.insert('case_images', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<CaseImage>> getCaseImages(int patientId) async {
    final db = await SQLHelper.db();
    final data = await db.query('case_images',
        where: "patient_id = ?", whereArgs: [patientId], orderBy: "id");
    return data.map((caseImage) => CaseImage.fromMap(caseImage)).toList();
  }

  static Future<int> updateCaseImage(CaseImage caseImage) async {
    final db = await SQLHelper.db();
    final data = caseImage.toMap();
    final result = await db.update('case_images', data,
        where: "id = ?", whereArgs: [caseImage.id]);
    return result;
  }

  static Future<void> deleteCaseImage(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("case_images", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a case image: $err");
    }
  }
}
