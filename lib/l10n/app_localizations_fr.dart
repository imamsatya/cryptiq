import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for fr (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([super.locale = 'fr']);

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
    return 'Niveau {number}';
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
  String get levelsCompleted => 'Niveaux Terminés';

  @override
  String get totalTime => 'Temps Total';

  @override
  String get averageTime => 'Temps Moyen';

  @override
  String get hintsUsed => 'Indices Utilisés';

  @override
  String get currentStreak => 'Série Actuelle';

  @override
  String get bestStreak => 'Meilleure Série';

  @override
  String get sound => 'Son';

  @override
  String get haptics => 'Haptique';

  @override
  String get language => 'Langue';

  @override
  String get about => 'À Propos';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

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
  String get resume => 'Reprendre';

  @override
  String stars(int count) {
    return '{count} Étoiles';
  }

}
