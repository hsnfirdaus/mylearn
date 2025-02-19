import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/bottom_sheet.dart';
import 'package:mylearn/components/show_error.dart';
import 'package:mylearn/helpers/format.dart';
import 'package:mylearn/screen/task/detail/task_submission_sheet.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskSubmission extends StatefulWidget {
  const TaskSubmission({
    super.key,
    required this.subjectTaskId,
    required this.nim,
  });

  final String subjectTaskId;
  final String nim;

  @override
  State<TaskSubmission> createState() => _TaskSubmissionState();
}

class _TaskSubmissionState extends State<TaskSubmission> {
  @override
  Widget build(BuildContext context) {
    final studentFuture = Supabase.instance.client
        .from("subject_task_student")
        .select("*")
        .eq("task_id", widget.subjectTaskId)
        .eq("student_nim", widget.nim)
        .limit(1);

    final theme = context.appTheme;

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.background200)),
      ),
      child: FutureBuilder(
        future: studentFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ShowError(label: snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!;
          String status = "Belum Dikerjakan";
          String subtitle = "Ubah Status";
          bool isSubmitted = false;
          if (tasks.isNotEmpty) {
            status = taskStatus(tasks.first['status']);

            if (tasks.first['status'] == 'submitted') {
              isSubmitted = true;
            }

            if (tasks.first['note'] != null && tasks.first['note'] != "") {
              subtitle = tasks.first['note'];
            } else if (tasks.first['updated_at'] != null &&
                tasks.first['updated_at'] != "") {
              subtitle = DateFormat.yMMMd().add_Hm().format(
                DateTime.parse(tasks.first['updated_at']),
              );
            }
          }

          Future<void> showBottomSheet() {
            return showDynamicBottomSheet<void>(
              context: context,
              useRootNavigator: true,
              builder: (BuildContext context) {
                return TaskSubmissionSheet(
                  subjectTaskId: widget.subjectTaskId,
                  initialNote: tasks.isEmpty ? null : tasks.first['note'],
                  initialStatus: tasks.isEmpty ? null : tasks.first['status'],
                  onSuccess: () {
                    setState(() {});
                  },
                );
              },
            );
          }

          return Material(
            child: ListTile(
              leading: Icon(LucideIcons.clipboardList),
              selected: isSubmitted,
              onTap: showBottomSheet,
              title: Text(
                status,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(subtitle),
              tileColor: theme.backgroundLighest,
              splashColor: Colors.transparent,
              trailing: Icon(LucideIcons.chevronRight),
            ),
          );
        },
      ),
    );
  }
}
