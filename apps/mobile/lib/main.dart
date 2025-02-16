import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:mylearn/style.dart';
import 'package:mylearn/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON']!,
  );

  // await Supabase.instance.client.auth.exchangeCodeForSession(
  //   '',
  // );

  GoRouter router = AppRouter().router;

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    router.refresh();
  });

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyLearn',
      theme: AppThemeData.theme,
      routerConfig: router,
    );
  }
}
