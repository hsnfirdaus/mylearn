import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.label,
    this.isError = false,
    this.isFocused = false,
  });

  final String label;
  final bool isError;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SizedBox(
      width: double.infinity,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color:
              isError
                  ? theme.error
                  : isFocused
                  ? theme.primary
                  : theme.text,
        ),
      ),
    );
  }
}
