import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/router.dart';

class TaskScreenAction extends StatelessWidget {
  const TaskScreenAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.push(AppRoute.taskHistory);
      },
      icon: Icon(LucideIcons.history),
    );
  }
}
