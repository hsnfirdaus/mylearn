import 'package:flutter/material.dart';
import 'package:mylearn/components/task/my_task_history.dart';

class TaskHistoryScreen extends StatefulWidget {
  const TaskHistoryScreen({super.key});

  @override
  State<TaskHistoryScreen> createState() => _TaskHistoryScreenState();
}

class _TaskHistoryScreenState extends State<TaskHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return MyTaskHistory();
  }
}
