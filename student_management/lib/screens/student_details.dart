import 'package:flutter/material.dart';

class StudentDetailsPage extends StatelessWidget {
  const StudentDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
