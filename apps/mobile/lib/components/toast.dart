import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/theme/theme_extension.dart';

void showToast(BuildContext context, String message, {bool isError = false}) {
  final overlay = Overlay.of(context);

  final animationController = AnimationController(
    vsync: Navigator.of(context),
    duration: Duration(milliseconds: 300),
  );

  final slideAnimation = Tween<Offset>(
    begin: Offset(0, -1),
    end: Offset(0, 0),
  ).animate(
    CurvedAnimation(parent: animationController, curve: Curves.easeOut),
  );

  final opacityAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn));

  final overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 20,
          right: 20,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Opacity(
                opacity: opacityAnimation.value,
                child: SlideTransition(
                  position: slideAnimation,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            isError
                                ? context.appTheme.error
                                : context.appTheme.backgroundLighest,
                        border: Border.all(
                          color:
                              isError
                                  ? Colors.transparent
                                  : context.appTheme.background200,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.circleAlert,
                            color:
                                isError
                                    ? context.appTheme.textLight
                                    : context.appTheme.primary,
                          ),
                          SizedBox(width: 12),
                          Text(
                            message,
                            style: TextStyle(
                              color:
                                  isError
                                      ? context.appTheme.textLight
                                      : context.appTheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
  );

  overlay.insert(overlayEntry);
  animationController.forward();

  Future.delayed(Duration(seconds: 3), () async {
    await animationController.reverse();
    overlayEntry.remove();
  });
}

extension ToasterExtension on BuildContext {
  void toast(String message) {
    showToast(this, message);
  }

  void errorToast(String message) {
    showToast(this, message, isError: true);
  }
}
