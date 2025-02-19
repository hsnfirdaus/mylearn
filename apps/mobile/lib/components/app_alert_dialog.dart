import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });
  final String title;
  final String content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(content, textAlign: TextAlign.center),
          SizedBox(height: 24),
          Row(
            spacing: 8,
            children:
                actions.map((item) {
                  return Expanded(child: item);
                }).toList(),
          ),
        ],
      ),
    );
  }
}
