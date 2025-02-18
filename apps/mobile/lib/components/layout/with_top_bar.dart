import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class WithTopBar extends StatelessWidget {
  const WithTopBar({super.key, required this.topBar, required this.child});

  final Widget topBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      color: theme.primary,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          topBar,
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Container(color: theme.background, child: child),
            ),
          ),
        ],
      ),
    );
  }
}
