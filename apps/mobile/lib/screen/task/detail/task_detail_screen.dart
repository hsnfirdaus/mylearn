import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/show_error.dart';
import 'package:mylearn/components/tag_icon.dart';
import 'package:mylearn/components/toast.dart';
import 'package:mylearn/models/app_bar_provider.dart';
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
  late AppBarProvider appBarProvider;

  @override
  void initState() {
    super.initState();
    appBarProvider = Provider.of<AppBarProvider>(context, listen: false);
  }

  Future<void> _launchUrl(String url) async {
    final Uri parsedUrl = Uri.parse(url);

    if (!await launchUrl(parsedUrl)) {
      throw Exception('Could not launch $parsedUrl');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appBarProvider.setCurrentTaskDetail(null, null);
    });
    super.dispose();
  }

  onDeleteSuccess() {
    context.toast('Tugas berhasil dihapus...');
    context.pop();
  }

  void handleTask(Map<String, dynamic> task) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (task['student']['nim'] == userProvider.student!.nim) {
      appBarProvider.setCurrentTaskDetail(task, () {
        setState(() {});
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchTask() async {
    final tasks = await Supabase.instance.client
        .from("subject_task")
        .select("*, subject(id, code, name), student(nim, name, user_id)")
        .eq("id", widget.subjectTaskId);

    if (tasks.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleTask(tasks.first);
      });
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return FutureBuilder(
      future: fetchTask(),
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
                              text: DateFormat.yMMMMEEEEd().add_Hm().format(
                                DateTime.parse(taskItem['deadline']),
                              ),
                            ),
                          ),
                        if (taskItem['student']?['name'] != null)
                          SizedBox(
                            width: double.infinity,
                            child: TagIcon(
                              icon: LucideIcons.user,
                              text: taskItem['student']['name'],
                            ),
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: TagIcon(
                            icon: LucideIcons.share2,
                            text:
                                taskItem['is_shared'] == true
                                    ? "Dibagikan dengan Teman"
                                    : "Tidak Dibagikan",
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
