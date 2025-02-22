import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/empty.dart';
import 'package:mylearn/components/show_error.dart';
import 'package:mylearn/components/task/task_item.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyTask extends StatelessWidget {
  final int limit;
  final double? topPadding;
  final double? bottomPadding;
  const MyTask({
    super.key,
    required this.limit,
    this.topPadding,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        final future = Supabase.instance.client
            .from("not_submitted_task")
            .select("*")
            .limit(limit);

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
              return const Empty(
                icon: LucideIcons.smile,
                label: "Tidak Ada Tugas.",
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: subjects.length,
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: topPadding ?? 0,
                bottom: bottomPadding ?? 0,
              ),
              itemBuilder: (context, index) {
                final item = subjects[index];

                return TaskItem(
                  item: item,
                  onPress: () {
                    context.push(
                      AppRoute.taskDetail(subjectTaskId: item['id']),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
