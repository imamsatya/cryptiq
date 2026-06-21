// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

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
    return 'Nível $number';
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
  String get allowHints => 'Allow Hints';

  @override
  String get bestTime => 'Melhor Tempo';

  @override
  String levelsCompleted(int count, int total) {
    return '$count/$total completos';
  }

  @override
  String get totalTime => 'Tempo Total';

  @override
  String get averageTime => 'Média';

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
  String get tryAgain => 'Tentar Novamente';

  @override
  String get wrongAnswer => 'Resposta Errada';

  @override
  String get someDigitsWrong =>
      'Alguns dígitos estão incorretos. Tente novamente!';

  @override
  String get fillAllLetters => 'Please fill all letters first!';

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
    return '$count Estrelas';
  }

  @override
  String get selectLevel => 'Escolher Nível';

  @override
  String get badges => 'Medalhas';

  @override
  String get passAndPlay => 'Passar e Jogar (2-4)';

  @override
  String get decodeTheLogic => 'Decifre a Lógica';

  @override
  String continueLevel(int number) {
    return 'Continuar (Nível $number)';
  }

  @override
  String get selectDifficulty => 'Escolher Dificuldade';

  @override
  String get all => 'Todos';

  @override
  String get completed => 'Completo';

  @override
  String get locked => 'Bloqueado';

  @override
  String get unlocked => 'Desbloqueado';

  @override
  String get theme => 'Tema';

  @override
  String get replayTutorial => 'Rever Tutorial';

  @override
  String get version => 'Versão';

  @override
  String get contactUs => 'Contate-nos';

  @override
  String get resetProgress => 'Reiniciar Progresso';

  @override
  String get correct => 'Correto!';

  @override
  String get incorrect => 'Incorreto';

  @override
  String get round => 'Rodada';

  @override
  String get player => 'Jogador';

  @override
  String get score => 'Pontuação';

  @override
  String get winner => 'Vencedor';

  @override
  String get draw => 'Empate';

  @override
  String get players => 'Jogadores';

  @override
  String get rounds => 'Rodadas';

  @override
  String get difficulty => 'Dificuldade';

  @override
  String get operation => 'Operação';

  @override
  String get mixed => 'Misto';

  @override
  String get startGame => 'Iniciar';

  @override
  String get achievements => 'Conquistas';

  @override
  String get streak => 'Sequência';

  @override
  String get solvedIn => 'Resolvido em';

  @override
  String get seconds => 'segundos';

  @override
  String get noHintsUsed => 'Sem dicas';

  @override
  String get playAgain => 'Jogar Novamente';

  @override
  String get results => 'Resultados';

  @override
  String get dailyStreak => 'Sequência Diária';

  @override
  String get giveUp => 'Desistir';

  @override
  String get rematch => 'Revanche';

  @override
  String get achievementUnlocked => 'Conquista Desbloqueada!';

  @override
  String get noHintsAvailable => 'Sem dicas para este puzzle';

  @override
  String get overallProgress => 'Progresso Geral';

  @override
  String roundNumber(int number) {
    return 'Rodada $number';
  }

  @override
  String dayStreak(int count) {
    return '$count Dias de Sequência!';
  }

  @override
  String get shareResult => 'Compartilhar Resultado';

  @override
  String get dailyComplete => 'Desafio Diário Completo!';

  @override
  String get completeMoreLevels => 'Complete mais níveis para repetir';

  @override
  String get viewSolution => 'Ver Solução';

  @override
  String get attempts => 'Tentativas';

  @override
  String get close => 'Fechar';

  @override
  String get game => 'Jogo';

  @override
  String get soundEffects => 'Efeitos Sonoros';

  @override
  String get hapticFeedback => 'Feedback Háptico';

  @override
  String get dailyReminder => 'Lembrete Diário';

  @override
  String get appearance => 'Aparência';

  @override
  String get upgradeToPro => 'Atualizar para Pro';

  @override
  String get noAds => 'Sem Anúncios';

  @override
  String get allThemes => 'Todos os Temas';

  @override
  String get bonusHint => '+1 Dica Bônus';

  @override
  String get goPro => 'Ser Pro';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => 'Por Dificuldade';

  @override
  String get totalStars => 'Estrelas Totais';

  @override
  String get avgTime => 'Tempo Médio';

  @override
  String get enjoyingApp => 'Gostando do CryptiQ?';

  @override
  String get rateAppBody =>
      'Se você gosta do app, reserve um momento para avaliá-lo!';

  @override
  String get levelSelectHint =>
      '💡 Tip: Tap to play, long-press a completed level for details.';

  @override
  String get noThanks => 'Não, Obrigado';

  @override
  String get later => 'Depois';

  @override
  String get rateNow => 'Avaliar Agora ⭐';

  @override
  String get undo => 'Desfazer';

  @override
  String get overview => 'Visão Geral';

  @override
  String get dataCollection => 'Coleta de Dados';

  @override
  String get thirdPartyServices => 'Serviços de Terceiros';

  @override
  String get dataStorage => 'Armazenamento de Dados';

  @override
  String get childrenPrivacy => 'Privacidade Infantil';

  @override
  String get changes => 'Alterações';

  @override
  String get contact => 'Contato';

  @override
  String get lastUpdated => 'Última Atualização';

  @override
  String levelsOf(int completed, int total) {
    return '$completed de $total níveis completos';
  }

  @override
  String get tutorialWelcomeTitle => 'Bem-vindo ao CryptiQ!';

  @override
  String get tutorialWelcomeBody =>
      'Cada letra representa um dígito único (0-9).\nSeu objetivo: descobrir qual dígito cada letra representa\npara que a equação esteja correta.';

  @override
  String get tutorialSelectTitle => 'Passo 1: Selecione uma Letra';

  @override
  String get tutorialSelectBody =>
      'Toque em qualquer letra na equação.\nEla será destacada, mostrando que está selecionada.';

  @override
  String get tutorialAssignTitle => 'Passo 2: Atribua um Dígito';

  @override
  String get tutorialAssignBody =>
      'Use o teclado numérico para atribuir um dígito (0-9)\nà letra selecionada.\nCada dígito só pode ser usado uma vez!';

  @override
  String get tutorialCheckTitle => 'Passo 3: Verifique sua Resposta';

  @override
  String get tutorialCheckBody =>
      'Quando todas as letras tiverem dígitos, toque \"Verificar\".\nLetras erradas ficam vermelhas — corrija-as!\nUse Dicas ou Desfazer se ficar preso.';

  @override
  String get tutorialGoTitle => 'Você está Pronto!';

  @override
  String get tutorialGoBody =>
      'Resolva rápido com menos dicas para ⭐⭐⭐!\nBoa sorte e divirta-se! 🧩';

  @override
  String get next => 'Próximo';

  @override
  String get autoFillNext => 'Selecionar Próxima Letra Automaticamente';

  @override
  String get onboardingWelcomeTitle => 'Bem-vindo ao CryptiQ!';

  @override
  String get onboardingWelcomeSubtitle => 'Decifre a Lógica';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ é um jogo de puzzles criptaritméticos onde cada letra representa um dígito único (0-9).\n\nSeu objetivo: descobrir qual dígito corresponde a cada letra para que a equação seja verdadeira!';

  @override
  String get onboardingHowToPlay => 'Como Jogar';

  @override
  String get onboardingSelectAssign => 'Selecionar e Atribuir';

  @override
  String get onboardingExample => 'Se S=9, E=5, N=6, D=7\nentão SEND = 9567';

  @override
  String get onboardingNeedHelp => 'Precisa de Ajuda?';

  @override
  String get onboardingDailyTitle => 'Desafio Diário';

  @override
  String get onboardingDailySubtitle => 'Volte Todo Dia!';

  @override
  String get onboardingReady => 'Pronto? Vamos lá! 🚀';

  @override
  String get skip => 'Pular';

  @override
  String get startPlaying => 'Começar a Jogar';

  @override
  String playerName(int number) {
    return 'Jogador $number';
  }

  @override
  String get addPlayer => 'Adicionar Jogador';

  @override
  String roundsLabel(int count) {
    return 'Rodadas: $count';
  }

  @override
  String get addition => 'Adição (+)';

  @override
  String get subtraction => 'Subtração (−)';

  @override
  String get multiply => 'Multiplicação (×)';

  @override
  String get multiStep => 'Multi-passo';

  @override
  String get passDevice => 'Passe o dispositivo para este jogador';

  @override
  String get roundDetails => 'Detalhes da Rodada';

  @override
  String get gaveUp => 'Desistiu';

  @override
  String get beatMyTime => 'Consegue superar meu tempo?';

  @override
  String get allLevelsFreeTitle => 'Todos os 1200 Níveis GRÁTIS';

  @override
  String get allLevelsFreeBody => 'Sem níveis bloqueados. Aproveite!';

  @override
  String get privacyOverviewBody =>
      'Respeitamos sua privacidade e estamos comprometidos em proteger suas informações pessoais.';

  @override
  String get privacyDataBody =>
      'Todo o progresso do jogo é armazenado localmente no seu dispositivo usando armazenamento offline (Hive). Não exigimos criação de conta ou login.';

  @override
  String get privacyStorageBody =>
      'Todos os dados (progresso, configurações, conquistas) são armazenados localmente. Desinstalar o app removerá todos os dados locais.';

  @override
  String get privacyChangesBody =>
      'Podemos atualizar esta política. O uso contínuo após mudanças constitui aceitação.';

  @override
  String privacyContactBody(String email) {
    return 'Para perguntas, email: $email';
  }

  @override
  String get multiStepLabel => 'Multi-passo';

  @override
  String get stars3 => 'Estrelas';

  @override
  String get onboardingHowToPlayBody =>
      '1. Toque em uma letra para selecioná-la\n2. Toque em um número (0-9) para atribuí-lo\n3. Cada letra deve ter um dígito único\n4. Pressione e segure uma letra para limpá-la';

  @override
  String get onboardingHelpSubtitle => 'Dicas e Verificação';

  @override
  String get onboardingHelpBody =>
      '• Toque 💡 Dica para revelar uma letra\n• Toque ✓ Verificar para conferir\n• Letras erradas ficam vermelhas, corretas ficam verdes\n• Resolva com menos dicas para mais ⭐!';

  @override
  String get onboardingDailyBody =>
      '• Um novo puzzle todo dia\n• Construa sua sequência 🔥 jogando diariamente\n• Desbloqueie conquistas enquanto joga\n• 1200 níveis de Fácil a Especialista — todos GRÁTIS!';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  Sem dicas, rápido\n⭐⭐     1-2 dicas\n⭐       3+ dicas';

  @override
  String usedBy(String letter) {
    return 'Usado por: $letter';
  }

  @override
  String get notUsed => 'Não usado';

  @override
  String get replayConfirmTitle => 'Repetir este nível?';

  @override
  String get replayConfirmBody =>
      'Você já tem ⭐⭐⭐ neste nível. Sua melhor pontuação será mantida.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get newBadge => 'NOVO';

  @override
  String get themePicker => 'Tema';

  @override
  String get proThemeHint => 'Desbloqueie mais temas com Pro';

  @override
  String get shareStats => 'Compartilhar Estatísticas';

  @override
  String get updateAvailable => 'Atualização Disponível';

  @override
  String get updateBody =>
      'Uma nova versão do CryptiQ está disponível. Atualize agora para a melhor experiência!';

  @override
  String get updateNow => 'Atualizar Agora';

  @override
  String get puzzlesSolved => 'Puzzles Resolvidos';

  @override
  String get allDone => 'Tudo Pronto!';

  @override
  String hintCount(int count) {
    return 'Dica ($count)';
  }

  @override
  String get incorrectTryAgain => 'Incorreto — tente novamente!';

  @override
  String playerScored(String player, int score) {
    return '$player marcou $score pts';
  }

  @override
  String hintsCount(int count) {
    return '$count dicas';
  }

  @override
  String roundOf(int current, int total) {
    return 'Rodada $current de $total';
  }

  @override
  String get imReady => 'Estou Pronto!';

  @override
  String playerWins(String player) {
    return '$player Vence!';
  }

  @override
  String playerStatsLine(int solved, int total, String time, int hints) {
    return '$solved/$total resolvidos • $time • $hints dicas';
  }

  @override
  String scorePts(int score) {
    return '${score}pts';
  }

  @override
  String get playerNameHint => 'Nome do jogador';

  @override
  String get multiStepNote =>
      'Puzzles multi-passo são apenas Difícil/Especialista. A dificuldade será ignorada.';

  @override
  String percentUnlocked(String percent) {
    return '$percent% desbloqueado';
  }

  @override
  String shareDailyText(String time, int streak) {
    return 'Resolvi o Desafio Diário do CryptiQ em $time! 🔥 $streak dias de sequência! Consegue superar?\n\n#CryptiQ #DesafioDiário';
  }

  @override
  String get achvNoHints10Title => 'Mente Aguçada';

  @override
  String get achvStreak30Title => 'Mestre de sequência';

  @override
  String get achvStreak14Desc => 'Sequência de desafios diários de 14 dias';

  @override
  String get achvPerfect50Desc => 'Obtenha 3 estrelas em 50 níveis';

  @override
  String get achvFiveHundredLevelsTitle => 'A meio caminho';

  @override
  String get achvExpertMasterTitle => 'Criptógrafo especialista';

  @override
  String get achvLightningDesc =>
      'Resolva um quebra-cabeça em menos de 10 segundos';

  @override
  String get achvFirstSolveDesc => 'Resolva seu primeiro quebra-cabeça';

  @override
  String get achvExpertMasterDesc => 'Complete todos os níveis de Especialista';

  @override
  String get achvPerfect50Title => 'Perfeito';

  @override
  String get achvHundredLevelsDesc => 'Complete 100 níveis';

  @override
  String get achvHundredStarsDesc => 'Ganhe 100 estrelas';

  @override
  String get achvHardMasterDesc => 'Complete todos os níveis difíceis';

  @override
  String get achvHundredStarsTitle => 'Caçador de Estrelas';

  @override
  String get achvStreak14Title => 'Campeão de duas semanas';

  @override
  String get achvPerfect10Desc => 'Obtenha 3 estrelas em 10 níveis';

  @override
  String get achvHundredLevelsTitle => 'Centurião';

  @override
  String get achvHardMasterTitle => 'Endurecido';

  @override
  String get achvLightningTitle => 'Rápido como um relâmpago';

  @override
  String get achvTenStarsDesc => 'Ganhe 10 estrelas';

  @override
  String get achvFirstSolveTitle => 'Primeiros passos';

  @override
  String get achvStreak7Desc => 'Sequência de desafios diários de 7 dias';

  @override
  String get achvPerfect10Title => 'Perfeccionista';

  @override
  String get achvMediumMasterDesc => 'Complete todos os níveis Médios';

  @override
  String get achvSpeedDemonDesc =>
      'Resolva um quebra-cabeça em menos de 15 segundos';

  @override
  String get achvTenStarsTitle => 'Colecionador de estrelas';

  @override
  String get achvFiftyLevelsDesc => 'Complete 50 níveis';

  @override
  String get achvStreak7Title => 'Semana Guerreiro';

  @override
  String get achvNoHints50Desc => 'Resolva 50 quebra-cabeças sem dicas';

  @override
  String get achvMediumMasterTitle => 'Médio Raro';

  @override
  String get achvSpeedDemonTitle => 'Demônio da Velocidade';

  @override
  String get achvThousandLevelsDesc => 'Complete 1000 níveis';

  @override
  String get achvFiftyLevelsTitle => 'Entusiasta de quebra-cabeças';

  @override
  String get achvNoHints50Title => 'Puro Gênio';

  @override
  String get achvThousandStarsDesc => 'Ganhe 1000 estrelas';

  @override
  String get achvThousandLevelsTitle => 'Grão-Mestre';

  @override
  String get achvStreak3Desc => 'Sequência de desafios diários de 3 dias';

  @override
  String get achvEasyMasterDesc => 'Complete todos os níveis fáceis';

  @override
  String get achvNoHints10Desc => 'Resolva 10 quebra-cabeças sem dicas';

  @override
  String get achvStreak100Title => 'Imparável';

  @override
  String get achvStreak3Title => 'Em um rolo';

  @override
  String get achvThousandStarsTitle => 'Constelação';

  @override
  String get achvTenLevelsTitle => 'Aquecendo-se';

  @override
  String get achvEasyMasterTitle => 'Fácil';

  @override
  String get achvTenLevelsDesc => 'Complete 10 níveis';

  @override
  String get achvStreak30Desc => 'Sequência de desafios diários de 30 dias';

  @override
  String get achvFiveHundredLevelsDesc => 'Complete 500 níveis';

  @override
  String get achvStreak100Desc => 'Sequência de desafios diários de 100 dias';

  @override
  String get achvMultiStepFirstTitle => 'Reação em cadeia';

  @override
  String get achvMultiStepFirstDesc =>
      'Resolva seu primeiro quebra-cabeça de várias etapas';

  @override
  String get achvMultiStepAllDesc =>
      'Complete todos os 200 quebra-cabeças de várias etapas';

  @override
  String get achvMultiStepAllTitle => 'Rei Cascata';
}
