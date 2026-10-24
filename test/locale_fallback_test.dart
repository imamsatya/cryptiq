import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/l10n/app_localizations.dart';
import 'package:cryptiq/presentation/providers/locale_provider.dart';

/// Pumps an app configured like CryptiqApp with "System Default" language and
/// returns the locale Flutter resolves for [deviceLocales].
Future<Locale> resolveFor(WidgetTester tester, List<Locale> deviceLocales) async {
  tester.platformDispatcher.localesTestValue = deviceLocales;
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);
  late Locale resolved;
  await tester.pumpWidget(MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: appSupportedLocales,
    home: Builder(builder: (context) {
      resolved = Localizations.localeOf(context);
      return const SizedBox();
    }),
  ));
  return resolved;
}

void main() {
  testWidgets('untranslated device languages fall back to English, not Arabic',
      (tester) async {
    for (final device in const [
      Locale('ru', 'RU'),
      Locale('tr', 'TR'),
      Locale('it', 'IT'),
      Locale('ms', 'MY'),
    ]) {
      expect((await resolveFor(tester, [device])).languageCode, 'en',
          reason: 'device locale $device');
    }
  });

  testWidgets('translated device languages are still used', (tester) async {
    expect((await resolveFor(tester, const [Locale('id', 'ID')])).languageCode, 'id');
    expect((await resolveFor(tester, const [Locale('ar', 'SA')])).languageCode, 'ar');
    expect((await resolveFor(tester, const [Locale('pt', 'BR')])).languageCode, 'pt');
    expect((await resolveFor(tester, const [Locale('zh', 'TW')])).languageCode, 'zh');
  });

  testWidgets('a translated secondary device language beats the fallback',
      (tester) async {
    final resolved =
        await resolveFor(tester, const [Locale('ru', 'RU'), Locale('de', 'DE')]);
    expect(resolved.languageCode, 'de');
  });

  test('every generated locale is still supported', () {
    expect(appSupportedLocales.toSet(), AppLocalizations.supportedLocales.toSet());
    expect(appSupportedLocales.first, const Locale('en'));
  });
}
