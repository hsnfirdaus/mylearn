import 'package:flutter/material.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/form/date_time_picker.dart';
import 'package:mylearn/components/form/input_label.dart';
import 'package:mylearn/components/form/select_my_subject.dart';
import 'package:mylearn/components/form/switch_input.dart';
import 'package:mylearn/components/toast.dart';
import 'package:mylearn/helpers/validator.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskScreenSheet extends StatefulWidget {
  final void Function() onSuccess;
  final bool isEdit;
  final Map<String, dynamic>? oldValue;

  const TaskScreenSheet({
    super.key,
    required this.onSuccess,
    this.isEdit = false,
    this.oldValue,
  });

  @override
  State<TaskScreenSheet> createState() => _TaskScreenSheetState();
}

class _TaskScreenSheetState extends State<TaskScreenSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _learningLink;
  late CustomController<Map<String, dynamic>> _subjectController;
  late CustomController<DateTime> _deadlineController;
  late CustomController<bool> _isSharedController;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _learningLink.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.oldValue?['title']);
    _descriptionController = TextEditingController(
      text: widget.oldValue?['description'],
    );
    _learningLink = TextEditingController(
      text: widget.oldValue?['learning_link'],
    );
    _subjectController = CustomController(value: widget.oldValue?['subject']);
    _deadlineController = CustomController(
      value:
          widget.oldValue?['deadline'] != null
              ? DateTime.parse(widget.oldValue?['deadline'])
              : null,
    );
    _isSharedController = CustomController(
      value:
          widget.oldValue?['is_shared'] != null
              ? widget.oldValue!['is_shared']
              : true,
    );
  }

  @override
  Widget build(BuildContext context) {
    void showError(String message) {
      context.errorToast(message);
    }

    void closeSheet() {
      Navigator.pop(context);
    }

    Future doSubmit() async {
      final supabase = Supabase.instance.client;

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final Map<dynamic, dynamic> dto = {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "semester_id": userProvider.semester!.id,
        "subject_id": _subjectController.subjectId,
        "class_id": userProvider.student!.classId,
        "student_nim": userProvider.student!.nim,
        "learning_link": _learningLink.text,
        "deadline": _deadlineController.value?.toIso8601String(),
        "is_shared": _isSharedController.value == true,
      };
      late dynamic res;

      if (widget.isEdit) {
        res = await supabase
            .from("subject_task")
            .update(dto)
            .eq("id", widget.oldValue!['id']);
      } else {
        res = await supabase.from("subject_task").insert(dto);
      }
      if (res?.error == null) {
        widget.onSuccess();
        closeSheet();
      } else {
        showError('Error: ${res.error.message}');
      }
    }

    final theme = context.appTheme;
    return Padding(
      padding: EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              widget.isEdit ? "Edit Tugas" : 'Tambah Tugas',
              style: theme.heading3,
            ),
            SizedBox(height: 12),
            Column(
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
                  validator: Validator.validate("Judul", [Validator.notEmpty]),
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
                  label: "Link E-Learning",
                  hintText: "(Opsional) https://learning-if.polibatam.ac.id/",
                  controller: _learningLink,
                  validator: Validator.validate("Link", [Validator.url]),
                ),
                SizedBox(height: 12),
                SwitchInput(
                  label: "Bagian tugas ke teman sekelas",
                  controller: _isSharedController,
                ),
                SizedBox(height: 12),
              ],
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
                        context.toast(
                          '${widget.isEdit ? "Menyimpan" : "Menambahkan"} tugas...',
                        );
                        doSubmit();
                      }
                    },
                    child: Text(widget.isEdit ? "Simpan" : "Tambah"),
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
