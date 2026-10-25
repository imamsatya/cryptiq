import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:cryptiq/core/services/daily_challenge_service.dart';
import 'package:cryptiq/data/datasources/local_database.dart';
import 'package:cryptiq/l10n/app_localizations.dart';
import 'package:cryptiq/presentation/screens/home_screen.dart';
import 'helpers/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await initTestDatabase();
    // Home asks for the notification permission; answer the plugin's calls.
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      (call) async => true,
    );
  });

  final daily = DailyChallengeService.instance;
  final now = DateTime(2026, 10, 25, 10);

  setUp(() async {
    final box = LocalDatabase.instance.settingsBox;
    await box.clear();
    await LocalDatabase.instance.setProStatus(false);
    // Reminders off: this test is about reviving, and the notification plugin
    // keeps async work running past the end of a widget test.
    await box.put('notifications_enabled', false);
    // 12-day streak, last played 2026-10-23: yesterday was missed.
    await box.put('daily_streak', 12);
    await box.put('daily_last_streak_date', '2026-10-23');
    daily.clock = () => now;
  });
  tearDown(() => daily.clock = DateTime.now);

  Future<void> pumpHome(WidgetTester tester) async {
    // Taller than a phone: the test font is much wider than Poppins, which
    // makes the (non-scrolling) home screen overflow even without revive.
    tester.view.physicalSize = const Size(1080, 2700);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
    final router = GoRouter(routes: [
      GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
      // Like the real Daily screen: a Scaffold, so snackbars can show on it.
      GoRoute(path: '/daily', builder: (_, _) => const Scaffold(body: Text('DAILY SCREEN'))),
    ]);
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ));
    await tester.pump();
  }

  /// pumpAndSettle never settles: Home's particle background animates forever.
  /// The real delays let Hive's file writes (real I/O) complete.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 10; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> finish(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 5)); // let snackbars time out
    // Let file writes and notification scheduling started by the app finish
    // in real time, or the test never completes.
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 500)));
  }

  testWidgets('tapping Daily with a broken streak offers to restore it first',
      (tester) async {
    await pumpHome(tester);
    expect(find.text('Restore your 🔥 12-day streak'), findsOneWidget);

    await tester.tap(find.text('Restore your 🔥 12-day streak'));
    await tester.pump();
    expect(find.text('Save your 12-day streak?'), findsOneWidget);
    expect(find.text('Watch video'), findsOneWidget, reason: 'free users watch an ad');
    expect(find.text('DAILY SCREEN'), findsNothing, reason: 'asked before playing');

    await tester.tap(find.text('No Thanks'));
    await settle(tester);
    expect(find.text('DAILY SCREEN'), findsOneWidget);
    expect(daily.streak, 0, reason: 'declining changes nothing');
    expect(daily.shouldOfferRevive, isFalse, reason: 'not asked again today');
    await finish(tester);
  });
}
