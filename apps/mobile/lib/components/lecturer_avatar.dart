import 'package:flutter/material.dart';

class LecturerAvatar extends StatelessWidget {
  const LecturerAvatar({
    super.key,
    required this.url,
    this.height = 50,
    this.width = 50,
  });

  final double height;
  final double width;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child:
          url != null
              ? Image.network(
                "https://imagecdn.app/v1/images/${Uri.encodeComponent(url!)}?width=$width&height=$height",
                height: height,
                width: width,
              )
              : Image.asset(
                "assets/avatar-default.jpg",
                height: height,
                width: width,
              ),
    );
  }
}
