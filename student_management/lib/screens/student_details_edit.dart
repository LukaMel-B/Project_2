import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/model/data_model.dart';
import 'package:student_management/screens/student_details_page.dart';
import 'package:student_management/widgets/image_widget.dart';
import 'package:student_management/widgets/list_values.dart';

class StudentDetailsPage extends StatefulWidget {
  final String name;
  final int id;
  final String age;
  final String rollNo;
  final String dp;
  final String guardian;
  final String place;
  const StudentDetailsPage(
      {Key? key,
      required this.name,
      required this.age,
      required this.rollNo,
      required this.dp,
      required this.guardian,
      required this.place,
      required this.id})
      : super(key: key);

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  File? _image;
  late String _imageData;
  ListValues data = ListValues();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.name);
    final ageController = TextEditingController(text: widget.age);
    final guardianController = TextEditingController(text: widget.guardian);
    final placeController = TextEditingController(text: widget.place);
    final rollNoController = TextEditingController(text: widget.rollNo);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.teal[100],
        title: const Text(
          'Profile Edit',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: (_image != null)
                    ? ImageDisplay(
                        image: FileImage(_image!),
                        pickMedia: InkWell(
                            child: const Icon(
                              Icons.photo_library_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            onTap: () {
                              pickMedia();
                            }),
                      )
                    : ImageDisplay(
                        image: FileImage(File(widget.dp)),
                        pickMedia: InkWell(
                            child: const Icon(
                              Icons.photo_library_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            onTap: () {
                              pickMedia();
                            }),
                      ),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter Full Name!";
                        } else {
                          return null;
                        }
                      }),
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter the Roll No!";
                        } else {
                          return null;
                        }
                      }),
                      controller: rollNoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Roll No',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter the Place!";
                        } else {
                          return null;
                        }
                      }),
                      controller: placeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Place',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter the Age!";
                        } else {
                          return null;
                        }
                      }),
                      controller: ageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Age',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter Guardian Name!";
                        } else {
                          return null;
                        }
                      }),
                      controller: guardianController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Guardian Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[100],
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          onAddStudentButtonClicked(
                              nameController,
                              ageController,
                              placeController,
                              rollNoController,
                              guardianController);
                        } else {
                          return;
                        }
                      },
                      child: const Text(
                        'Edit Student',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickMedia() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    _imageData = image.path;
    final imageTemp = File(image.path);
    setState(() {
      _image = imageTemp;
    });
  }

  void clearField() {
    setState(() {
      for (var i = 0; i < 5; i++) {
        data.controller[i].clear();
      }
    });
  }

  void onAddStudentButtonClicked(
      TextEditingController nameController,
      TextEditingController ageController,
      TextEditingController placeController,
      TextEditingController rollNoController,
      TextEditingController guardianController) {
    if (_image == null) {
      _imageData = widget.dp;
    }
    final student = StudentModel(
      name: nameController.text.trim(),
      rollNo: rollNoController.text.trim(),
      place: placeController.text.trim(),
      age: ageController.text.trim(),
      guardian: guardianController.text.trim(),
      id: widget.id,
      image: _imageData,
    );
    editStudent(
      student,
      widget.id,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetails(
          age: student.age,
          guardian: student.guardian,
          name: student.name,
          rollNo: student.rollNo,
          id: widget.id,
          place: student.place,
          img: _imageData,
        ),
      ),
    );
    clearField();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.teal[100],
        content: Text(
          "You Edited student:${student.name}'s details",
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
