import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/audio_service.dart';
import '../../data/datasources/local_database.dart';
import '../providers/game_state_provider.dart';
import '../widgets/puzzle_display.dart';
import '../widgets/letter_tile.dart';
import '../widgets/number_pad.dart';

class GameScreen extends ConsumerStatefulWidget {
  final int levelNumber;
  const GameScreen({super.key, required this.levelNumber});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen>
    with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).chain(
      CurveTween(curve: Curves.elasticIn),
    ).animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider(widget.levelNumber));
    final hintBalance = LocalDatabase.instance.getHintBalance();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(gameState, hintBalance),
              const SizedBox(height: 8),

              // Puzzle display
              Expanded(
                flex: 4,
                child: AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_shakeAnimation.value * ((_shakeController.isAnimating && _shakeController.value > 0.5) ? -1 : 1), 0),
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PuzzleDisplay(
                      puzzle: gameState.puzzle,
                      assignments: gameState.assignments,
                      wrongLetters: gameState.wrongLetters,
                      correctLetters: gameState.correctLetters,
                      hintedLetters: gameState.hintedLetters,
                      selectedLetter: gameState.selectedLetter,
                      onLetterTap: (letter) {
                        ref.read(gameStateProvider(widget.levelNumber).notifier).selectLetter(letter);
                        AudioService.instance.playTap();
                        HapticFeedback.lightImpact();
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Letter tiles
              _buildLetterTiles(gameState),

              const SizedBox(height: 12),

              // Number pad
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NumberPad(
                  usedDigits: gameState.usedDigits,
                  onDigitTap: (digit) {
                    ref.read(gameStateProvider(widget.levelNumber).notifier).assignDigit(digit);
                    AudioService.instance.playTap();
                    HapticFeedback.selectionClick();
                  },
                  enabled: gameState.selectedLetter != null && !gameState.isComplete,
                ),
              ),

              const SizedBox(height: 12),

              // Action buttons
              _buildActionButtons(gameState, hintBalance),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(GameState gameState, int hintBalance) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () { if (context.canPop()) { context.pop(); } else { context.go('/'); } },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: AppTheme.glassDecoration(borderRadius: 12),
              child: const Icon(Icons.arrow_back_rounded,
                  color: Colors.white, size: 22),
            ),
          ),

          const Spacer(),

          // Level number
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: AppTheme.glassDecoration(borderRadius: 12),
            child: Text(
              'Level ${widget.levelNumber}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          const Spacer(),

          // Timer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: AppTheme.glassDecoration(borderRadius: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer_outlined,
                    color: AppTheme.primaryColor, size: 16),
                const SizedBox(width: 4),
                Text(
                  _formatTime(gameState.elapsedSeconds),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetterTiles(GameState gameState) {
    final letters = gameState.puzzle.allLetters;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: letters.map((letter) {
          final digit = gameState.assignments[letter];
          final isSelected = gameState.selectedLetter == letter;
          final isWrong = gameState.wrongLetters.contains(letter);
          final isCorrect = gameState.correctLetters.contains(letter);
          final isHinted = gameState.hintedLetters.contains(letter);

          return LetterTile(
            letter: letter,
            digit: digit,
            isSelected: isSelected,
            isWrong: isWrong,
            isCorrect: isCorrect,
            isHinted: isHinted,
            onTap: () {
              ref.read(gameStateProvider(widget.levelNumber).notifier).selectLetter(letter);
              AudioService.instance.playTap();
              HapticFeedback.lightImpact();
            },
            onLongPress: () {
              ref.read(gameStateProvider(widget.levelNumber).notifier).clearLetter(letter);
              HapticFeedback.mediumImpact();
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButtons(GameState gameState, int hintBalance) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Hint button
          Expanded(
            child: GestureDetector(
              onTap: gameState.isComplete
                  ? null
                  : () {
                      final notifier = ref.read(
                          gameStateProvider(widget.levelNumber).notifier);
                      final used = notifier.useHint();
                      if (used) {
                        AudioService.instance.playTap();
                        HapticFeedback.mediumImpact();
                        setState(() {}); // Update hint balance display
                      } else {
                        // No hints available - show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No hints available!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: AppTheme.glassDecoration(
                  borderRadius: 14,
                  borderColor: AppTheme.primaryColor.withValues(alpha: 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lightbulb_outline_rounded,
                        color: AppTheme.primaryColor, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Hint ($hintBalance)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Clear button
          GestureDetector(
            onTap: gameState.isComplete
                ? null
                : () {
                    ref
                        .read(gameStateProvider(widget.levelNumber).notifier)
                        .clearAll();
                    HapticFeedback.lightImpact();
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: AppTheme.glassDecoration(borderRadius: 14),
              child: const Icon(Icons.refresh_rounded,
                  color: AppTheme.textSecondary, size: 22),
            ),
          ),

          const SizedBox(width: 12),

          // Check button
          Expanded(
            child: GestureDetector(
              onTap: gameState.isComplete
                  ? null
                  : () async {
                      final notifier = ref.read(
                          gameStateProvider(widget.levelNumber).notifier);
                      final navigator = GoRouter.of(context);
                      final currentTime = gameState.elapsedSeconds;
                      final currentHints = gameState.hintsUsed;
                      final currentStars = gameState.calculateStars();
                      final correct = await notifier.checkSolution();
                      if (correct) {
                        AudioService.instance.playCorrect();
                        HapticFeedback.heavyImpact();
                        navigator.push('/result/${widget.levelNumber}', extra: {
                          'time': currentTime,
                          'hints': currentHints,
                          'stars': currentStars,
                        });
                      } else {
                        AudioService.instance.playError();
                        HapticFeedback.heavyImpact();
                        _shakeController.forward(from: 0);
                      }
                    },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: AppTheme.goldGlowDecoration(borderRadius: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_rounded,
                        color: AppTheme.backgroundDark, size: 22),
                    const SizedBox(width: 6),
                    Text(
                      l10n.check,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.backgroundDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
