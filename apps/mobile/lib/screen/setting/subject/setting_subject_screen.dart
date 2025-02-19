import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/app_alert_dialog.dart';
import 'package:mylearn/components/bottom_sheet.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/show_error.dart';
import 'package:mylearn/components/tile_list_basic.dart';
import 'package:mylearn/components/toast.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/screen/setting/subject/setting_subject_sheet.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingSubjectScreen extends StatefulWidget {
  const SettingSubjectScreen({super.key});

  @override
  State<SettingSubjectScreen> createState() => _SettingSubjectScreenState();
}

class _SettingSubjectScreenState extends State<SettingSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    showMessage(String message) {
      context.toast(message);
    }

    Future<void> showDeleteDialog(Map<String, dynamic> item) async {
      final result = await showDialog<bool>(
        context: context,
        builder:
            (BuildContext context) => AppAlertDialog(
              title: 'Apakah anda yakin?',
              content:
                  'Mata kuliah ${item['subject']['name']} akan dihapus dari akun anda!',
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Batal'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: theme.deleteButton,
                  child: const Text('Hapus'),
                ),
              ],
            ),
      );
      if (result == true) {
        final res = await Supabase.instance.client
            .from("enrollment")
            .delete()
            .eq("student_nim", item['student_nim'])
            .eq("semester_id", item['semester_id'])
            .eq("subject_id", item['subject']['id']);
        if (res?.error == null) {
          showMessage('Mata kuliah dihapus...');
          setState(() {});
        }
      }
    }

    Future<void> showAddBottomSheet() {
      return showDynamicBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return SettingSubjectSheet(
            onSuccess: () {
              setState(() {});
            },
          );
        },
      );
    }

    return Stack(
      children: [
        Consumer<UserProvider>(
          builder: (context, value, child) {
            final future = Supabase.instance.client
                .from("enrollment")
                .select("student_nim, semester_id, subject(id, name, code)")
                .eq("student_nim", value.student!.nim)
                .eq("semester_id", value.semester!.id)
                .order("subject(code)", ascending: true);

            return FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ShowError(label: snapshot.error.toString());
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final subjects = snapshot.data!;
                if (subjects.isEmpty) {
                  return const Empty();
                }
                return ListView.builder(
                  itemCount: subjects.length,
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                    bottom: 80,
                  ),
                  itemBuilder: ((context, index) {
                    final item = subjects[index];

                    return TileListBasic(
                      title: item['subject']['name'],
                      subtitle: item['subject']['code'],
                      trailing: IconButton(
                        onPressed: () => showDeleteDialog(item),
                        icon: Icon(LucideIcons.trash),
                        color: theme.error,
                      ),
                    );
                  }),
                );
              },
            );
          },
        ),
        Positioned(
          right: 24,
          bottom: 24,
          child: FloatingActionButton.extended(
            onPressed: showAddBottomSheet,
            icon: const Icon(LucideIcons.plus),
            label: const Text("Tambah"),
          ),
        ),
      ],
    );
  }
}
