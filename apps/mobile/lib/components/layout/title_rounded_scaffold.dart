import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/theme/theme_extension.dart';

class TitleRoundedScaffold extends StatelessWidget {
  const TitleRoundedScaffold({
    super.key,
    required this.title,
    this.fab,
    this.child,
    this.bottomSheet,
  });

  final String title;
  final Widget? fab;
  final Widget? child;
  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      backgroundColor: theme.primary,
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Container(color: theme.background, child: child),
      ),
      floatingActionButton: fab,
      bottomSheet: bottomSheet,
    );
  }
}
