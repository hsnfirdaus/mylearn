import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/layout/top_rounded_list.dart';
import 'package:mylearn/router.dart';
import 'package:mylearn/screen/setting/setting_top_bar.dart';
import 'package:mylearn/theme/theme_extension.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      color: theme.primary,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SettingTopBar(),
          TopRoundedList(
            children: [
              SizedBox(height: 8),
              ListItem(
                icon: LucideIcons.bookCheck,
                onTap: () => context.push(AppRoute.settingSubject),
                label: "Kelola Mata Kuliah",
              ),
              ListItem(
                icon: LucideIcons.logOut,
                onTap: () => {},
                label: "Keluar",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Material(
        child: ListTile(
          onTap: onTap,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 32,
              width: 32,
              color: theme.primary,
              child: Icon(icon, color: theme.textLight),
            ),
          ),
          splashColor: Colors.transparent,
          tileColor: theme.backgroundLighest,
          title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
