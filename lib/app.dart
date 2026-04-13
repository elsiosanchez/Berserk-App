import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'theme/berserk_theme.dart';
import 'providers/locale_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/workout_screen.dart';
import 'screens/active_workout_screen.dart';
import 'screens/checkpoint_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/nutrition_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/berserk_nav_bar.dart';
import 'theme/berserk_colors.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/active-workout/:dayId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ActiveWorkoutScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return _ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/workouts',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'day/:dayId',
              builder: (context, state) => const WorkoutScreen(),
            ),
            GoRoute(
              path: 'checkpoint',
              builder: (context, state) => const CheckpointScreen(),
            ),
            GoRoute(
              path: 'nutrition',
              builder: (context, state) => const NutritionScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/progress',
          builder: (context, state) => const ProgressScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class BerserkApp extends StatelessWidget {
  const BerserkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BERSERK',
      debugShowCheckedModeBanner: false,
      theme: BerserkTheme.dark,
      routerConfig: router,
    );
  }
}

class _ScaffoldWithNavBar extends ConsumerWidget {
  const _ScaffoldWithNavBar({required this.child});

  final Widget child;

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/profile')) return 0;
    if (location.startsWith('/workouts')) return 1;
    if (location.startsWith('/progress')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 1;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    return Scaffold(
      backgroundColor: BerserkColors.bg,
      body: child,
      bottomNavigationBar: BerserkNavBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/profile');
            case 1:
              context.go('/workouts');
            case 2:
              context.go('/progress');
            case 3:
              context.go('/settings');
          }
        },
      ),
    );
  }
}
