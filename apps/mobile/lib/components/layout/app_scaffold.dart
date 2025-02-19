import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mylearn/components/layout/app_bottom_bar.dart';
import 'package:mylearn/components/layout/app_top_bar.dart';
import 'package:mylearn/theme/theme_extension.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child, required this.state});

  final Widget child;
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: theme.background,
      ),
      child: Container(
        color: theme.primary,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: theme.primary,
            extendBody: true,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      AppTopBar(state: state),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          child: Container(
                            color: theme.background,
                            child: child,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppBottomBar(state: state),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
