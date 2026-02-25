import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for de (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([super.locale = 'de']);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'Spielen';

  @override
  String get dailyChallenge => 'Tägliche Herausforderung';

  @override
  String get statistics => 'Statistiken';

  @override
  String get settings => 'Einstellungen';

  @override
  String level(int number) {
    return 'Level {number}';
  }

  @override
  String get easy => 'Leicht';

  @override
  String get medium => 'Mittel';

  @override
  String get hard => 'Schwer';

  @override
  String get expert => 'Experte';

  @override
  String get hint => 'Hinweis';

  @override
  String get check => 'Prüfen';

  @override
  String get clear => 'Löschen';

  @override
  String get clearAll => 'Alles Löschen';

  @override
  String get congratulations => 'Glückwunsch!';

  @override
  String get puzzleSolved => 'Rätsel Gelöst!';

  @override
  String get nextLevel => 'Nächstes Level';

  @override
  String get replay => 'Wiederholen';

  @override
  String get share => 'Teilen';

  @override
  String get time => 'Zeit';

  @override
  String get hints => 'Hinweise';

  @override
  String get bestTime => 'Beste Zeit';

  @override
  String get levelsCompleted => 'Level Abgeschlossen';

  @override
  String get totalTime => 'Gesamtzeit';

  @override
  String get averageTime => 'Durchschnittszeit';

  @override
  String get hintsUsed => 'Hinweise Verwendet';

  @override
  String get currentStreak => 'Aktuelle Serie';

  @override
  String get bestStreak => 'Beste Serie';

  @override
  String get sound => 'Ton';

  @override
  String get haptics => 'Haptik';

  @override
  String get language => 'Sprache';

  @override
  String get about => 'Über';

  @override
  String get privacyPolicy => 'Datenschutz';

  @override
  String get rateApp => 'App Bewerten';

  @override
  String get removeAds => 'Werbung Entfernen';

  @override
  String get restorePurchase => 'Kauf Wiederherstellen';

  @override
  String get tryAgain => 'Erneut Versuchen';

  @override
  String get wrongAnswer => 'Falsche Antwort';

  @override
  String get someDigitsWrong => 'Einige Ziffern sind falsch. Versuche es erneut!';

  @override
  String get allLevelsFree => 'Alle Level sind KOSTENLOS!';

  @override
  String get noLockedLevels => 'Keine gesperrten Level, nie.';

  @override
  String get home => 'Start';

  @override
  String get back => 'Zurück';

  @override
  String get resume => 'Fortsetzen';

  @override
  String stars(int count) {
    return '{count} Sterne';
  }

}
