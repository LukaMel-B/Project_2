import 'package:flutter/material.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/screens/add_student.dart';
import 'package:student_management/screens/student_list.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    //clearAllStudents();
    getAllStudents();
    super.initState();
  }

  final controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //clearAllStudents();
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.teal[100], shape: const CircleBorder()),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudentScreen(),
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.add_rounded,
            color: Colors.black,
            size: 37,
          ),
        ),
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
