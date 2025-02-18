import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/layout/with_top_bar.dart';
import 'package:mylearn/components/tile_list_basic.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/screen/task/task_screen_sheet.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    Future<void> showAddBottomSheet() {
      return showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        useRootNavigator: true,
        showDragHandle: true,
        builder: (BuildContext context) {
          return TaskScreenSheet(
            onSuccess: () {
              setState(() {});
            },
          );
        },
      );
    }

    return WithTopBar(
      topBar: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Tugas Saya",
          textAlign: TextAlign.center,
          style: theme.heading3.copyWith(color: theme.textLight),
        ),
      ),
      child: Stack(
        children: [
          Consumer<UserProvider>(
            builder: (context, value, child) {
              final future = Supabase.instance.client
                  .from("subject_task")
                  .select("*")
                  .eq("student_nim", value.student!.nim)
                  .eq("semester_id", value.semester!.id)
                  .order("deadline", ascending: false)
                  .order("created_at", ascending: true);

              return FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final subjects = snapshot.data!;
                  if (subjects.isEmpty) {
                    return const Empty();
                  }
                  return ListView.builder(
                    itemCount: subjects.length,
                    padding: EdgeInsets.only(left: 24, right: 24, top: 24),
                    itemBuilder: ((context, index) {
                      final item = subjects[index];

                      return TileListBasic(
                        title: item['title'],
                        subtitle: item['description'],
                      );
                    }),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 100,
            right: 24,
            child: FloatingActionButton(
              onPressed: showAddBottomSheet,
              child: Icon(LucideIcons.plus),
            ),
          ),
        ],
      ),
    );
  }
}
