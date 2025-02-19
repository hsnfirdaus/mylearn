import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/layout/nav_item.dart';
import 'package:mylearn/router.dart';
import 'package:mylearn/theme/theme_extension.dart';

const List<String> visibleNavBar = [
  AppRoute.home,
  AppRoute.task,
  AppRoute.schedule,
  AppRoute.setting,
];

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key, required this.state});

  final GoRouterState state;

  String getBasePath() {
    final currentPath = (state.fullPath ?? "/");
    if (currentPath.startsWith(AppRoute.setting)) {
      return AppRoute.setting;
    }
    if (currentPath.startsWith(AppRoute.task)) {
      return AppRoute.task;
    }
    if (currentPath.startsWith(AppRoute.schedule)) {
      return AppRoute.schedule;
    }
    return AppRoute.home;
  }

  bool isNavBarVisible() {
    return visibleNavBar.contains(state.fullPath);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final activeItem = getBasePath();

    void navigate(String path) {
      if (activeItem == AppRoute.home) {
        context.push(path);
      } else {
        context.replace(path);
      }
    }

    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      bottom: isNavBarVisible() ? 0 : -100,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Container(
            color: theme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                NavItem(
                  icon: LucideIcons.house,
                  label: "Beranda",
                  isActive: activeItem == AppRoute.home,
                  onTap: () => context.go(AppRoute.home),
                ),
                NavItem(
                  icon: LucideIcons.book,
                  label: "Tugas",
                  isActive: activeItem == AppRoute.task,
                  onTap: () => navigate(AppRoute.task),
                ),
                NavItem(
                  icon: LucideIcons.calendar,
                  label: "Jadwal",
                  isActive: activeItem == AppRoute.schedule,
                  onTap: () => navigate(AppRoute.schedule),
                ),
                NavItem(
                  icon: LucideIcons.settings,
                  label: "Pengaturan",
                  isActive: activeItem == AppRoute.setting,
                  onTap: () => navigate(AppRoute.setting),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
