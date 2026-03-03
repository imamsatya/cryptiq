import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'CryptiQ'**
  String get appTitle;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @dailyChallenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get dailyChallenge;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level {number}'**
  String level(int number);

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// No description provided for @expert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get expert;

  /// No description provided for @hint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get hint;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @puzzleSolved.
  ///
  /// In en, this message translates to:
  /// **'Puzzle Solved!'**
  String get puzzleSolved;

  /// No description provided for @nextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next Level'**
  String get nextLevel;

  /// No description provided for @replay.
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get replay;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @hints.
  ///
  /// In en, this message translates to:
  /// **'Hints'**
  String get hints;

  /// No description provided for @bestTime.
  ///
  /// In en, this message translates to:
  /// **'Best Time'**
  String get bestTime;

  /// No description provided for @levelsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Levels Completed'**
  String get levelsCompleted;

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get totalTime;

  /// No description provided for @averageTime.
  ///
  /// In en, this message translates to:
  /// **'Average Time'**
  String get averageTime;

  /// No description provided for @hintsUsed.
  ///
  /// In en, this message translates to:
  /// **'Hints Used'**
  String get hintsUsed;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// No description provided for @bestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get bestStreak;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get restorePurchase;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @wrongAnswer.
  ///
  /// In en, this message translates to:
  /// **'Wrong Answer'**
  String get wrongAnswer;

  /// No description provided for @someDigitsWrong.
  ///
  /// In en, this message translates to:
  /// **'Some digits are incorrect. Try again!'**
  String get someDigitsWrong;

  /// No description provided for @allLevelsFree.
  ///
  /// In en, this message translates to:
  /// **'All levels are FREE!'**
  String get allLevelsFree;

  /// No description provided for @noLockedLevels.
  ///
  /// In en, this message translates to:
  /// **'No locked levels, ever.'**
  String get noLockedLevels;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @stars.
  ///
  /// In en, this message translates to:
  /// **'{count} Stars'**
  String stars(int count);

  /// No description provided for @selectLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Level'**
  String get selectLevel;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @passAndPlay.
  ///
  /// In en, this message translates to:
  /// **'Pass & Play (2-4)'**
  String get passAndPlay;

  /// No description provided for @decodeTheLogic.
  ///
  /// In en, this message translates to:
  /// **'Decode the Logic'**
  String get decodeTheLogic;

  /// No description provided for @continueLevel.
  ///
  /// In en, this message translates to:
  /// **'Continue (Level {number})'**
  String continueLevel(int number);

  /// No description provided for @selectDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Select Difficulty'**
  String get selectDifficulty;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @replayTutorial.
  ///
  /// In en, this message translates to:
  /// **'Replay Tutorial'**
  String get replayTutorial;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @resetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress'**
  String get resetProgress;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrect;

  /// No description provided for @round.
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get round;

  /// No description provided for @player.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @winner.
  ///
  /// In en, this message translates to:
  /// **'Winner'**
  String get winner;

  /// No description provided for @draw.
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get draw;

  /// No description provided for @players.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// No description provided for @rounds.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get rounds;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @operation.
  ///
  /// In en, this message translates to:
  /// **'Operation'**
  String get operation;

  /// No description provided for @mixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get mixed;

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get startGame;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @solvedIn.
  ///
  /// In en, this message translates to:
  /// **'Solved in'**
  String get solvedIn;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @noHintsUsed.
  ///
  /// In en, this message translates to:
  /// **'No hints used'**
  String get noHintsUsed;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @dailyStreak.
  ///
  /// In en, this message translates to:
  /// **'Daily Streak'**
  String get dailyStreak;

  /// No description provided for @giveUp.
  ///
  /// In en, this message translates to:
  /// **'Give Up'**
  String get giveUp;

  /// No description provided for @rematch.
  ///
  /// In en, this message translates to:
  /// **'Rematch'**
  String get rematch;

  /// No description provided for @achievementUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Achievement Unlocked!'**
  String get achievementUnlocked;

  /// No description provided for @noHintsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No hints left for this puzzle'**
  String get noHintsAvailable;

  /// No description provided for @overallProgress.
  ///
  /// In en, this message translates to:
  /// **'Overall Progress'**
  String get overallProgress;

  /// No description provided for @roundNumber.
  ///
  /// In en, this message translates to:
  /// **'Round {number}'**
  String roundNumber(int number);

  /// No description provided for @dayStreak.
  ///
  /// In en, this message translates to:
  /// **'{count} Day Streak!'**
  String dayStreak(int count);

  /// No description provided for @shareResult.
  ///
  /// In en, this message translates to:
  /// **'Share Result'**
  String get shareResult;

  /// No description provided for @dailyComplete.
  ///
  /// In en, this message translates to:
  /// **'Daily Complete!'**
  String get dailyComplete;

  /// No description provided for @completeMoreLevels.
  ///
  /// In en, this message translates to:
  /// **'Complete more levels to replay'**
  String get completeMoreLevels;

  /// No description provided for @viewSolution.
  ///
  /// In en, this message translates to:
  /// **'View Solution'**
  String get viewSolution;

  /// No description provided for @attempts.
  ///
  /// In en, this message translates to:
  /// **'Attempts'**
  String get attempts;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @game.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @hapticFeedback.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get hapticFeedback;

  /// No description provided for @dailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminder'**
  String get dailyReminder;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// No description provided for @noAds.
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get noAds;

  /// No description provided for @allThemes.
  ///
  /// In en, this message translates to:
  /// **'All Themes'**
  String get allThemes;

  /// No description provided for @bonusHint.
  ///
  /// In en, this message translates to:
  /// **'+1 Bonus Hint'**
  String get bonusHint;

  /// No description provided for @goPro.
  ///
  /// In en, this message translates to:
  /// **'Go Pro'**
  String get goPro;

  /// No description provided for @proActive.
  ///
  /// In en, this message translates to:
  /// **'CryptiQ Pro ✓'**
  String get proActive;

  /// No description provided for @byDifficulty.
  ///
  /// In en, this message translates to:
  /// **'By Difficulty'**
  String get byDifficulty;

  /// No description provided for @totalStars.
  ///
  /// In en, this message translates to:
  /// **'Total Stars'**
  String get totalStars;

  /// No description provided for @avgTime.
  ///
  /// In en, this message translates to:
  /// **'Avg. Time'**
  String get avgTime;

  /// No description provided for @enjoyingApp.
  ///
  /// In en, this message translates to:
  /// **'Enjoying CryptiQ?'**
  String get enjoyingApp;

  /// No description provided for @rateAppBody.
  ///
  /// In en, this message translates to:
  /// **'If you like the app, please take a moment to rate it!'**
  String get rateAppBody;

  /// No description provided for @noThanks.
  ///
  /// In en, this message translates to:
  /// **'No Thanks'**
  String get noThanks;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @rateNow.
  ///
  /// In en, this message translates to:
  /// **'Rate Now ⭐'**
  String get rateNow;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @dataCollection.
  ///
  /// In en, this message translates to:
  /// **'Data Collection'**
  String get dataCollection;

  /// No description provided for @thirdPartyServices.
  ///
  /// In en, this message translates to:
  /// **'Third-Party Services'**
  String get thirdPartyServices;

  /// No description provided for @dataStorage.
  ///
  /// In en, this message translates to:
  /// **'Data Storage'**
  String get dataStorage;

  /// No description provided for @childrenPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Children\'s Privacy'**
  String get childrenPrivacy;

  /// No description provided for @changes.
  ///
  /// In en, this message translates to:
  /// **'Changes'**
  String get changes;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// No description provided for @levelsOf.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} levels completed'**
  String levelsOf(int completed, int total);

  /// No description provided for @tutorialWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to CryptiQ!'**
  String get tutorialWelcomeTitle;

  /// No description provided for @tutorialWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Each letter represents a unique digit (0-9).\nYour goal: find which digit each letter stands for\nso the equation is correct.'**
  String get tutorialWelcomeBody;

  /// No description provided for @tutorialSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Step 1: Select a Letter'**
  String get tutorialSelectTitle;

  /// No description provided for @tutorialSelectBody.
  ///
  /// In en, this message translates to:
  /// **'Tap on any letter tile in the equation.\nIt will highlight, showing it\'s selected.'**
  String get tutorialSelectBody;

  /// No description provided for @tutorialAssignTitle.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Assign a Digit'**
  String get tutorialAssignTitle;

  /// No description provided for @tutorialAssignBody.
  ///
  /// In en, this message translates to:
  /// **'Use the number pad to assign a digit (0-9)\nto the selected letter.\nEach digit can only be used once!'**
  String get tutorialAssignBody;

  /// No description provided for @tutorialCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Step 3: Check Your Answer'**
  String get tutorialCheckTitle;

  /// No description provided for @tutorialCheckBody.
  ///
  /// In en, this message translates to:
  /// **'Once all letters have digits, tap \"Check\".\nWrong letters turn red — fix them!\nUse Hints or Undo if you get stuck.'**
  String get tutorialCheckBody;

  /// No description provided for @tutorialGoTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re Ready!'**
  String get tutorialGoTitle;

  /// No description provided for @tutorialGoBody.
  ///
  /// In en, this message translates to:
  /// **'Solve fast with fewer hints for ⭐⭐⭐!\nGood luck and have fun! 🧩'**
  String get tutorialGoBody;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @autoFillNext.
  ///
  /// In en, this message translates to:
  /// **'Auto-select Next Letter'**
  String get autoFillNext;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'ja',
    'ko',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
