import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for pt (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([super.locale = 'pt']);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'Jogar';

  @override
  String get dailyChallenge => 'Desafio Diário';

  @override
  String get statistics => 'Estatísticas';

  @override
  String get settings => 'Configurações';

  @override
  String level(int number) {
    return 'Nível {number}';
  }

  @override
  String get easy => 'Fácil';

  @override
  String get medium => 'Médio';

  @override
  String get hard => 'Difícil';

  @override
  String get expert => 'Especialista';

  @override
  String get hint => 'Dica';

  @override
  String get check => 'Verificar';

  @override
  String get clear => 'Limpar';

  @override
  String get clearAll => 'Limpar Tudo';

  @override
  String get congratulations => 'Parabéns!';

  @override
  String get puzzleSolved => 'Puzzle Resolvido!';

  @override
  String get nextLevel => 'Próximo Nível';

  @override
  String get replay => 'Repetir';

  @override
  String get share => 'Compartilhar';

  @override
  String get time => 'Tempo';

  @override
  String get hints => 'Dicas';

  @override
  String get bestTime => 'Melhor Tempo';

  @override
  String get levelsCompleted => 'Níveis Concluídos';

  @override
  String get totalTime => 'Tempo Total';

  @override
  String get averageTime => 'Tempo Médio';

  @override
  String get hintsUsed => 'Dicas Usadas';

  @override
  String get currentStreak => 'Sequência Atual';

  @override
  String get bestStreak => 'Melhor Sequência';

  @override
  String get sound => 'Som';

  @override
  String get haptics => 'Vibração';

  @override
  String get language => 'Idioma';

  @override
  String get about => 'Sobre';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get rateApp => 'Avaliar App';

  @override
  String get removeAds => 'Remover Anúncios';

  @override
  String get restorePurchase => 'Restaurar Compra';

  @override
  String get tryAgain => 'Tentar Novamente';

  @override
  String get wrongAnswer => 'Resposta Errada';

  @override
  String get someDigitsWrong => 'Alguns dígitos estão incorretos. Tente novamente!';

  @override
  String get allLevelsFree => 'Todos os níveis são GRÁTIS!';

  @override
  String get noLockedLevels => 'Sem níveis bloqueados, nunca.';

  @override
  String get home => 'Início';

  @override
  String get back => 'Voltar';

  @override
  String get resume => 'Continuar';

  @override
  String stars(int count) {
    return '{count} Estrelas';
  }

}
