// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  final id = await studentDB.add(value);
  value.id = id;
  await studentDB.put(id, value);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
  getAllStudents();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
  studentListNotifier.value.sort((a, b) {
    return a.rollNo.toLowerCase().compareTo(b.rollNo.toLowerCase());
  });
}

Future<void> clearAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  studentListNotifier.value.clear();
  studentDB.clear();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  studentDB.delete(id);
  getAllStudents();
}

Future<void> editStudent(StudentModel studentData, int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  studentDB.put(id, studentData);
  getAllStudents();
}
