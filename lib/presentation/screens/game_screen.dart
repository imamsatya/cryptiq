import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/ad_service.dart';
import '../providers/game_state_provider.dart';
import '../widgets/puzzle_display.dart';
import '../widgets/letter_tile.dart';
import '../widgets/number_pad.dart';
import '../widgets/tutorial_overlay.dart';
import '../../data/datasources/local_database.dart';

class GameScreen extends ConsumerStatefulWidget {
  final int levelNumber;
  final bool viewOnly;
  const GameScreen({super.key, required this.levelNumber, this.viewOnly = false});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).chain(
      CurveTween(curve: Curves.elasticIn),
    ).animate(_shakeController);

    // Show tutorial on level 1 first play
    if (widget.levelNumber == 1 && !TutorialOverlay.hasSeenTutorial()) {
      _showTutorial = true;
    }
  }

  bool _showTutorial = false;

  @override
  void dispose() {
    _shakeController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      ref.read(gameStateProvider(widget.levelNumber).notifier).pauseTimer();
    } else if (state == AppLifecycleState.resumed) {
      ref.read(gameStateProvider(widget.levelNumber).notifier).resumeTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider(widget.levelNumber));

    // View-only mode: show completed solution
    if (widget.viewOnly) {
      return _buildViewOnlyScreen(gameState);
    }

    return Stack(
      children: [
        Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(gameState),
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
              _buildActionButtons(gameState),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
        if (_showTutorial)
          TutorialOverlay(
            onComplete: () => setState(() => _showTutorial = false),
          ),
      ],
    );
  }

  Widget _buildHeader(GameState gameState) {
    final l10n = AppLocalizations.of(context)!;
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

          // Level number + difficulty
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: AppTheme.glassDecoration(borderRadius: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.level(widget.levelNumber),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getDiffColor().withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _getDiffLabel(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getDiffColor(),
                    ),
                  ),
                ),
              ],
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

  Widget _buildActionButtons(GameState gameState) {
    final l10n = AppLocalizations.of(context)!;
    final hintsRemaining = gameState.hintsRemaining;
    final maxHints = gameState.maxHints;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Hint button
          Expanded(
            child: GestureDetector(
              onTap: gameState.isComplete
                  ? null
                  : () async {
                      final notifier = ref.read(
                          gameStateProvider(widget.levelNumber).notifier);
                      
                      if (gameState.canUseHint) {
                        // Use available free hint
                        final used = notifier.useHint();
                        if (used) {
                          AudioService.instance.playTap();
                          HapticFeedback.mediumImpact();
                        }
                      } else if (gameState.nextHintNeedsAd) {
                        // Last hint — watch ad first
                        final adService = AdService.instance;
                        if (adService.isRewardedReady) {
                          final rewarded = await adService.showRewarded();
                          if (rewarded && mounted) {
                            notifier.unlockLastHint();
                            AudioService.instance.playTap();
                            HapticFeedback.mediumImpact();
                          }
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.noHintsAvailable),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.noHintsAvailable),
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
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          gameState.nextHintNeedsAd
                              ? Icons.play_circle_outline_rounded
                              : Icons.lightbulb_outline_rounded,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          gameState.nextHintNeedsAd
                              ? '🎬 ${l10n.hint} (1)'
                              : LocalDatabase.instance.getProStatus()
                                  ? '${l10n.hint} (∞)'
                                  : '${l10n.hint} ($hintsRemaining/$maxHints)',
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
            ),
          ),

          const SizedBox(width: 8),

          // Clear (Eraser) button
          GestureDetector(
            onTap: (gameState.isComplete || gameState.selectedLetter == null)
                ? null
                : () {
                    final selected = gameState.selectedLetter;
                    if (selected != null) {
                      ref.read(gameStateProvider(widget.levelNumber).notifier).clearLetter(selected);
                      AudioService.instance.playTap();
                      HapticFeedback.lightImpact();
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              decoration: AppTheme.glassDecoration(borderRadius: 14),
              child: Icon(Icons.backspace_outlined,
                  color: (gameState.isComplete || gameState.selectedLetter == null)
                      ? AppTheme.textSecondary.withValues(alpha: 0.3)
                      : Colors.redAccent.withValues(alpha: 0.8), 
                  size: 22),
            ),
          ),

          const SizedBox(width: 8),

          // Undo button
          GestureDetector(
            onTap: gameState.isComplete
                ? null
                : () {
                    final notifier = ref.read(
                        gameStateProvider(widget.levelNumber).notifier);
                    if (notifier.canUndo) {
                      notifier.undo();
                      HapticFeedback.lightImpact();
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              decoration: AppTheme.glassDecoration(borderRadius: 14),
              child: Icon(Icons.undo_rounded,
                  color: ref.read(gameStateProvider(widget.levelNumber).notifier).canUndo
                      ? AppTheme.textSecondary
                      : AppTheme.textSecondary.withValues(alpha: 0.3),
                  size: 22),
            ),
          ),

          const SizedBox(width: 8),

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
                      final unassignedCount = gameState.assignments.values.where((v) => v == null).length;
                      if (unassignedCount > 0) {
                        _showTopError(l10n.fillAllLetters);
                        HapticFeedback.lightImpact();
                        return;
                      }

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
                        
                        _showTopError(l10n.incorrectTryAgain);
                      }
                    },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: AppTheme.goldGlowDecoration(borderRadius: 14),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
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

  /// Read-only view of a completed puzzle showing the solution
  Color _getDiffColor() {
    final n = widget.levelNumber;
    if (n <= 250) return AppTheme.easyColor;
    if (n <= 500) return AppTheme.mediumColor;
    if (n <= 750) return AppTheme.hardColor;
    return AppTheme.expertColor;
  }

  String _getDiffLabel() {
    final l10n = AppLocalizations.of(context)!;
    final n = widget.levelNumber;
    if (n <= 250) return l10n.easy.toUpperCase();
    if (n <= 500) return l10n.medium.toUpperCase();
    if (n <= 750) return l10n.hard.toUpperCase();
    return l10n.expert.toUpperCase();
  }

  Widget _buildViewOnlyScreen(GameState gameState) {
    final l10n = AppLocalizations.of(context)!;
    final puzzle = gameState.puzzle;
    final solution = puzzle.solution;

    // Build fully-filled assignments from the solution
    final filledAssignments = <String, int?>{
      for (final entry in solution.entries) entry.key: entry.value,
    };

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: AppTheme.glassDecoration(borderRadius: 12),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: AppTheme.glassDecoration(borderRadius: 12),
                      child: Text(
                        l10n.level(widget.levelNumber),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Solved badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppTheme.successColor.withValues(alpha: 0.2),
                        border: Border.all(
                          color: AppTheme.successColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded,
                              color: AppTheme.successColor, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            l10n.correct,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // View Solution label
              Text(
                l10n.viewSolution,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary.withValues(alpha: 0.7),
                ),
              ),

              const SizedBox(height: 16),

              // Puzzle display with solution filled in
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PuzzleDisplay(
                    puzzle: puzzle,
                    assignments: filledAssignments,
                    wrongLetters: const {},
                    correctLetters: solution.keys.toSet(),
                    hintedLetters: const {},
                    selectedLetter: null,
                    onLetterTap: (_) {}, // Disabled
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Letter assignments summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: AppTheme.glassDecoration(borderRadius: 16),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: solution.entries.map((e) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.key,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          Text(
                            ' = ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                          Text(
                            '${e.value}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
  void _showTopError(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          ],
        ),
        backgroundColor: AppTheme.errorColor.withValues(alpha: 0.95),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 140,
          left: 40,
          right: 40,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
