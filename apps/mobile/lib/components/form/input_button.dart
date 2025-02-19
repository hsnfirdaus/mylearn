import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/theme/theme_extension.dart';

class InputButton extends StatelessWidget {
  const InputButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isError = false,
  });

  final String label;
  final void Function() onPressed;
  final bool? isError;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: theme.background200,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isError == true ? theme.error : theme.background200,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          splashFactory: NoSplash.splashFactory,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: theme.text,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(LucideIcons.chevronRight, color: theme.textPlaceholder),
            ],
          ),
        ),
      ),
    );
  }
}
