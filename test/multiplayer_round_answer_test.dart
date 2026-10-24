import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/l10n/app_localizations.dart';
import 'package:cryptiq/presentation/screens/multiplayer_game_screen.dart';

void main() {
  // Ready / Give Up / Next don't play sounds, so no audio plugin is needed.
  testWidgets('answer is revealed after every player has played the round',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
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
        totalRounds: 2,
        difficulty: 'easy',
        operation: '+',
        allowHints: true,
      ),
    ));

    for (final player in ['Ana', 'Budi']) {
      expect(find.text(player), findsOneWidget); // handoff screen
      await tester.tap(find.text("I'm Ready!"));
      await tester.pump();
      expect(find.text('Answer'), findsNothing,
          reason: 'no spoiler while $player still has to play');
      await tester.tap(find.text('Give Up'));
      await tester.pump();
    }

    expect(find.text('Round 1 of 2'), findsOneWidget);
    expect(find.text('Answer'), findsOneWidget);
    expect(find.textContaining('✗ Gave up'), findsNWidgets(2));

    await tester.tap(find.text('Next'));
    await tester.pump();
    expect(find.text('Round 2 of 2'), findsOneWidget); // next round's handoff
    expect(find.text('Answer'), findsNothing);
  });
}
