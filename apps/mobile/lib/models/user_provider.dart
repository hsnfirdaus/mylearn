import 'package:flutter/material.dart';
import 'package:mylearn/models/student.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  Student? _student;

  Student? get student => _student;

  void setStudent(Student? newStudent) {
    _student = newStudent;
    notifyListeners();
  }

  Future refreshStudent() async {
    final supabase = Supabase.instance.client;
    if (supabase.auth.currentUser == null) {
      setStudent(null);
      return;
    }
    final student = await supabase
        .from("student")
        .select(
          "nim, user_id, name, email, class_id, class (id, study_program_code, semester, class_group, session_type, admission_year, full_class_name)",
        )
        .eq("user_id", supabase.auth.currentUser!.id);
    if (student.isEmpty) {
      setStudent(null);
      return;
    }
    final parsedStudent = Student.fromJson(student.first);
    setStudent(parsedStudent);
  }
}
