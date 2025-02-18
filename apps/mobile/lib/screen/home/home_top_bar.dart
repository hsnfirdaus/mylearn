import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mylearn/components/avatar.dart';
import 'package:mylearn/theme/theme_extension.dart';

class HomeTopBar extends StatelessWidget {
  HomeTopBar({super.key});

  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              color: theme.background,
              height: 50,
              width: 50,
              child: Avatar(),
            ),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                DateFormat('EEEE').format(now),
                style: TextStyle(
                  color: theme.textLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                DateFormat.yMMMMd().format(now),
                style: TextStyle(color: theme.textLight, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
