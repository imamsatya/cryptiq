import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/l10n/app_localizations.dart';
import 'package:cryptiq/presentation/screens/level_select_screen.dart';
import 'helpers/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initTestDatabase);

  testWidgets('tapping a locked level explains how to unlock it', (tester) async {
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
        home: LevelSelectScreen(),
      ),
    ));
    await tester.pump();

    // Fresh install: level 1 is open, level 2 is the first locked tile.
    await tester.tap(find.byIcon(Icons.lock_rounded).first);
    await tester.pump();

    expect(find.text('🔒 Complete level 1 to unlock this one'), findsOneWidget);
    expect(find.widgetWithText(SnackBarAction, 'Go Pro'), findsOneWidget);
  });
}
