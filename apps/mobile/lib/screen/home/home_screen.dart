import 'package:flutter/material.dart';
import 'package:mylearn/components/task/my_task.dart';
import 'package:mylearn/screen/home/today_schedule.dart';
import 'package:mylearn/theme/theme_extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 10),
          child: Text(
            "Jadwal Hari Ini",
            style: theme.heading3,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 12),
        TodaySchedule(),
        Padding(
          padding: EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 10),
          child: Text(
            "Tugas Saya",
            style: theme.heading3,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 12),
        MyTask(limit: 2),
      ],
    );
  }
}
