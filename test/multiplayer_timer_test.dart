import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/l10n/app_localizations.dart';
import 'package:cryptiq/presentation/screens/multiplayer_game_screen.dart';

Widget app() => const MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiplayerGameScreen(
        playerNames: ['Ana', 'Budi'],
        totalRounds: 1,
        difficulty: 'easy',
        operation: '+',
        allowHints: true,
      ),
    );

Future<void> seconds(WidgetTester tester, int n) async {
  for (var i = 0; i < n; i++) {
    await tester.pump(const Duration(seconds: 1));
  }
}

void main() {
  testWidgets("a player's timer pauses while the app is in the background",
      (tester) async {
    await tester.pumpWidget(app());
    await tester.tap(find.text("I'm Ready!"));
    await tester.pump();
    await seconds(tester, 3);
    expect(find.text('00:03'), findsOneWidget);

    // Frames aren't drawn while paused, so only check the clock after resuming.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump(const Duration(seconds: 10));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await seconds(tester, 2);
    expect(find.text('00:05'), findsOneWidget,
        reason: 'the 10 seconds in the background must not be counted');

    await tester.pumpWidget(const SizedBox());
  });
}
