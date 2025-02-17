import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool? isActive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    final bool active = isActive == true;

    return Container(
      width: active ? 120 : 40,
      height: 40,
      margin: EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: active ? theme.background : theme.primary,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: active ? theme.primary : theme.background),
                  SizedBox(width: active ? 4 : 0),
                  if (active)
                    Text(
                      label,
                      style: TextStyle(
                        color: active ? theme.primary : theme.background,
                        fontWeight: FontWeight.bold,
                      ),
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
