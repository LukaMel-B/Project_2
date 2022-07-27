import 'package:flutter/material.dart';
import 'package:student_management/widgets/list_values.dart';

// ignore: must_be_immutable
class TextFormWidget extends StatelessWidget {
  final String name;
  final String age;
  final String rollNo;
  final String guardian;
  final String place;
  TextFormWidget(
      {Key? key,
      required this.name,
      required this.age,
      required this.rollNo,
      required this.guardian,
      required this.place})
      : super(key: key);

  ListValues data = ListValues();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return "Required!";
              } else {
                return null;
              }
            }),

            //  initialValue: initText[index],
            controller: data.controller[index],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: data.hintText[index],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
        itemCount: 5);
  }
}
