import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../presentation/providers/auth_providers.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/dashboard/dashboard_screen.dart';
import '../presentation/screens/tasks/task_list_screen.dart';
import '../presentation/screens/tasks/task_form_screen.dart';
import '../presentation/screens/tasks/task_detail_screen.dart';
import '../presentation/screens/morning_briefing/morning_briefing_screen.dart';
import '../presentation/screens/night_debrief/night_debrief_screen.dart';
import '../presentation/screens/night_debrief/debrief_summary_screen.dart';
import '../presentation/screens/matrix/matrix_screen.dart';
import '../presentation/screens/ops_log/ops_log_screen.dart';
import '../presentation/screens/reminders/reminders_list_screen.dart';
import '../presentation/screens/reminders/reminder_form_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';
import '../presentation/widgets/common/app_shell.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: Routes.splash,
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      if (isLoading) return null;

      final isLoggedIn = authState.value != null;
      final loc = state.matchedLocation;
      final isAuthRoute = loc == Routes.login || loc == Routes.register;
      final isSplash = loc == Routes.splash;

      if (isSplash) return null;
      if (!isLoggedIn && !isAuthRoute) return Routes.login;
      if (isLoggedIn && isAuthRoute) return Routes.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (ctx, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: Routes.dashboard,
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: Routes.tasks,
            builder: (_, __) => const TaskListScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (_, __) => const TaskFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (_, s) =>
                    TaskDetailScreen(taskId: s.pathParameters['id']!),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (_, s) => TaskFormScreen(
                        taskId: s.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: Routes.matrix,
            builder: (_, __) => const MatrixScreen(),
          ),
          GoRoute(
            path: Routes.briefing,
            builder: (_, __) => const MorningBriefingScreen(),
          ),
          GoRoute(
            path: Routes.debrief,
            builder: (_, __) => const NightDebriefScreen(),
          ),
          GoRoute(
            path: '/debrief/:date',
            builder: (_, s) =>
                DebriefSummaryScreen(dateKey: s.pathParameters['date']!),
          ),
          GoRoute(
            path: Routes.opsLog,
            builder: (_, __) => const OpsLogScreen(),
          ),
          GoRoute(
            path: Routes.reminders,
            builder: (_, __) => const RemindersListScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (_, __) => const ReminderFormScreen(),
              ),
              GoRoute(
                path: ':id/edit',
                builder: (_, s) => ReminderFormScreen(
                    reminderId: s.pathParameters['id']),
              ),
            ],
          ),
          GoRoute(
            path: Routes.settings,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});
