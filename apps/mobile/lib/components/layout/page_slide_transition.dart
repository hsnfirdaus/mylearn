import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylearn/theme/theme_extension.dart';

class PageSlideTransition extends CustomTransitionPage {
  PageSlideTransition({super.key, required super.child})
    : super(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeInOut));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: Container(color: context.appTheme.background, child: child),
          );
        },
      );
}
