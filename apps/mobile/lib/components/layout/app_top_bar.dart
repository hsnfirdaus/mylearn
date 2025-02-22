import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/models/app_bar_provider.dart';
import 'package:mylearn/router.dart';
import 'package:mylearn/screen/home/home_top_bar.dart';
import 'package:mylearn/screen/setting/setting_top_bar.dart';
import 'package:provider/provider.dart';

final Map<String, String> titles = {
  AppRoute.task: "Tugas Saya",
  AppRoute.schedule: "Jadwal Saya",
  AppRoute.settingSubject: "Mata Kuliah",
  AppRoute.taskDetail(): "Detail Tugas",
};

final Map<String, Widget Function()> customTopBars = {
  AppRoute.home: () => HomeTopBar(),
  AppRoute.setting: () => SettingTopBar(),
};

final List<String> backable = [AppRoute.settingSubject, AppRoute.taskDetail()];

class AppTopBar extends StatelessWidget {
  final GoRouterState state;
  const AppTopBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    Widget? child =
        customTopBars.containsKey(state.fullPath)
            ? customTopBars[state.fullPath]!()
            : AppBar(
              leading:
                  backable.contains(state.fullPath)
                      ? IconButton(
                        icon: Icon(LucideIcons.arrowLeft),
                        onPressed: () => context.pop(),
                      )
                      : null,
              title: Text(titles[state.fullPath] ?? "MyLearn"),
              actions: context.watch<AppBarProvider>().actions,
            );
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: child,
    );
  }
}
