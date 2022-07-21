import 'package:flutter/material.dart';
import 'package:student_management/widgets/list_values.dart';

// ignore: must_be_immutable
class Textreader extends StatelessWidget {
  Textreader({Key? key}) : super(key: key);
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
