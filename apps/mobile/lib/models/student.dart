import 'package:mylearn/models/class.dart';

class Student {
  String nim;
  String userId;
  String name;
  String email;
  String classId;
  Class classItem;

  Student({
    required this.nim,
    required this.userId,
    required this.name,
    required this.email,
    required this.classId,
    required this.classItem,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    nim: json['nim'],
    userId: json['user_id'],
    name: json['name'],
    email: json['email'],
    classId: json['class_id'],
    classItem: Class.fromJson(json['class']),
  );
}
