class Class {
  String id;
  String studyProgramCode;
  int semester;
  String classGroup;
  String sessionType;
  int admissionYear;
  String fullClassName;

  Class({
    required this.id,
    required this.studyProgramCode,
    required this.semester,
    required this.classGroup,
    required this.sessionType,
    required this.admissionYear,
    required this.fullClassName,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    id: json['id'],
    studyProgramCode: json['study_program_code'],
    semester: json['semester'],
    classGroup: json['class_group'],
    sessionType: json['session_type'],
    admissionYear: json['admission_year'],
    fullClassName: json['full_class_name'],
  );
}
