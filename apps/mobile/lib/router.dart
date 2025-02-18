import 'package:go_router/go_router.dart';
import 'package:mylearn/components/layout/app_scaffold.dart';
import 'package:mylearn/components/layout/page_slide_transition.dart';
import 'package:mylearn/screen/home/home_screen.dart';
import 'package:mylearn/screen/login_screen.dart';
import 'package:mylearn/screen/onboarding_screen.dart';
import 'package:mylearn/screen/schedule/schedule_screen.dart';
import 'package:mylearn/screen/setting/setting_screen.dart';
import 'package:mylearn/screen/setting/subject/setting_subject_screen.dart';
import 'package:mylearn/screen/task/detail/task_detail_screen.dart';
import 'package:mylearn/screen/task/task_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRoute {
  static const login = "/login";
  static const onboarding = "/onboarding";
  static const home = "/home";
  static const task = "/task";
  static String taskDetail({String subjectTaskId = ':subjectTaskId'}) =>
      '/task/detail/$subjectTaskId';
  static const schedule = "/schedule";
  static const setting = "/setting";
  static const settingSubject = "/setting/subject";
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
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(state: state, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoute.home,
            name: "Home",
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: AppRoute.task,
            name: "Task",
            builder: (context, state) => TaskScreen(),
          ),
          GoRoute(
            path: AppRoute.taskDetail(),
            name: "TaskDetail",
            pageBuilder: (context, state) {
              return PageSlideTransition(
                key: state.pageKey,
                child: TaskDetailScreen(
                  subjectTaskId: state.pathParameters['subjectTaskId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: AppRoute.schedule,
            name: "Schedule",
            builder: (context, state) => ScheduleScreen(),
          ),
          GoRoute(
            path: AppRoute.setting,
            name: "Setting",
            builder: (context, state) => SettingScreen(),
          ),
          GoRoute(
            path: AppRoute.settingSubject,
            name: "ManageSubject",
            pageBuilder: (context, state) {
              return PageSlideTransition(
                key: state.pageKey,
                child: SettingSubjectScreen(),
              );
            },
          ),
        ],
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
        if ((supabase.auth.currentUser?.userMetadata?['isBoarded']) == true) {
          return AppRoute.home;
        } else {
          return AppRoute.onboarding;
        }
      }

      return null;
    },
  );
}
