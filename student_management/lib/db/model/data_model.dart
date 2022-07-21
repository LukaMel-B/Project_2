import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 2)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(4)
  final String age;

  @HiveField(2)
  final String rollNo;

  @HiveField(6)
  String? image;

  @HiveField(5)
  final String guardian;

  @HiveField(3)
  final String place;

  StudentModel(
      {this.id,
      this.image,
      required this.rollNo,
      required this.name,
      required this.age,
      required this.guardian,
      required this.place});
}
