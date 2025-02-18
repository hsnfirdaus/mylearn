import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class TagIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool? isPrimary;

  const TagIcon({
    super.key,
    required this.icon,
    required this.text,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: theme.primary, size: 14),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: isPrimary == true ? theme.primary : theme.textTransparent,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
