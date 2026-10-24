import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/l10n/app_localizations.dart';
import 'package:cryptiq/presentation/screens/daily_challenge_screen.dart';
import 'helpers/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initTestDatabase);

  testWidgets('daily challenge timer pauses while the app is in the background',
      (tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: DailyChallengeScreen(),
      ),
    ));
    await tester.pump(); // timer starts in a microtask
    for (var i = 0; i < 3; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.text('00:03'), findsOneWidget);

    // Frames aren't drawn while paused, so only check the clock after resuming.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump(const Duration(seconds: 10));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    for (var i = 0; i < 2; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.text('00:05'), findsOneWidget,
        reason: 'the 10 seconds in the background must not be counted');

    await tester.pumpWidget(const SizedBox()); // dispose the screen and its timer
  });
}
