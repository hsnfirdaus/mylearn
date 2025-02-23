import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/app_alert_dialog.dart';
import 'package:mylearn/components/bottom_sheet.dart';
import 'package:mylearn/components/toast.dart';
import 'package:mylearn/screen/task/task_screen_sheet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskDetailAction extends StatelessWidget {
  final Map<String, dynamic> task;
  final void Function() onRefresh;
  const TaskDetailAction({
    super.key,
    required this.task,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    onDeleteSuccess() {
      context.toast('Tugas berhasil dihapus...');
      context.pop(true);
    }

    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          child: Text("Edit Tugas"),
          onPressed: () {
            showDynamicBottomSheet<void>(
              context: context,
              useRootNavigator: true,
              builder: (BuildContext context) {
                return TaskScreenSheet(
                  isEdit: true,
                  oldValue: task,
                  onSuccess: onRefresh,
                );
              },
            );
          },
        ),
        MenuItemButton(
          child: Text("Hapus Tugas"),
          onPressed: () async {
            final result = await showDeleteDialog(
              context: context,
              content:
                  'Tugas ini akan dihapus dan tidak dapat dikembalikan lagi!',
            );
            if (result == true) {
              final res = await Supabase.instance.client
                  .from("subject_task")
                  .delete()
                  .eq("id", task['id']);
              if (res?.error == null) {
                onDeleteSuccess();
              }
            }
          },
        ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(LucideIcons.ellipsisVertical),
        );
      },
    );
  }
}
