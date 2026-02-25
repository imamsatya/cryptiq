import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import '../../core/theme/app_theme.dart';
import 'multiplayer_game_screen.dart';

/// Multiplayer result leaderboard
class MultiplayerResultScreen extends StatefulWidget {
  final List<String> playerNames;
  final List<List<PlayerRound?>> results;
  final int totalRounds;

  const MultiplayerResultScreen({
    super.key,
    required this.playerNames,
    required this.results,
    required this.totalRounds,
  });

  @override
  State<MultiplayerResultScreen> createState() =>
      _MultiplayerResultScreenState();
}

class _MultiplayerResultScreenState extends State<MultiplayerResultScreen>
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

  List<_PlayerTotal> _calculateTotals() {
    final totals = <_PlayerTotal>[];
    for (int p = 0; p < widget.playerNames.length; p++) {
      int totalScore = 0;
      int totalTime = 0;
      int totalHints = 0;
      int solved = 0;
      for (int r = 0; r < widget.totalRounds; r++) {
        final pr = widget.results[r][p];
        if (pr != null) {
          totalScore += pr.score;
          totalTime += pr.timeSeconds;
          totalHints += pr.hintsUsed;
          if (pr.solved) solved++;
        }
      }
      totals.add(_PlayerTotal(
        name: widget.playerNames[p],
        index: p,
        totalScore: totalScore,
        totalTime: totalTime,
        totalHints: totalHints,
        roundsSolved: solved,
      ));
    }
    totals.sort((a, b) => b.totalScore.compareTo(a.totalScore));
    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateTotals();
    final winner = totals.first;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Confetti
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 20,
                numberOfParticles: 25,
                gravity: 0.1,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.secondaryColor,
                  Color(0xFFFF6B6B),
                  Color(0xFF4ECDC4),
                  Colors.white,
                ],
              ),

              Column(
                children: [
                  const SizedBox(height: 16),

                  // Title
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      children: [
                        const Text('🏆',
                            style: TextStyle(fontSize: 48)),
                        SizedBox(height: 8),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppTheme.goldGradient.createShader(bounds),
                          child: Text(
                            '${winner.name} Wins!',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Leaderboard
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        // Rankings
                        ...List.generate(totals.length, (i) {
                          final p = totals[i];
                          return _buildRankRow(i + 1, p);
                        }),

                        SizedBox(height: 20),

                        // Round-by-round
                        Text(
                          'Round Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor.withValues(alpha: 0.8),
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...List.generate(widget.totalRounds, (r) {
                          return _buildRoundCard(r);
                        }),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => context.go('/'),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              decoration:
                                  AppTheme.glassDecoration(borderRadius: 14),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.home_rounded,
                                      color: Colors.white, size: 20),
                                  SizedBox(width: 6),
                                  Text('Home',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => context.go('/multiplayer'),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              decoration: AppTheme.goldGlowDecoration(
                                  borderRadius: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.replay_rounded,
                                      color: AppTheme.backgroundDark,
                                      size: 20),
                                  SizedBox(width: 6),
                                  Text('Rematch',
                                      style: TextStyle(
                                        color: AppTheme.backgroundDark,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankRow(int rank, _PlayerTotal p) {
    final color = _playerColor(p.index);
    final isFirst = rank == 1;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isFirst
            ? AppTheme.primaryColor.withValues(alpha: 0.1)
            : AppTheme.surfaceColor.withValues(alpha: 0.4),
        border: Border.all(
          color: isFirst
              ? AppTheme.primaryColor.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFirst
                  ? AppTheme.primaryColor
                  : AppTheme.surfaceColor,
            ),
            child: Center(
              child: Text(
                rank == 1
                    ? '🥇'
                    : rank == 2
                        ? '🥈'
                        : rank == 3
                            ? '🥉'
                            : '$rank',
                style: TextStyle(
                  fontSize: rank <= 3 ? 18 : 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  '${p.roundsSolved}/${widget.totalRounds} solved • ${_formatTime(p.totalTime)} • ${p.totalHints} hints',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),

          // Score
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.goldGradient.createShader(bounds),
            child: Text(
              '${p.totalScore}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundCard(int round) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: AppTheme.glassDecoration(borderRadius: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Round ${round + 1}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary)),
          const SizedBox(height: 6),
          ...List.generate(widget.playerNames.length, (p) {
            final pr = widget.results[round][p];
            final color = _playerColor(p);
            if (pr == null) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: color),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.playerNames[p],
                      style: TextStyle(fontSize: 12, color: color),
                    ),
                  ),
                  Text(
                    pr.solved
                        ? '${_formatTime(pr.timeSeconds)} • ${pr.hintsUsed}h'
                        : 'Gave up',
                    style: TextStyle(
                      fontSize: 12,
                      color: pr.solved ? Colors.white : AppTheme.textMuted,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${pr.score}pts',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  static Color _playerColor(int index) {
    const colors = [
      Color(0xFF4CAF50),
      Color(0xFF2196F3),
      Color(0xFFFF9800),
      Color(0xFFE91E63),
    ];
    return colors[index % colors.length];
  }
}

class _PlayerTotal {
  final String name;
  final int index;
  final int totalScore;
  final int totalTime;
  final int totalHints;
  final int roundsSolved;

  _PlayerTotal({
    required this.name,
    required this.index,
    required this.totalScore,
    required this.totalTime,
    required this.totalHints,
    required this.roundsSolved,
  });
}
