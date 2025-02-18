import 'package:flutter/material.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/form/select_available_subject.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingSubjectSheet extends StatefulWidget {
  final void Function() onSuccess;

  const SettingSubjectSheet({super.key, required this.onSuccess});

  @override
  State<SettingSubjectSheet> createState() => _SettingSubjectSheetState();
}

class _SettingSubjectSheetState extends State<SettingSubjectSheet> {
  final _formKey = GlobalKey<FormState>();

  final CustomController<Map<String, dynamic>> _subjectController =
      CustomController();

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

      final res = await supabase.from("enrollment").insert({
        "student_nim": userProvider.student!.nim,
        "subject_id": _subjectController.value!['id'],
        "semester_id": userProvider.semester!.id,
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
      height: 220,
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Tambah Mata Kuliah', style: theme.heading3),
            SizedBox(height: 12),
            Expanded(
              child: SelectAvailableSubject(
                label: "Pilih Mata Kuliah",
                controller: _subjectController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Silahkan pilih mata kuliah!";
                  }
                  return null;
                },
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
                          const SnackBar(
                            content: Text('Menambahkan mata kuliah...'),
                          ),
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
