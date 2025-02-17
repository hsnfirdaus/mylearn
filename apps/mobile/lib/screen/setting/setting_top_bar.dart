import 'package:flutter/material.dart';
import 'package:mylearn/components/avatar.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';

class SettingTopBar extends StatelessWidget {
  const SettingTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              color: theme.background,
              height: 80,
              width: 80,
              child: Avatar(),
            ),
          ),
          SizedBox(height: 12),
          Consumer<UserProvider>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    value.student?.name ?? "-",
                    style: TextStyle(
                      color: theme.textLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    value.student?.nim ?? "-",
                    style: TextStyle(color: theme.textLight, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
