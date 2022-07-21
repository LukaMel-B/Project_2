// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  final id = await studentDB.add(value);
  print(studentDB.values);
  value.id = id;
  studentListNotifier.value.add(value);
  await studentDB.put(id, value);
  studentListNotifier.notifyListeners();
  print(value.name);
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> clearAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  studentListNotifier.value.clear();
  studentDB.clear();
}

Future<void> deleteStudent(StudentModel db, int index, int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_dataBase');
  //studentDB.putAt(index, db);
  studentDB.delete(id);
  getAllStudents();
}
