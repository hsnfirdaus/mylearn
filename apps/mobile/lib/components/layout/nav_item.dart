import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isActive ? 120 : 40,
      height: 40,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: isActive ? theme.background : theme.primary,
      ),
      child: ClipRRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            splashFactory: NoSplash.splashFactory,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 2),
                  Icon(
                    icon,
                    color: isActive ? theme.primary : theme.background,
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: isActive ? 1.0 : 0.0,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 300),
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: theme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
