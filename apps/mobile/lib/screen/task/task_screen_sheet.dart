import 'package:flutter/material.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/form/date_time_picker.dart';
import 'package:mylearn/components/form/input_label.dart';
import 'package:mylearn/components/form/select_my_subject.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskScreenSheet extends StatefulWidget {
  final void Function() onSuccess;

  const TaskScreenSheet({super.key, required this.onSuccess});

  @override
  State<TaskScreenSheet> createState() => _TaskScreenSheetState();
}

class _TaskScreenSheetState extends State<TaskScreenSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final CustomController<Map<String, dynamic>> _subjectController =
      CustomController();
  final CustomController<DateTime> _deadlineController = CustomController();

  @override
  Widget build(BuildContext context) {
    void showError(String message) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    void closeSheet() {
      Navigator.pop(context);
    }

    Future doSubmit() async {
      final supabase = Supabase.instance.client;

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final res = await supabase.from("subject_task").insert({
        "title": _titleController.text,
        "description": _descriptionController.text,
        "semester_id": userProvider.semester!.id,
        "subject_id": _subjectController.subjectId,
        "class_id": userProvider.student!.classId,
        "student_nim": userProvider.student!.nim,
        "learning_link": _linkController.text,
        "deadline": _deadlineController.value?.toIso8601String(),
      });
      if (res?.error == null) {
        widget.onSuccess();
        closeSheet();
      } else {
        showError('Error: ${res.error.message}');
      }
    }

    final theme = context.appTheme;
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Tambah Tugas', style: theme.heading3),
            SizedBox(height: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectMySubject(
                    label: "Pilih Mata Kuliah",
                    controller: _subjectController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Silahkan pilih mata kuliah!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  InputLabel(
                    label: "Judul",
                    hintText: "Tugas Minggu 2 PBD",
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Judul tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  InputLabel(
                    label: "Deskripsi",
                    hintText: "(Opsional)",
                    controller: _descriptionController,
                    minLines: 2,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 12),
                  DateTimePicker(
                    label: "Batas Pengerjaan",
                    controller: _deadlineController,
                  ),
                  SizedBox(height: 12),
                  InputLabel(
                    label: "Link",
                    hintText: "(Opsional) https://learning-if.polibatam.ac.id/",
                    controller: _linkController,
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Menambahkan tugas...')),
                        );
                        doSubmit();
                      }
                    },
                    child: const Text("Tambah"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
