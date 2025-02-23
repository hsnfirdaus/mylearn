import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/models/app_bar_provider.dart';
import 'package:mylearn/router.dart';
import 'package:mylearn/screen/home/home_top_bar.dart';
import 'package:mylearn/screen/setting/setting_top_bar.dart';
import 'package:mylearn/screen/task/detail/task_detail_action.dart';
import 'package:mylearn/screen/task/task_screen_action.dart';
import 'package:provider/provider.dart';

String? _getTitleForRoute(String? path) {
  switch (path) {
    case AppRoute.task:
      return "Tugas Saya";
    case AppRoute.schedule:
      return "Jadwal Saya";
    case AppRoute.settingSubject:
      return "Mata Kuliah";
    case AppRoute.taskHistory:
      return "Riwayat Tugas";
    case AppRoute.taskDetailRoute:
      return "Detail Tugas";
    default:
      return null;
  }
}

Widget? _getTopBarForRoute(String? path) {
  switch (path) {
    case AppRoute.home:
      return HomeTopBar();
    case AppRoute.setting:
      return SettingTopBar();
    default:
      return null;
  }
}

Widget? _getActionForRoute(String? path) {
  switch (path) {
    case AppRoute.task:
      return TaskScreenAction();
    case AppRoute.taskDetailRoute:
      return Consumer<AppBarProvider>(
        builder: (context, value, child) {
          if (value.taskDetail != null && value.taskDetailRefresh != null) {
            return TaskDetailAction(
              task: value.taskDetail!,
              onRefresh: value.taskDetailRefresh!,
            );
          }
          return const SizedBox();
        },
      );
    default:
      return null;
  }
}

const List<String> backable = [
  AppRoute.settingSubject,
  AppRoute.taskDetailRoute,
  AppRoute.taskHistory,
];

class AppTopBar extends StatelessWidget {
  final GoRouterState state;
  const AppTopBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    Widget? customTopBar = _getTopBarForRoute(state.fullPath);
    Widget? child =
        customTopBar ??
        AppBar(
          leading:
              backable.contains(state.fullPath)
                  ? IconButton(
                    icon: Icon(LucideIcons.arrowLeft),
                    onPressed: () => context.pop(),
                  )
                  : null,
          title: Text(
            _getTitleForRoute(state.fullPath) ?? "MyLearn",
            style: TextStyle(
              fontFamily: DefaultTextStyle.of(context).style.fontFamily,
            ),
          ),
          actions: [
            if (_getActionForRoute(state.fullPath) != null)
              _getActionForRoute(state.fullPath)!,
            SizedBox(width: 12),
          ],
        );
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: child,
    );
  }
}
