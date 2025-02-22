import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/bottom_sheet.dart';
import 'package:mylearn/components/task/my_task.dart';
import 'package:mylearn/screen/task/task_screen_sheet.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> showAddBottomSheet() {
      return showDynamicBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return TaskScreenSheet(
            onSuccess: () {
              setState(() {});
            },
          );
        },
      );
    }

    return Stack(
      children: [
        MyTask(limit: 50, topPadding: 24, bottomPadding: 100),
        Positioned(
          bottom: 100,
          right: 24,
          child: FloatingActionButton(
            onPressed: showAddBottomSheet,
            child: Icon(LucideIcons.plus),
          ),
        ),
      ],
    );
  }
}
