import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: theme.background,
        ),
        child: SingleChildScrollView(child: child),
      ),
    );
  }
}
