import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 4, left: 14),
      child: Text(
        message,
        style: TextStyle(
          color: theme.error,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
