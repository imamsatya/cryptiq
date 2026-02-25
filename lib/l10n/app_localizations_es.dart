import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for es (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([super.locale = 'es']);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'Jugar';

  @override
  String get dailyChallenge => 'Desafío Diario';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get settings => 'Ajustes';

  @override
  String level(int number) {
    return 'Nivel {number}';
  }

  @override
  String get easy => 'Fácil';

  @override
  String get medium => 'Medio';

  @override
  String get hard => 'Difícil';

  @override
  String get expert => 'Experto';

  @override
  String get hint => 'Pista';

  @override
  String get check => 'Verificar';

  @override
  String get clear => 'Borrar';

  @override
  String get clearAll => 'Borrar Todo';

  @override
  String get congratulations => '¡Felicidades!';

  @override
  String get puzzleSolved => '¡Puzzle Resuelto!';

  @override
  String get nextLevel => 'Siguiente Nivel';

  @override
  String get replay => 'Repetir';

  @override
  String get share => 'Compartir';

  @override
  String get time => 'Tiempo';

  @override
  String get hints => 'Pistas';

  @override
  String get bestTime => 'Mejor Tiempo';

  @override
  String get levelsCompleted => 'Niveles Completados';

  @override
  String get totalTime => 'Tiempo Total';

  @override
  String get averageTime => 'Tiempo Promedio';

  @override
  String get hintsUsed => 'Pistas Usadas';

  @override
  String get currentStreak => 'Racha Actual';

  @override
  String get bestStreak => 'Mejor Racha';

  @override
  String get sound => 'Sonido';

  @override
  String get haptics => 'Vibración';

  @override
  String get language => 'Idioma';

  @override
  String get about => 'Acerca de';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get rateApp => 'Calificar App';

  @override
  String get removeAds => 'Eliminar Anuncios';

  @override
  String get restorePurchase => 'Restaurar Compra';

  @override
  String get tryAgain => 'Intentar de Nuevo';

  @override
  String get wrongAnswer => 'Respuesta Incorrecta';

  @override
  String get someDigitsWrong => '¡Algunos dígitos son incorrectos. Intenta de nuevo!';

  @override
  String get allLevelsFree => '¡Todos los niveles son GRATIS!';

  @override
  String get noLockedLevels => 'Sin niveles bloqueados, nunca.';

  @override
  String get home => 'Inicio';

  @override
  String get back => 'Volver';

  @override
  String get resume => 'Continuar';

  @override
  String stars(int count) {
    return '{count} Estrellas';
  }

}
