import 'package:flutter/material.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/screens/add_student.dart';
import 'package:student_management/screens/student_list.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(
          Icons.add_rounded,
          size: 35,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudentScreen(),
            ),
          );
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 3,
        title: const Text(
          'Student App',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.teal[100],
      ),
      body: const StudentList(),
    );
  }
}
