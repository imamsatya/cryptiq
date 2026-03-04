// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'Jouer';

  @override
  String get dailyChallenge => 'Défi Quotidien';

  @override
  String get statistics => 'Statistiques';

  @override
  String get settings => 'Paramètres';

  @override
  String level(int number) {
    return 'Niveau $number';
  }

  @override
  String get easy => 'Facile';

  @override
  String get medium => 'Moyen';

  @override
  String get hard => 'Difficile';

  @override
  String get expert => 'Expert';

  @override
  String get hint => 'Indice';

  @override
  String get check => 'Vérifier';

  @override
  String get clear => 'Effacer';

  @override
  String get clearAll => 'Tout Effacer';

  @override
  String get congratulations => 'Félicitations!';

  @override
  String get puzzleSolved => 'Puzzle Résolu!';

  @override
  String get nextLevel => 'Niveau Suivant';

  @override
  String get replay => 'Rejouer';

  @override
  String get share => 'Partager';

  @override
  String get time => 'Temps';

  @override
  String get hints => 'Indices';

  @override
  String get bestTime => 'Meilleur Temps';

  @override
  String levelsCompleted(int count, int total) {
    return 'Niveaux Terminés';
  }

  @override
  String get totalTime => 'Temps Total';

  @override
  String get averageTime => 'Moyenne';

  @override
  String get hintsUsed => 'Indices Utilisés';

  @override
  String get currentStreak => 'Série Actuelle';

  @override
  String get bestStreak => 'Meilleure Série';

  @override
  String get sound => 'Son';

  @override
  String get haptics => 'Vibration';

  @override
  String get language => 'Langue';

  @override
  String get about => 'À propos';

  @override
  String get privacyPolicy => 'Confidentialité';

  @override
  String get rateApp => 'Noter l\'App';

  @override
  String get removeAds => 'Supprimer les Pubs';

  @override
  String get restorePurchase => 'Restaurer l\'Achat';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get wrongAnswer => 'Mauvaise Réponse';

  @override
  String get someDigitsWrong => 'Certains chiffres sont incorrects. Réessayez!';

  @override
  String get allLevelsFree => 'Tous les niveaux sont GRATUITS!';

  @override
  String get noLockedLevels => 'Aucun niveau bloqué, jamais.';

  @override
  String get home => 'Accueil';

  @override
  String get back => 'Retour';

  @override
  String get resume => 'Continuer';

  @override
  String stars(int count) {
    return '$count Étoiles';
  }

  @override
  String get selectLevel => 'Choisir Niveau';

  @override
  String get badges => 'Badges';

  @override
  String get passAndPlay => 'Passer et Jouer (2-4)';

  @override
  String get decodeTheLogic => 'Déchiffrez la Logique';

  @override
  String continueLevel(int number) {
    return 'Continuer (Niveau $number)';
  }

  @override
  String get selectDifficulty => 'Choisir Difficulté';

  @override
  String get all => 'Tous';

  @override
  String get completed => 'Terminé';

  @override
  String get locked => 'Verrouillé';

  @override
  String get unlocked => 'Déverrouillé';

  @override
  String get theme => 'Thème';

  @override
  String get replayTutorial => 'Revoir le Tutoriel';

  @override
  String get version => 'Version';

  @override
  String get contactUs => 'Contact';

  @override
  String get resetProgress => 'Réinitialiser';

  @override
  String get correct => 'Correct!';

  @override
  String get incorrect => 'Incorrect';

  @override
  String get round => 'Manche';

  @override
  String get player => 'Joueur';

  @override
  String get score => 'Score';

  @override
  String get winner => 'Gagnant';

  @override
  String get draw => 'Égalité';

  @override
  String get players => 'Joueurs';

  @override
  String get rounds => 'Manches';

  @override
  String get difficulty => 'Difficulté';

  @override
  String get operation => 'Opération';

  @override
  String get mixed => 'Mixte';

  @override
  String get startGame => 'Commencer';

  @override
  String get achievements => 'Succès';

  @override
  String get streak => 'Série';

  @override
  String get solvedIn => 'Résolu en';

  @override
  String get seconds => 'secondes';

  @override
  String get noHintsUsed => 'Sans indices';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get results => 'Résultats';

  @override
  String get dailyStreak => 'Série Quotidienne';

  @override
  String get giveUp => 'Abandonner';

  @override
  String get rematch => 'Revanche';

  @override
  String get achievementUnlocked => 'Succès Débloqué!';

  @override
  String get noHintsAvailable => 'Plus d\'indices pour ce puzzle';

  @override
  String get overallProgress => 'Progrès Global';

  @override
  String roundNumber(int number) {
    return 'Manche $number';
  }

  @override
  String dayStreak(int count) {
    return '$count Jours de Suite!';
  }

  @override
  String get shareResult => 'Partager';

  @override
  String get dailyComplete => 'Défi Quotidien Réussi!';

  @override
  String get completeMoreLevels => 'Complète plus de niveaux pour rejouer';

  @override
  String get viewSolution => 'Voir Solution';

  @override
  String get attempts => 'Tentatives';

  @override
  String get close => 'Fermer';

  @override
  String get game => 'Game';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get hapticFeedback => 'Haptic Feedback';

  @override
  String get dailyReminder => 'Daily Reminder';

  @override
  String get appearance => 'Appearance';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get noAds => 'No Ads';

  @override
  String get allThemes => 'All Themes';

  @override
  String get bonusHint => '+1 Bonus Hint';

  @override
  String get goPro => 'Go Pro';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => 'By Difficulty';

  @override
  String get totalStars => 'Total Stars';

  @override
  String get avgTime => 'Avg. Time';

  @override
  String get enjoyingApp => 'Enjoying CryptiQ?';

  @override
  String get rateAppBody =>
      'If you like the app, please take a moment to rate it!';

  @override
  String get noThanks => 'No Thanks';

  @override
  String get later => 'Later';

  @override
  String get rateNow => 'Rate Now ⭐';

  @override
  String get undo => 'Undo';

  @override
  String get overview => 'Overview';

  @override
  String get dataCollection => 'Data Collection';

  @override
  String get thirdPartyServices => 'Third-Party Services';

  @override
  String get dataStorage => 'Data Storage';

  @override
  String get childrenPrivacy => 'Children\'s Privacy';

  @override
  String get changes => 'Changes';

  @override
  String get contact => 'Contact';

  @override
  String get lastUpdated => 'Last Updated';

  @override
  String levelsOf(int completed, int total) {
    return '$completed of $total levels completed';
  }

  @override
  String get tutorialWelcomeTitle => 'Welcome to CryptiQ!';

  @override
  String get tutorialWelcomeBody =>
      'Each letter represents a unique digit (0-9).\nYour goal: find which digit each letter stands for\nso the equation is correct.';

  @override
  String get tutorialSelectTitle => 'Step 1: Select a Letter';

  @override
  String get tutorialSelectBody =>
      'Tap on any letter tile in the equation.\nIt will highlight, showing it\'s selected.';

  @override
  String get tutorialAssignTitle => 'Step 2: Assign a Digit';

  @override
  String get tutorialAssignBody =>
      'Use the number pad to assign a digit (0-9)\nto the selected letter.\nEach digit can only be used once!';

  @override
  String get tutorialCheckTitle => 'Step 3: Check Your Answer';

  @override
  String get tutorialCheckBody =>
      'Once all letters have digits, tap \"Check\".\nWrong letters turn red — fix them!\nUse Hints or Undo if you get stuck.';

  @override
  String get tutorialGoTitle => 'You\'re Ready!';

  @override
  String get tutorialGoBody =>
      'Solve fast with fewer hints for ⭐⭐⭐!\nGood luck and have fun! 🧩';

  @override
  String get next => 'Next';

  @override
  String get autoFillNext => 'Auto-select Next Letter';

  @override
  String get onboardingWelcomeTitle => 'Welcome to CryptiQ!';

  @override
  String get onboardingWelcomeSubtitle => 'Decode the Logic';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ is a cryptarithm puzzle game where each letter represents a unique digit (0-9).\n\nYour goal: figure out which digit goes with which letter to make the equation true!';

  @override
  String get onboardingHowToPlay => 'How to Play';

  @override
  String get onboardingSelectAssign => 'Select & Assign';

  @override
  String get onboardingExample => 'If S=9, E=5, N=6, D=7\nthen SEND = 9567';

  @override
  String get onboardingNeedHelp => 'Need Help?';

  @override
  String get onboardingDailyTitle => 'Daily Challenge';

  @override
  String get onboardingDailySubtitle => 'Come Back Every Day!';

  @override
  String get onboardingReady => 'Ready? Let\'s go! 🚀';

  @override
  String get skip => 'Skip';

  @override
  String get startPlaying => 'Start Playing';

  @override
  String playerName(int number) {
    return 'Player $number';
  }

  @override
  String get addPlayer => 'Add Player';

  @override
  String roundsLabel(int count) {
    return 'Rounds: $count';
  }

  @override
  String get addition => 'Addition (+)';

  @override
  String get subtraction => 'Subtraction (−)';

  @override
  String get multiply => 'Multiply (×)';

  @override
  String get multiStep => 'Multi-step';

  @override
  String get passDevice => 'Pass the device to this player';

  @override
  String get roundDetails => 'Round Details';

  @override
  String get gaveUp => 'Gave up';

  @override
  String get beatMyTime => 'Can you beat my time?';

  @override
  String get allLevelsFreeTitle => 'All 1200 Levels FREE';

  @override
  String get allLevelsFreeBody => 'No locked levels, no paywall. Enjoy!';

  @override
  String get privacyOverviewBody =>
      'We respect your privacy and are committed to protecting your personal information.';

  @override
  String get privacyDataBody =>
      'All game progress is stored locally on your device using offline storage (Hive). We do not require account creation or login.';

  @override
  String get privacyStorageBody =>
      'All data (game progress, settings, achievements) is stored locally on your device. Uninstalling the app will remove all local data.';

  @override
  String get privacyChangesBody =>
      'We may update this policy. Continued use of the app after changes constitutes acceptance.';

  @override
  String privacyContactBody(String email) {
    return 'For questions, email: $email';
  }

  @override
  String get multiStepLabel => 'Multi-step';

  @override
  String get stars3 => 'Stars';

  @override
  String get onboardingHowToPlayBody =>
      '1. Tap a letter tile to select it\n2. Tap a number (0-9) to assign it\n3. Each letter must have a unique digit\n4. Long-press a letter to clear it';

  @override
  String get onboardingHelpSubtitle => 'Hints & Checking';

  @override
  String get onboardingHelpBody =>
      '• Tap 💡 Hint to reveal one correct letter\n• Tap ✓ Check to verify your solution\n• Wrong letters glow red, correct ones glow green\n• Try to solve with fewer hints for more ⭐ stars!';

  @override
  String get onboardingDailyBody =>
      '• A new puzzle appears every day\n• Build your streak 🔥 by playing daily\n• Unlock achievements as you play\n• 1200 levels from Easy to Expert — all FREE!';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  No hints, fast solve\n⭐⭐     1-2 hints\n⭐       3+ hints';

  @override
  String usedBy(String letter) {
    return 'Used by: $letter';
  }

  @override
  String get notUsed => 'Not used';

  @override
  String get replayConfirmTitle => 'Replay this level?';

  @override
  String get replayConfirmBody =>
      'You already have ⭐⭐⭐ on this level. Your best score will be kept.';

  @override
  String get cancel => 'Cancel';

  @override
  String get newBadge => 'NEW';
}
