import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/l10n/app_localizations.dart';
import 'package:cryptiq/presentation/screens/settings_screen.dart';
import 'helpers/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initTestDatabase);

  for (final code in ['en', 'de', 'hi']) {
    testWidgets('Pro card lists every real benefit without overflow ($code)',
        (tester) async {
      tester.view.physicalSize = const Size(720, 1520); // small 360dp phone
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
          locale: Locale(code),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsScreen(),
        ),
      ));
      await tester.pump();

      final l10n = lookupAppLocalizations(Locale(code));
      for (final benefit in [
        l10n.noAds,
        l10n.unlimitedHints,
        l10n.allLevelsUnlocked,
        l10n.allThemes,
        l10n.proMorePlayers,
      ]) {
        expect(find.text(benefit), findsOneWidget, reason: benefit);
      }
      expect(tester.takeException(), isNull); // e.g. RenderFlex overflow
    });
  }
}
