import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/bottom_sheet.dart';
import 'package:mylearn/components/task/my_task.dart';
import 'package:mylearn/models/app_bar_provider.dart';
import 'package:mylearn/screen/task/task_screen_sheet.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late AppBarProvider appBarProvider;
  final pagingController = PagingController<int, Map<String, dynamic>>(
    firstPageKey: 0,
  );

  @override
  void initState() {
    super.initState();
    appBarProvider = Provider.of<AppBarProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showAddBottomSheet() {
      return showDynamicBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return TaskScreenSheet(
            onSuccess: () {
              pagingController.refresh();
            },
          );
        },
      );
    }

    return Stack(
      children: [
        MyTask(
          topPadding: 24,
          bottomPadding: 100,
          pagingController: pagingController,
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
    );
  }
}
