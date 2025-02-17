import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    if (supabase.auth.currentSession != null &&
        supabase.auth.currentUser!.userMetadata?['picture'] != null) {
      return Image.network(
        fit: BoxFit.cover,
        supabase.auth.currentUser!.userMetadata!['picture'],
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Image.asset(
      "assets/avatar-default.jpg",
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
