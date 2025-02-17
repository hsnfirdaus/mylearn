import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class TopRoundedList extends StatelessWidget {
  const TopRoundedList({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Container(
          color: theme.background,
          child: ListView(children: children),
        ),
      ),
    );
  }
}
