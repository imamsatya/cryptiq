import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/game_screen.dart';
import '../screens/level_select_screen.dart';
import '../screens/result_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/statistics_screen.dart';
import '../screens/daily_challenge_screen.dart';
import '../screens/daily_result_screen.dart';
import '../screens/achievements_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/multiplayer_lobby_screen.dart';
import '../screens/multiplayer_game_screen.dart';
import '../screens/multiplayer_result_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) {
    if (state.uri.path == '/' && !OnboardingScreen.hasSeenOnboarding()) {
      return '/onboarding';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(
        onComplete: () {
          _rootNavigatorKey.currentContext?.go('/');
        },
      ),
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
    GoRoute(
      path: '/achievements',
      builder: (context, state) => const AchievementsScreen(),
    ),
    GoRoute(
      path: '/multiplayer',
      builder: (context, state) => const MultiplayerLobbyScreen(),
    ),
    GoRoute(
      path: '/multiplayer-game',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return MultiplayerGameScreen(
          playerNames: List<String>.from(extras['names']),
          totalRounds: extras['rounds'],
          difficulty: extras['difficulty'],
          operation: extras['operation'],
        );
      },
    ),
    GoRoute(
      path: '/multiplayer-result',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return MultiplayerResultScreen(
          playerNames: List<String>.from(extras['names']),
          results: extras['results'],
          totalRounds: extras['rounds'],
        );
      },
    ),
  ],
);
