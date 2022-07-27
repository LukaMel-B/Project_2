import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/model/data_model.dart';
import 'package:student_management/screens/home_screen.dart';
import 'package:student_management/widgets/image_widget.dart';
import 'package:student_management/widgets/list_values.dart';
import 'package:student_management/widgets/text_reader.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  File? _image;
  late String _imageData;
  ListValues data = ListValues();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            clearField();
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
        title: const Text(
          'Add Student',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.teal[100],
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
                        image: const AssetImage('assets/images/dp_default.png'),
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
                    SizedBox(
                      height: 400,
                      child: Textreader(),
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
                          onAddStudentButtonClicked();
                        } else {
                          return;
                        }
                      },
                      child: const Text(
                        'Add Student',
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

  void onAddStudentButtonClicked() {
    if (_image == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text(
                'Warning!',
                style: TextStyle(color: Colors.red),
              ),
              content: const Text(
                  'You did not pick a image, Please choose a image from gallery.'),
              actions: [
                TextButton(
                    onPressed: () {
                      pickMedia();
                      Navigator.pop(context);
                    },
                    child: const Text('Select Image'))
              ],
            );
          });
    } else {
      final student = StudentModel(
        name: data.controller[0].text.trim(),
        rollNo: data.controller[1].text.trim(),
        place: data.controller[2].text.trim(),
        age: data.controller[3].text.trim(),
        guardian: data.controller[4].text.trim(),
        image: _imageData,
      );
      addStudent(student);
      getAllStudents();
      clearField();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScreenHome(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.teal[100],
          content: const Text(
            "You Added a  student",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
