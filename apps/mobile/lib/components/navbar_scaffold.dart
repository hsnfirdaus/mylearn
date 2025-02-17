import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/nav_item.dart';
import 'package:mylearn/router.dart';
import 'package:mylearn/theme/theme_extension.dart';

class NavbarScaffold extends StatelessWidget {
  const NavbarScaffold({super.key, required this.child, required this.state});

  final Widget child;
  final GoRouterState state;

  String getBasePath() {
    final currentPath = (state.fullPath ?? "/");
    if (currentPath.startsWith(AppRoute.setting)) {
      return AppRoute.setting;
    }

    return AppRoute.home;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    void navigate(String path) {
      context.go(path);
    }

    final activeItem = getBasePath();

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
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
                  onTap: () => navigate(AppRoute.home),
                ),
                NavItem(
                  icon: LucideIcons.book,
                  label: "Tugas",
                  isActive: false,
                ),
                NavItem(
                  icon: LucideIcons.calendar,
                  label: "Jadwal",
                  isActive: false,
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
      body: child,
    );
  }
}
