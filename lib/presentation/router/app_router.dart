import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/game_screen.dart';
import '../screens/level_select_screen.dart';
import '../screens/result_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/statistics_screen.dart';
import '../screens/daily_challenge_screen.dart';
import '../screens/daily_result_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/daily',
      builder: (context, state) => const DailyChallengeScreen(),
    ),
    GoRoute(
      path: '/daily-result',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;
        return DailyResultScreen(
          timeSeconds: extras?['time'] ?? 0,
          hintsUsed: extras?['hints'] ?? 0,
        );
      },
    ),
    GoRoute(
      path: '/levels',
      builder: (context, state) => const LevelSelectScreen(),
    ),
    GoRoute(
      path: '/game/:level',
      builder: (context, state) {
        final level = int.parse(state.pathParameters['level']!);
        return GameScreen(levelNumber: level);
      },
    ),
    GoRoute(
      path: '/result/:level',
      builder: (context, state) {
        final level = int.parse(state.pathParameters['level']!);
        final extras = state.extra as Map<String, dynamic>?;
        return ResultScreen(
          levelNumber: level,
          timeSeconds: extras?['time'] ?? 0,
          hintsUsed: extras?['hints'] ?? 0,
          stars: extras?['stars'] ?? 1,
        );
      },
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => const StatisticsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
