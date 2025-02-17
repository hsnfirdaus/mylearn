import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/theme/theme_extension.dart';

class SettingSubjectScreen extends StatelessWidget {
  const SettingSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      backgroundColor: theme.primary,
      appBar: AppBar(
        title: Text("Mata Kuliah"),
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
        child: Container(color: theme.background),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        icon: const Icon(LucideIcons.plus),
        label: const Text("Tambah"),
      ),
    );
  }
}
