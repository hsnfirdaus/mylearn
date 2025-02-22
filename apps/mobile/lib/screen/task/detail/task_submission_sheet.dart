import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/form/choice_picker.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/form/input_label.dart';
import 'package:mylearn/components/toast.dart';
import 'package:mylearn/helpers/format.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskSubmissionSheet extends StatefulWidget {
  final void Function() onSuccess;
  final String subjectTaskId;
  final String? initialNote;
  final String? initialStatus;

  const TaskSubmissionSheet({
    super.key,
    required this.onSuccess,
    required this.subjectTaskId,
    this.initialNote,
    this.initialStatus,
  });

  @override
  State<TaskSubmissionSheet> createState() => _TaskSubmissionSheetState();
}

class _TaskSubmissionSheetState extends State<TaskSubmissionSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _noteController = TextEditingController(
    text: widget.initialNote,
  );
  late final CustomController<String> _statusController = CustomController(
    value: widget.initialStatus,
  );

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
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

      final res = await supabase.from("subject_task_student").upsert({
        "student_nim": userProvider.student!.nim,
        "task_id": widget.subjectTaskId,
        "status": _statusController.value,
        "note": _noteController.text,
        "updated_at": DateTime.now().toIso8601String(),
      }, onConflict: "student_nim,task_id");
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
          children: [
            Text('Ubah Pengerjaan', style: theme.heading3),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChoicePicker(
                  label: "Status",
                  controller: _statusController,
                  items: [
                    ChoicePickerItem(
                      icon: LucideIcons.circleAlert,
                      value: "pending",
                      label: taskStatus("pending"),
                    ),
                    ChoicePickerItem(
                      icon: LucideIcons.clock,
                      value: "not_submitted",
                      label: taskStatus("not_submitted"),
                    ),
                    ChoicePickerItem(
                      icon: LucideIcons.fileCheck,
                      value: "submitted",
                      label: taskStatus("submitted"),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Status tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                InputLabel(
                  label: "Catatan",
                  hintText: "(Opsional)",
                  controller: _noteController,
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
                        context.toast('Menyimpan pengerjaan...');
                        doSubmit();
                      }
                    },
                    child: const Text("Simpan"),
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
