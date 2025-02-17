import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/layout/title_rounded_scaffold.dart';
import 'package:mylearn/components/tile_list_basic.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/screen/setting/subject/setting_subject_sheet.dart';
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
    Future<void> showBottomSheet() {
      return showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (BuildContext context) {
          return SettingSubjectSheet(
            onSuccess: () {
              setState(() {});
            },
          );
        },
      );
    }

    return TitleRoundedScaffold(
      title: "Mata Kuliah",
      fab: FloatingActionButton.extended(
        onPressed: showBottomSheet,
        icon: const Icon(LucideIcons.plus),
        label: const Text("Tambah"),
      ),
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
          final future = Supabase.instance.client
              .from("enrollment")
              .select("student_nim, subject(id, name, code)")
              .order("subject(code)", ascending: true);

          return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final subjects = snapshot.data!;
              if (subjects.isEmpty) {
                return const Empty();
              }
              return ListView.builder(
                itemCount: subjects.length,
                padding: EdgeInsets.only(left: 24, right: 24, top: 24),
                itemBuilder: ((context, index) {
                  final item = subjects[index];

                  return TileListBasic(
                    title: item['subject']['name'],
                    subtitle: item['subject']['code'],
                  );
                }),
              );
            },
          );
        },
      ),
    );
  }
}
