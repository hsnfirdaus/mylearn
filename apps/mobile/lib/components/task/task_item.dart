import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/tag_icon.dart';
import 'package:mylearn/helpers/date.dart';
import 'package:mylearn/helpers/format.dart';
import 'package:mylearn/theme/theme_extension.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.item,
    this.onPress,
    this.isHistory = false,
  });

  final bool isHistory;
  final Map<String, dynamic> item;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.background200),
          borderRadius: BorderRadius.circular(10),
          color: theme.backgroundLighest,
        ),
        clipBehavior: Clip.hardEdge,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onPress,
            splashColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (item['deadline'] != null && !isHistory)
                        TagIcon(
                          icon: LucideIcons.target,
                          text: countDown(item['deadline']),
                        ),
                      if (isHistory && item['updated_at'] != null)
                        TagIcon(
                          icon: LucideIcons.calendar,
                          text:
                              "${countDown(item['updated_at'], isReverse: true)} yang lalu",
                        ),
                      TagIcon(
                        icon: LucideIcons.bookType,
                        text: item['subject_code'],
                      ),
                      if (!isHistory)
                        TagIcon(
                          icon: LucideIcons.bookmark,
                          text: taskStatus(item['status']),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
