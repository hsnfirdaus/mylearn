class Student {
  String nim;
  String userId;
  String name;
  String email;
  String classId;

  Student({
    required this.nim,
    required this.userId,
    required this.name,
    required this.email,
    required this.classId,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    nim: json['nim'],
    userId: json['user_id'],
    name: json['name'],
    email: json['email'],
    classId: json['class_id'],
  );
}
