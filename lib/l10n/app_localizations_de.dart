// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

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
    return 'Level $number';
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
  String get puzzleSolved => 'Puzzle Gelöst!';

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
  String get allowHints => 'Allow Hints';

  @override
  String get bestTime => 'Bestzeit';

  @override
  String levelsCompleted(int count, int total) {
    return '$count/$total abgeschlossen';
  }

  @override
  String get totalTime => 'Gesamtzeit';

  @override
  String get averageTime => 'Durchschnitt';

  @override
  String get hintsUsed => 'Hinweise Benutzt';

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
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get rateApp => 'App Bewerten';

  @override
  String get removeAds => 'Werbung Entfernen';

  @override
  String get restorePurchase => 'Kauf Wiederherstellen';

  @override
  String get storeTitle => 'Store';

  @override
  String get proActiveDesc => 'All premium features unlocked!';

  @override
  String get proDesc => 'Remove all ads forever and support the developer.';

  @override
  String get purchased => 'Purchased';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get purchasesRestored => 'Purchases restored';

  @override
  String get tryAgain => 'Erneut Versuchen';

  @override
  String get wrongAnswer => 'Falsche Antwort';

  @override
  String get someDigitsWrong =>
      'Einige Ziffern sind falsch. Versuche es erneut!';

  @override
  String get fillAllLetters => 'Please fill all letters first!';

  @override
  String get allLevelsFree => 'Alle Level sind GRATIS!';

  @override
  String get noLockedLevels => 'Keine gesperrten Level, nie.';

  @override
  String get home => 'Startseite';

  @override
  String get back => 'Zurück';

  @override
  String get resume => 'Fortsetzen';

  @override
  String stars(int count) {
    return '$count Sterne';
  }

  @override
  String get selectLevel => 'Level Wählen';

  @override
  String get badges => 'Abzeichen';

  @override
  String get passAndPlay => 'Weitergeben & Spielen';

  @override
  String get decodeTheLogic => 'Entschlüssle die Logik';

  @override
  String continueLevel(int number) {
    return 'Fortsetzen (Level $number)';
  }

  @override
  String get selectDifficulty => 'Schwierigkeit Wählen';

  @override
  String get all => 'Alle';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get locked => 'Gesperrt';

  @override
  String get unlocked => 'Entsperrt';

  @override
  String get theme => 'Thema';

  @override
  String get replayTutorial => 'Tutorial Wiederholen';

  @override
  String get version => 'Version';

  @override
  String get contactUs => 'Kontaktiere Uns';

  @override
  String get resetProgress => 'Fortschritt Zurücksetzen';

  @override
  String get correct => 'Richtig!';

  @override
  String get incorrect => 'Falsch';

  @override
  String get round => 'Runde';

  @override
  String get player => 'Spieler';

  @override
  String get score => 'Punktzahl';

  @override
  String get winner => 'Gewinner';

  @override
  String get draw => 'Unentschieden';

  @override
  String get players => 'Spieler';

  @override
  String get rounds => 'Runden';

  @override
  String get difficulty => 'Schwierigkeit';

  @override
  String get operation => 'Operation';

  @override
  String get mixed => 'Gemischt';

  @override
  String get startGame => 'Starten';

  @override
  String get achievements => 'Erfolge';

  @override
  String get streak => 'Serie';

  @override
  String get solvedIn => 'Gelöst in';

  @override
  String get seconds => 'Sekunden';

  @override
  String get noHintsUsed => 'Keine Hinweise';

  @override
  String get playAgain => 'Nochmal Spielen';

  @override
  String get results => 'Ergebnisse';

  @override
  String get dailyStreak => 'Tägliche Serie';

  @override
  String get giveUp => 'Aufgeben';

  @override
  String get rematch => 'Revanche';

  @override
  String get achievementUnlocked => 'Erfolg Freigeschaltet!';

  @override
  String get noHintsAvailable => 'Keine Hinweise für dieses Puzzle';

  @override
  String get overallProgress => 'Gesamtfortschritt';

  @override
  String roundNumber(int number) {
    return 'Runde $number';
  }

  @override
  String dayStreak(int count) {
    return '$count Tage Serie!';
  }

  @override
  String get shareResult => 'Ergebnis Teilen';

  @override
  String get dailyComplete => 'Tägliche Herausforderung Geschafft!';

  @override
  String get completeMoreLevels => 'Schließe mehr Level ab zum Wiederholen';

  @override
  String get viewSolution => 'Lösung Anzeigen';

  @override
  String get attempts => 'Versuche';

  @override
  String get close => 'Schließen';

  @override
  String get game => 'Spiel';

  @override
  String get soundEffects => 'Soundeffekte';

  @override
  String get hapticFeedback => 'Haptisches Feedback';

  @override
  String get dailyReminder => 'Tägliche Erinnerung';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get upgradeToPro => 'Auf Pro Upgraden';

  @override
  String get noAds => 'Keine Werbung';

  @override
  String get allThemes => 'Alle Themen';

  @override
  String get bonusHint => '+1 Bonus Hinweis';

  @override
  String get goPro => 'Pro Werden';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => 'Nach Schwierigkeit';

  @override
  String get totalStars => 'Gesamtsterne';

  @override
  String get avgTime => 'Durchschnittszeit';

  @override
  String get enjoyingApp => 'Gefällt dir CryptiQ?';

  @override
  String get rateAppBody =>
      'Wenn dir die App gefällt, nimm dir einen Moment zum Bewerten!';

  @override
  String get levelSelectHint =>
      '💡 Tip: Tap to play, long-press a completed level for details.';

  @override
  String get noThanks => 'Nein, Danke';

  @override
  String get later => 'Später';

  @override
  String get rateNow => 'Jetzt Bewerten ⭐';

  @override
  String get undo => 'Rückgängig';

  @override
  String get overview => 'Übersicht';

  @override
  String get dataCollection => 'Datenerhebung';

  @override
  String get thirdPartyServices => 'Drittanbieterdienste';

  @override
  String get dataStorage => 'Datenspeicherung';

  @override
  String get childrenPrivacy => 'Datenschutz für Kinder';

  @override
  String get changes => 'Änderungen';

  @override
  String get contact => 'Kontakt';

  @override
  String get lastUpdated => 'Letzte Aktualisierung';

  @override
  String levelsOf(int completed, int total) {
    return '$completed von $total Level abgeschlossen';
  }

  @override
  String get tutorialWelcomeTitle => 'Willkommen bei CryptiQ!';

  @override
  String get tutorialWelcomeBody =>
      'Jeder Buchstabe steht für eine eindeutige Ziffer (0-9).\nDein Ziel: Finde heraus, welche Ziffer jeder Buchstabe\ndarstellt, damit die Gleichung stimmt.';

  @override
  String get tutorialSelectTitle => 'Schritt 1: Wähle einen Buchstaben';

  @override
  String get tutorialSelectBody =>
      'Tippe auf einen beliebigen Buchstaben in der Gleichung.\nEr wird hervorgehoben, um die Auswahl anzuzeigen.';

  @override
  String get tutorialAssignTitle => 'Schritt 2: Weise eine Ziffer Zu';

  @override
  String get tutorialAssignBody =>
      'Nutze das Zahlenfeld, um eine Ziffer (0-9)\ndem ausgewählten Buchstaben zuzuweisen.\nJede Ziffer kann nur einmal verwendet werden!';

  @override
  String get tutorialCheckTitle => 'Schritt 3: Überprüfe deine Antwort';

  @override
  String get tutorialCheckBody =>
      'Wenn alle Buchstaben Ziffern haben, tippe \"Prüfen\".\nFalsche Buchstaben werden rot — korrigiere sie!\nNutze Hinweise oder Rückgängig wenn du nicht weiterkommst.';

  @override
  String get tutorialGoTitle => 'Du bist Bereit!';

  @override
  String get tutorialGoBody =>
      'Löse schnell mit weniger Hinweisen für ⭐⭐⭐!\nViel Glück und Spaß! 🧩';

  @override
  String get next => 'Weiter';

  @override
  String get autoFillNext => 'Nächsten Buchstaben Automatisch Wählen';

  @override
  String get onboardingWelcomeTitle => 'Willkommen bei CryptiQ!';

  @override
  String get onboardingWelcomeSubtitle => 'Entschlüssle die Logik';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ ist ein Kryptarithmetik-Puzzlespiel, bei dem jeder Buchstabe eine eindeutige Ziffer (0-9) darstellt.\n\nDein Ziel: Finde heraus, welche Ziffer zu jedem Buchstaben gehört, damit die Gleichung stimmt!';

  @override
  String get onboardingHowToPlay => 'So Spielst Du';

  @override
  String get onboardingSelectAssign => 'Auswählen und Zuweisen';

  @override
  String get onboardingExample => 'Wenn S=9, E=5, N=6, D=7\ndann SEND = 9567';

  @override
  String get onboardingNeedHelp => 'Brauchst du Hilfe?';

  @override
  String get onboardingDailyTitle => 'Tägliche Herausforderung';

  @override
  String get onboardingDailySubtitle => 'Komm Jeden Tag Zurück!';

  @override
  String get onboardingReady => 'Bereit? Los geht\'s! 🚀';

  @override
  String get skip => 'Überspringen';

  @override
  String get startPlaying => 'Jetzt Spielen';

  @override
  String playerName(int number) {
    return 'Spieler $number';
  }

  @override
  String get addPlayer => 'Spieler Hinzufügen';

  @override
  String roundsLabel(int count) {
    return 'Runden: $count';
  }

  @override
  String get addition => 'Addition (+)';

  @override
  String get subtraction => 'Subtraktion (−)';

  @override
  String get multiply => 'Multiplikation (×)';

  @override
  String get multiStep => 'Mehrstufig';

  @override
  String get passDevice => 'Gib das Gerät an diesen Spieler weiter';

  @override
  String get roundDetails => 'Rundendetails';

  @override
  String get gaveUp => 'Aufgegeben';

  @override
  String get beatMyTime => 'Kannst du meine Zeit schlagen?';

  @override
  String get allLevelsFreeTitle => 'Alle 1200 Level GRATIS';

  @override
  String get allLevelsFreeBody => 'Keine gesperrten Level. Viel Spaß!';

  @override
  String get privacyOverviewBody =>
      'Wir respektieren deine Privatsphäre und setzen uns für den Schutz deiner persönlichen Daten ein.';

  @override
  String get privacyDataBody =>
      'Der gesamte Spielfortschritt wird lokal auf deinem Gerät gespeichert (Hive). Wir benötigen keine Kontoerstellung oder Anmeldung.';

  @override
  String get privacyStorageBody =>
      'Alle Daten (Fortschritt, Einstellungen, Erfolge) werden lokal gespeichert. Das Deinstallieren der App löscht alle lokalen Daten.';

  @override
  String get privacyChangesBody =>
      'Wir können diese Richtlinie aktualisieren. Die weitere Nutzung nach Änderungen gilt als Zustimmung.';

  @override
  String privacyContactBody(String email) {
    return 'Bei Fragen, E-Mail: $email';
  }

  @override
  String get multiStepLabel => 'Mehrstufig';

  @override
  String get stars3 => 'Sterne';

  @override
  String get onboardingHowToPlayBody =>
      '1. Tippe auf einen Buchstaben zum Auswählen\n2. Tippe auf eine Zahl (0-9) zum Zuweisen\n3. Jeder Buchstabe muss eine eindeutige Ziffer haben\n4. Halte einen Buchstaben gedrückt zum Löschen';

  @override
  String get onboardingHelpSubtitle => 'Hinweise und Prüfung';

  @override
  String get onboardingHelpBody =>
      '• Tippe 💡 Hinweis um einen Buchstaben aufzudecken\n• Tippe ✓ Prüfen zum Überprüfen\n• Falsche Buchstaben werden rot, richtige grün\n• Löse mit weniger Hinweisen für mehr ⭐!';

  @override
  String get onboardingDailyBody =>
      '• Jeden Tag ein neues Puzzle\n• Baue deine Serie 🔥 durch tägliches Spielen auf\n• Schalte Erfolge frei während du spielst\n• 1200 Level von Leicht bis Experte — alle GRATIS!';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  Keine Hinweise, schnell\n⭐⭐     1-2 Hinweise\n⭐       3+ Hinweise';

  @override
  String usedBy(String letter) {
    return 'Benutzt von: $letter';
  }

  @override
  String get notUsed => 'Nicht benutzt';

  @override
  String get replayConfirmTitle => 'Dieses Level wiederholen?';

  @override
  String get replayConfirmBody =>
      'Du hast bereits ⭐⭐⭐ auf diesem Level. Deine Bestpunktzahl bleibt erhalten.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get newBadge => 'NEU';

  @override
  String get themePicker => 'Thema';

  @override
  String get proThemeHint => 'Schalte mehr Themen mit Pro frei';

  @override
  String get shareStats => 'Statistiken Teilen';

  @override
  String get updateAvailable => 'Update Verfügbar';

  @override
  String get updateBody =>
      'Eine neue Version von CryptiQ ist verfügbar. Jetzt aktualisieren für das beste Erlebnis!';

  @override
  String get updateNow => 'Jetzt Aktualisieren';

  @override
  String get puzzlesSolved => 'Puzzles Gelöst';

  @override
  String get allDone => 'Alles Erledigt!';

  @override
  String hintCount(int count) {
    return 'Hinweis ($count)';
  }

  @override
  String get incorrectTryAgain => 'Falsch — versuche es erneut!';

  @override
  String playerScored(String player, int score) {
    return '$player hat $score Pkt. erzielt';
  }

  @override
  String hintsCount(int count) {
    return '$count Hinweise';
  }

  @override
  String roundOf(int current, int total) {
    return 'Runde $current von $total';
  }

  @override
  String get imReady => 'Ich bin Bereit!';

  @override
  String playerWins(String player) {
    return '$player Gewinnt!';
  }

  @override
  String playerStatsLine(int solved, int total, String time, int hints) {
    return '$solved/$total gelöst • $time • $hints Hinweise';
  }

  @override
  String scorePts(int score) {
    return '${score}Pkt';
  }

  @override
  String get playerNameHint => 'Spielername';

  @override
  String get multiStepNote =>
      'Mehrstufige Puzzles sind nur Schwer/Experte. Schwierigkeit wird ignoriert.';

  @override
  String percentUnlocked(String percent) {
    return '$percent% freigeschaltet';
  }

  @override
  String shareDailyText(String time, int streak) {
    return 'Ich habe die CryptiQ Tagesherausforderung in $time gelöst! 🔥 $streak Tage Serie! Kannst du das schlagen?\n\n#CryptiQ #Tagesherausforderung';
  }

  @override
  String get achvNoHints10Title => 'Scharfer Verstand';

  @override
  String get achvStreak30Title => 'Streak-Meister';

  @override
  String get achvStreak14Desc => '14-tägiger täglicher Challenge-Streak';

  @override
  String get achvPerfect50Desc => 'Erreiche 3 Sterne in 50 Levels';

  @override
  String get achvFiveHundredLevelsTitle => 'Auf halber Strecke';

  @override
  String get achvExpertMasterTitle => 'Erfahrener Kryptograph';

  @override
  String get achvLightningDesc =>
      'Lösen Sie ein Rätsel in weniger als 10 Sekunden';

  @override
  String get achvFirstSolveDesc => 'Löse dein erstes Rätsel';

  @override
  String get achvExpertMasterDesc => 'Schließe alle Expertenlevel ab';

  @override
  String get achvPerfect50Title => 'Einwandfrei';

  @override
  String get achvHundredLevelsDesc => 'Schließe 100 Level ab';

  @override
  String get achvHundredStarsDesc => 'Verdiene 100 Sterne';

  @override
  String get achvHardMasterDesc => 'Schließe alle schweren Level ab';

  @override
  String get achvHundredStarsTitle => 'Sternenjäger';

  @override
  String get achvStreak14Title => 'Zweiwöchiger Champion';

  @override
  String get achvPerfect10Desc => 'Erreiche 3 Sterne in 10 Leveln';

  @override
  String get achvHundredLevelsTitle => 'Zenturio';

  @override
  String get achvHardMasterTitle => 'Gehärtet';

  @override
  String get achvLightningTitle => 'Blitzschnell';

  @override
  String get achvTenStarsDesc => 'Verdiene 10 Sterne';

  @override
  String get achvFirstSolveTitle => 'Erste Schritte';

  @override
  String get achvStreak7Desc => '7-tägiger täglicher Challenge-Streak';

  @override
  String get achvPerfect10Title => 'Perfektionist';

  @override
  String get achvMediumMasterDesc => 'Schließe alle mittleren Level ab';

  @override
  String get achvSpeedDemonDesc =>
      'Lösen Sie ein Rätsel in weniger als 15 Sekunden';

  @override
  String get achvTenStarsTitle => 'Sternensammler';

  @override
  String get achvFiftyLevelsDesc => 'Schließe 50 Level ab';

  @override
  String get achvStreak7Title => 'Wochenkrieger';

  @override
  String get achvNoHints50Desc => 'Löse 50 Rätsel ohne Hinweise';

  @override
  String get achvMediumMasterTitle => 'Mittelselten';

  @override
  String get achvSpeedDemonTitle => 'Geschwindigkeitsdämon';

  @override
  String get achvThousandLevelsDesc => 'Schließe 1000 Level ab';

  @override
  String get achvFiftyLevelsTitle => 'Puzzle-Enthusiast';

  @override
  String get achvNoHints50Title => 'Pures Genie';

  @override
  String get achvThousandStarsDesc => 'Verdiene 1000 Sterne';

  @override
  String get achvThousandLevelsTitle => 'Großmeister';

  @override
  String get achvStreak3Desc => '3-tägiger täglicher Challenge-Streak';

  @override
  String get achvEasyMasterDesc => 'Schließe alle einfachen Level ab';

  @override
  String get achvNoHints10Desc => 'Löse 10 Rätsel ohne Hinweise';

  @override
  String get achvStreak100Title => 'Unaufhaltsam';

  @override
  String get achvStreak3Title => 'Auf Erfolgskurs';

  @override
  String get achvThousandStarsTitle => 'Konstellation';

  @override
  String get achvTenLevelsTitle => 'Aufwärmen';

  @override
  String get achvEasyMasterTitle => 'Kinderleicht';

  @override
  String get achvTenLevelsDesc => 'Schließe 10 Level ab';

  @override
  String get achvStreak30Desc => '30-tägiger täglicher Challenge-Streak';

  @override
  String get achvFiveHundredLevelsDesc => 'Schließe 500 Level ab';

  @override
  String get achvStreak100Desc => '100-tägiger täglicher Challenge-Streak';

  @override
  String get achvMultiStepFirstTitle => 'Kettenreaktion';

  @override
  String get achvMultiStepFirstDesc =>
      'Lösen Sie Ihr erstes mehrstufiges Rätsel';

  @override
  String get achvMultiStepAllDesc => 'Schließe alle 200 mehrstufigen Rätsel ab';

  @override
  String get achvMultiStepAllTitle => 'Kaskadenkönig';
}
