import 'package:flutter/material.dart';

final _nameController = TextEditingController();
final _ageController = TextEditingController();
final _guardianController = TextEditingController();
final _placeController = TextEditingController();
final _rollNoController = TextEditingController();

class ListValues {
  List<TextEditingController> controller = [
    _nameController,
    _rollNoController,
    _placeController,
    _ageController,
    _guardianController,
  ];
  List hintText = ['Name', 'RollNo', 'Place', 'Age', 'Guardian Name'];
}
