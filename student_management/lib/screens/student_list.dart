import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_management/db/functions/db_functions.dart';
import 'package:student_management/db/model/data_model.dart';
import 'package:student_management/screens/student_details_page.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final searchController = TextEditingController();
  String query = '';
  List<StudentModel> studentSearchList = studentListNotifier.value.toList();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext context, List<StudentModel> studentList,
              Widget? child) {
            return (studentList.isEmpty)
                ? const Center(
                    child: Text('No student Data found'),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: searchController,
                          onChanged: ((value) {
                            final student =
                                studentListNotifier.value.where((element) {
                              final nameLower = element.name.toLowerCase();
                              final rollNoLower = element.rollNo.toLowerCase();
                              final search = value.toLowerCase();
                              return nameLower.contains(search) ||
                                  rollNoLower.contains(search);
                            }).toList();
                            setState(() {
                              query = value;
                              studentSearchList = student;
                            });
                          }),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Name or Roll No',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 600,
                        child: (query.isEmpty == false &&
                                studentSearchList.isEmpty)
                            ? const Center(
                                child: Text('No student Data found'),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  final data = (query.isEmpty)
                                      ? studentList[index]
                                      : studentSearchList[index];
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: Text(data.name),
                                              content: const Text(
                                                  'Choose from below actions to perform on the student'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CupertinoAlertDialog(
                                                          title: const Text(
                                                              'Delete Student!'),
                                                          content: const Text(
                                                              'Do you confirm that you want to delete the student from list?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context,
                                                                      'Cancel'),
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                deleteStudent(
                                                                    data.id!);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  backgroundColor:
                                                                      Colors.teal[
                                                                          100],
                                                                  content: Text(
                                                                    "You deleted student '${data.name}'",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              2),
                                                                ));
                                                              },
                                                              child: const Text(
                                                                'Delete',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text('Delete'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            StudentDetails(
                                                          id: data.id!,
                                                          age: data.age,
                                                          img: data.image,
                                                          guardian:
                                                              data.guardian,
                                                          name: data.name,
                                                          place: data.place,
                                                          rollNo: data.rollNo,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                      'Show Details'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: ListTile(
                                        //subtitle: Text(data.id.toString()),
                                        title: Text(
                                          data.name,
                                        ),
                                        subtitle:
                                            Text("Roll No: ${data.rollNo}"),
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            image: DecorationImage(
                                              image: FileImage(
                                                File(data.image),
                                              ),
                                            ),
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.black,
                                        )),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: (query.isEmpty)
                                    ? studentList.length
                                    : studentSearchList.length),
                      ),
                    ],
                  );
          }),
    );
  }
}
