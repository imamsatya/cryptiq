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
import '../screens/privacy_policy_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Smooth slide-fade transition for all routes
CustomTransitionPage<void> _transitionPage({
  required Widget child,
  required GoRouterState state,
  bool slideUp = false,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      final offset = slideUp
          ? Tween(begin: const Offset(0, 0.08), end: Offset.zero)
          : Tween(begin: const Offset(0.05, 0), end: Offset.zero);

      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: offset.animate(curved),
          child: child,
        ),
      );
    },
  );
}

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
      pageBuilder: (context, state) =>
          _transitionPage(child: const HomeScreen(), state: state),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) => _transitionPage(
        child: OnboardingScreen(
          onComplete: () {
            _rootNavigatorKey.currentContext?.go('/');
          },
        ),
        state: state,
      ),
    ),
    GoRoute(
      path: '/daily',
      pageBuilder: (context, state) =>
          _transitionPage(child: const DailyChallengeScreen(), state: state),
    ),
    GoRoute(
      path: '/daily-result',
      pageBuilder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;
        return _transitionPage(
          child: DailyResultScreen(
            timeSeconds: extras?['time'] ?? 0,
            hintsUsed: extras?['hints'] ?? 0,
          ),
          state: state,
          slideUp: true,
        );
      },
    ),
    GoRoute(
      path: '/levels',
      pageBuilder: (context, state) =>
          _transitionPage(child: const LevelSelectScreen(), state: state),
    ),
    GoRoute(
      path: '/game/:level',
      pageBuilder: (context, state) {
        final level = int.parse(state.pathParameters['level']!);
        final viewOnly = state.uri.queryParameters['viewOnly'] == 'true';
        return _transitionPage(
          child: GameScreen(levelNumber: level, viewOnly: viewOnly),
          state: state,
        );
      },
    ),
    GoRoute(
      path: '/result/:level',
      pageBuilder: (context, state) {
        final level = int.parse(state.pathParameters['level']!);
        final extras = state.extra as Map<String, dynamic>?;
        return _transitionPage(
          child: ResultScreen(
            levelNumber: level,
            timeSeconds: extras?['time'] ?? 0,
            hintsUsed: extras?['hints'] ?? 0,
            stars: extras?['stars'] ?? 1,
          ),
          state: state,
          slideUp: true,
        );
      },
    ),
    GoRoute(
      path: '/statistics',
      pageBuilder: (context, state) =>
          _transitionPage(child: const StatisticsScreen(), state: state),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) =>
          _transitionPage(child: const SettingsScreen(), state: state),
    ),
    GoRoute(
      path: '/achievements',
      pageBuilder: (context, state) =>
          _transitionPage(child: const AchievementsScreen(), state: state),
    ),
    GoRoute(
      path: '/multiplayer',
      pageBuilder: (context, state) =>
          _transitionPage(child: const MultiplayerLobbyScreen(), state: state),
    ),
    GoRoute(
      path: '/multiplayer-game',
      pageBuilder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return _transitionPage(
          child: MultiplayerGameScreen(
            playerNames: List<String>.from(extras['names']),
            totalRounds: extras['rounds'],
            difficulty: extras['difficulty'],
            operation: extras['operation'],
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: '/multiplayer-result',
      pageBuilder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return _transitionPage(
          child: MultiplayerResultScreen(
            playerNames: List<String>.from(extras['names']),
            results: extras['results'],
            totalRounds: extras['rounds'],
          ),
          state: state,
          slideUp: true,
        );
      },
    ),
    GoRoute(
      path: '/privacy',
      pageBuilder: (context, state) =>
          _transitionPage(child: const PrivacyPolicyScreen(), state: state),
    ),
  ],
);
