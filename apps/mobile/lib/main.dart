import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:mylearn/router.dart';
import 'package:mylearn/theme/theme_data.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'id_ID';

  initializeDateFormatting();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON']!,
  );

  UserProvider userProvider = UserProvider();
  await userProvider.refreshStudent();

  // await Supabase.instance.client.auth.exchangeCodeForSession(
  //   '',
  // );

  GoRouter router = AppRouter().router;

  Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
    await userProvider.refreshStudent();
    router.refresh();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userProvider),
        Provider(create: (context) => AppThemeData()),
      ],
      child: MyApp(router: router),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyLearn',
      theme: context.appTheme.materialTheme,
      routerConfig: router,
    );
  }
}
