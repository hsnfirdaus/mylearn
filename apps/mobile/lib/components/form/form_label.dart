import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.label,
    this.isError = false,
    this.isFocused = false,
    this.width = double.infinity,
  });

  final String label;
  final bool isError;
  final bool isFocused;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SizedBox(
      width: width,
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
