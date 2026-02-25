import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/daily_challenge_service.dart';
import '../../core/services/audio_service.dart';
import '../providers/daily_challenge_provider.dart';
import '../widgets/puzzle_display.dart';
import '../widgets/number_pad.dart';
import '../widgets/letter_tile.dart';

class DailyChallengeScreen extends ConsumerWidget {
  const DailyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(dailyGameStateProvider);
    final puzzle = gameState.puzzle;

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
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
                            color: Colors.white, size: 20),
                      ),
                    ),
                    const Spacer(),
                    // Title
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: AppTheme.glassDecoration(borderRadius: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.today_rounded,
                              color: AppTheme.primaryColor, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            l10n.dailyChallenge,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
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
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Puzzle display
              Expanded(
                flex: 5,
                child: Center(
                  child: PuzzleDisplay(
                    puzzle: puzzle,
                    assignments: gameState.assignments,
                    wrongLetters: gameState.wrongLetters,
                    correctLetters: gameState.correctLetters,
                    hintedLetters: gameState.hintedLetters,
                    selectedLetter: gameState.selectedLetter,
                    onLetterTap: (letter) {
                      ref.read(dailyGameStateProvider.notifier).selectLetter(letter);
                    },
                  ),
                ),
              ),



              // Letter assignments + number pad (hide when complete)
              if (!gameState.isComplete) ...[
                // Letter tiles
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    alignment: WrapAlignment.center,
                    children: puzzle.allLetters.map((letter) {
                      return LetterTile(
                        letter: letter,
                        digit: gameState.assignments[letter],
                        isSelected: gameState.selectedLetter == letter,
                        isWrong: gameState.wrongLetters.contains(letter),
                        isCorrect: gameState.correctLetters.contains(letter),
                        isHinted: gameState.hintedLetters.contains(letter),
                        onTap: () {
                          ref.read(dailyGameStateProvider.notifier).selectLetter(letter);
                          HapticFeedback.selectionClick();
                        },
                        onLongPress: () {
                          ref.read(dailyGameStateProvider.notifier).clearLetter(letter);
                          HapticFeedback.mediumImpact();
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),

                // Number pad
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: NumberPad(
                    usedDigits: gameState.usedDigits,
                    onDigitTap: (digit) {
                      ref.read(dailyGameStateProvider.notifier).assignDigit(digit);
                      AudioService.instance.playTap();
                      HapticFeedback.selectionClick();
                    },
                    enabled: gameState.selectedLetter != null && !gameState.isComplete,
                  ),
                ),
                const SizedBox(height: 12),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // Hint button
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            ref.read(dailyGameStateProvider.notifier).useHint();
                            HapticFeedback.mediumImpact();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            decoration: AppTheme.glassDecoration(borderRadius: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lightbulb_outline,
                                    color: AppTheme.primaryColor, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  'Hint (${gameState.hintsUsed})',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Clear button
                      GestureDetector(
                        onTap: () {
                          ref.read(dailyGameStateProvider.notifier).clearAll();
                          HapticFeedback.lightImpact();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: AppTheme.glassDecoration(borderRadius: 14),
                          child: const Icon(Icons.refresh_rounded,
                              color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Check button
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () async {
                            final notifier =
                                ref.read(dailyGameStateProvider.notifier);
                            final navigator = GoRouter.of(context);
                            final currentTime = ref.read(dailyGameStateProvider).elapsedSeconds;
                            final currentHints = ref.read(dailyGameStateProvider).hintsUsed;
                            final correct = await notifier.checkSolution();
                            if (correct) {
                              AudioService.instance.playCorrect();
                              HapticFeedback.heavyImpact();
                              await DailyChallengeService.instance.completeDaily(currentTime);
                              navigator.push('/daily-result', extra: {
                                'time': currentTime,
                                'hints': currentHints,
                              });
                            } else {
                              AudioService.instance.playError();
                              HapticFeedback.heavyImpact();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: AppTheme.goldGlowDecoration(borderRadius: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_rounded,
                                    color: AppTheme.backgroundDark, size: 20),
                                SizedBox(width: 6),
                                Text(
                                  l10n.check,
                                  style: TextStyle(
                                    color: AppTheme.backgroundDark,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // (removed _buildCompletionCard — now uses full-screen DailyResultScreen)

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
