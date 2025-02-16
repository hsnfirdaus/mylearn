import 'package:go_router/go_router.dart';
import 'package:mylearn/screen/home_screen.dart';
import 'package:mylearn/screen/login_screen.dart';
import 'package:mylearn/screen/onboarding_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRoute {
  static const login = "/login";
  static const onboarding = "/onboarding";
  static const home = "/home";
}

final supabase = Supabase.instance.client;

class AppRouter {
  final router = GoRouter(
    initialLocation:
        Supabase.instance.client.auth.currentUser != null
            ? (supabase.auth.currentUser?.userMetadata?['isBoarded']) == true
                ? AppRoute.home
                : AppRoute.onboarding
            : AppRoute.login,
    routes: [
      GoRoute(
        path: AppRoute.login,
        name: "Login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoute.home,
        name: "Home",
        builder:
            (context, state) => HomeScreen(title: 'Flutter Demo Home Page'),
      ),
      GoRoute(
        path: AppRoute.onboarding,
        name: "Onboarding",
        builder: (context, state) => OnboardingScreen(),
      ),
    ],
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isAuthenticated = session != null;

      if (!isAuthenticated &&
          !state.uri.toString().startsWith(AppRoute.login)) {
        return AppRoute.login;
      }

      if (isAuthenticated && state.uri.toString().startsWith(AppRoute.login)) {
        return AppRoute.onboarding;
      }

      return null;
    },
  );
}
