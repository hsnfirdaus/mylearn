import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/show_error.dart';
import 'package:mylearn/components/tag_icon.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/screen/task/detail/task_submission.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetailScreen extends StatefulWidget {
  final String subjectTaskId;

  const TaskDetailScreen({super.key, required this.subjectTaskId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  Future<void> _launchUrl(String url) async {
    final Uri parsedUrl = Uri.parse(url);

    if (!await launchUrl(parsedUrl)) {
      throw Exception('Could not launch $parsedUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    final future = Supabase.instance.client
        .from("subject_task")
        .select("*, subject(code, name)")
        .eq("id", widget.subjectTaskId);

    final theme = context.appTheme;

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ShowError(label: snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = snapshot.data!;
        if (tasks.isEmpty) {
          return const Empty();
        }

        final taskItem = tasks.first;

        return Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24, right: 24, left: 24),
                    child: Text(
                      taskItem['title'],
                      style: theme.heading3.copyWith(fontSize: 22),
                    ),
                  ),
                  taskItem['description'] != null &&
                          taskItem['description'] != ""
                      ? Padding(
                        padding: EdgeInsets.only(left: 24, right: 24, top: 12),
                        child: Text(
                          taskItem['description'],
                          style: theme.bodyText,
                        ),
                      )
                      : SizedBox(),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Wrap(
                      runSpacing: 8,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: TagIcon(
                            icon: LucideIcons.bookType,
                            text: taskItem['subject']['name'],
                          ),
                        ),
                        if (taskItem['deadline'] != null)
                          SizedBox(
                            width: double.infinity,
                            child: TagIcon(
                              icon: LucideIcons.calendar,
                              text: DateFormat.yMMMMd().add_Hm().format(
                                DateTime.parse(taskItem['deadline']),
                              ),
                            ),
                          ),
                        if (taskItem['learning_link'] != null &&
                            taskItem['learning_link'] != "")
                          Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    () => _launchUrl(taskItem['learning_link']),
                                child: Text("Buka di E-Learning"),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Consumer<UserProvider>(
              builder: (context, value, child) {
                return TaskSubmission(
                  subjectTaskId: widget.subjectTaskId,
                  nim: value.student!.nim,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
