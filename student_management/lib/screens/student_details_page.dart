import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_management/screens/home_screen.dart';
import 'package:student_management/screens/student_details_edit.dart';

class StudentDetails extends StatelessWidget {
  final String name;
  final String img;
  final int id;
  final String age;
  final String place;
  final String rollNo;
  final String guardian;
  const StudentDetails(
      {Key? key,
      required this.name,
      required this.img,
      required this.id,
      required this.age,
      required this.place,
      required this.guardian,
      required this.rollNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDetailsPage(
                id: id,
                age: age,
                dp: img,
                guardian: guardian,
                name: name,
                place: place,
                rollNo: rollNo,
              ),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Edit',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Icon(
              Icons.arrow_right_alt_rounded,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenHome(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.teal[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(File(img)),
            ),
            const SizedBox(),
            Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.teal[100],
              ),
              height: 250,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    List values = [
                      'Name:  $name',
                      'Roll No:  $rollNo',
                      'Place:  $place',
                      'Age:  $age',
                      'Guardian:  $guardian'
                    ];
                    return Text(
                      values[index],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: 5),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
