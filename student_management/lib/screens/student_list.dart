import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/model/data_model.dart';
import 'package:student_management/screens/student_details.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext context, List<StudentModel> studentList,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final data = studentList[index];
                  return ListTile(
                    title: Text(
                      data.name,
                    ),
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: FileImage(
                            File(data.image!),
                          ),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentDetailsPage(),
                          ),
                        );
                      },
                      color: Colors.black,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: studentList.length);
          }),
    );
  }
}
