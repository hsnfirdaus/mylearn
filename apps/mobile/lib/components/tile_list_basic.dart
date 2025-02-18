import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class TileListBasic extends StatelessWidget {
  final String title;
  final String? subtitle;
  final void Function()? onTap;
  final bool selected;
  final Widget? trailing;
  final bool? isSubtitleEllipsis;

  const TileListBasic({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.selected = false,
    this.trailing,
    this.isSubtitleEllipsis,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        type: MaterialType.transparency,
        surfaceTintColor: theme.background,
        child: ListTile(
          splashColor: Colors.transparent,
          onTap: onTap,
          selected: selected,
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle:
              subtitle != null
                  ? Text(
                    subtitle!,
                    style: TextStyle(fontSize: 12),
                    overflow:
                        isSubtitleEllipsis == true
                            ? TextOverflow.ellipsis
                            : null,
                  )
                  : null,
          trailing: trailing,
        ),
      ),
    );
  }
}
