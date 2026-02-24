import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_theme.dart';
import '../../levels/puzzle_generator.dart';
import '../providers/game_state_provider.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final int levelNumber;
  final int timeSeconds;
  final int hintsUsed;
  final int stars;

  const ResultScreen({
    super.key,
    required this.levelNumber,
    required this.timeSeconds,
    required this.hintsUsed,
    required this.stars,
  });

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );

    _confettiController.play();
    _animController.forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Confetti
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                maxBlastForce: 30,
                minBlastForce: 10,
                gravity: 0.2,
                colors: const [
                  AppTheme.primaryColor,
                  AppTheme.secondaryColor,
                  AppTheme.successColor,
                  Colors.white,
                ],
              ),

              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // Victory icon
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppTheme.goldGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withValues(alpha: 0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.emoji_events_rounded,
                          size: 50,
                          color: AppTheme.backgroundDark,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Congratulations text
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppTheme.goldGradient.createShader(bounds),
                      child: const Text(
                        'Puzzle Solved!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Level ${widget.levelNumber}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.textSecondary.withValues(alpha: 0.8),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Stars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        final isEarned = i < widget.stars;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            isEarned
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: i == 1 ? 56 : 44,
                            color: isEarned
                                ? AppTheme.primaryColor
                                : AppTheme.textMuted.withValues(alpha: 0.3),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 32),

                    // Stats
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppTheme.glassDecoration(borderRadius: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(
                              Icons.timer_outlined, _formatTime(widget.timeSeconds), 'Time'),
                          Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.1)),
                          _buildStatItem(
                              Icons.lightbulb_outline, '${widget.hintsUsed}', 'Hints'),
                          Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.1)),
                          _buildStatItem(
                              Icons.star_rounded, '${widget.stars}/3', 'Stars'),
                        ],
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Buttons
                    _buildNextLevelButton(context),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSecondaryButton(
                            icon: Icons.replay_rounded,
                            label: 'Replay',
                            onTap: () {
                              // Force-reset the provider state
                              ref.invalidate(gameStateProvider(widget.levelNumber));
                              context.pop(); // pop result
                              context.pop(); // pop completed game
                              context.push('/game/${widget.levelNumber}');
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSecondaryButton(
                            icon: Icons.share_rounded,
                            label: 'Share',
                            onTap: () {
                              SharePlus.instance.share(
                                ShareParams(
                                  text: 'I solved CryptiQ Level ${widget.levelNumber} with ${widget.stars}⭐ in ${_formatTime(widget.timeSeconds)}! Can you beat it?',
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSecondaryButton(
                            icon: Icons.home_rounded,
                            label: 'Home',
                            onTap: () => context.go('/'),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 22),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
                fontSize: 11, color: AppTheme.textSecondary.withValues(alpha: 0.7))),
      ],
    );
  }

  Widget _buildNextLevelButton(BuildContext context) {
    final nextLevel = widget.levelNumber + 1;
    final hasNext = nextLevel <= PuzzleGenerator.totalPuzzles;

    return GestureDetector(
      onTap: hasNext
          ? () {
              ref.invalidate(gameStateProvider(widget.levelNumber));
              context.pop(); // pop result
              context.pop(); // pop completed game
              context.push('/game/$nextLevel');
            }
          : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: hasNext
            ? AppTheme.goldGlowDecoration(borderRadius: 16)
            : BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppTheme.surfaceColor.withValues(alpha: 0.5),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hasNext ? 'Next Level' : 'All Done!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: hasNext ? AppTheme.backgroundDark : AppTheme.textMuted,
              ),
            ),
            if (hasNext) ...[
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded,
                  color: AppTheme.backgroundDark, size: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: AppTheme.glassDecoration(borderRadius: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppTheme.textSecondary, size: 20),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary.withValues(alpha: 0.8))),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
