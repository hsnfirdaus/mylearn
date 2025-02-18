class Semester {
  String id;
  String name;
  DateTime startDate;
  DateTime endDate;
  bool isActive;

  Semester({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
    id: json['id'],
    name: json['name'],
    startDate: DateTime.parse(json['start_date']),
    endDate: DateTime.parse(json['end_date']),
    isActive: json['is_active'],
  );
}
