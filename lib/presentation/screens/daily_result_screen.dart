import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/daily_challenge_service.dart';

class DailyResultScreen extends StatefulWidget {
  final int timeSeconds;
  final int hintsUsed;

  const DailyResultScreen({
    super.key,
    required this.timeSeconds,
    required this.hintsUsed,
  });

  @override
  State<DailyResultScreen> createState() => _DailyResultScreenState();
}

class _DailyResultScreenState extends State<DailyResultScreen>
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

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final streak = DailyChallengeService.instance.streak;
    final now = DateTime.now();
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final dateStr = '${now.day} ${months[now.month - 1]} ${now.year}';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Trophy
                        Container(
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
                          child: const Center(
                            child: Icon(Icons.emoji_events_rounded,
                                size: 52, color: AppTheme.backgroundDark),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Title
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppTheme.goldGradient.createShader(bounds),
                          child: const Text(
                            'Daily Complete!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),
                        Text(
                          dateStr,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary.withValues(alpha: 0.7),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Streak badge
                        if (streak > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.withValues(alpha: 0.2),
                                  Colors.red.withValues(alpha: 0.1),
                                ],
                              ),
                              border: Border.all(
                                color: Colors.orange.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('🔥',
                                    style: TextStyle(fontSize: 28)),
                                const SizedBox(width: 8),
                                Text(
                                  '$streak Day Streak!',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 24),

                        // Stats card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: AppTheme.glassDecoration(borderRadius: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatItem(
                                Icons.timer_rounded,
                                _formatTime(widget.timeSeconds),
                                'Time',
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                              _buildStatItem(
                                Icons.lightbulb_rounded,
                                '${widget.hintsUsed}',
                                'Hints',
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                              _buildStatItem(
                                Icons.local_fire_department_rounded,
                                '$streak',
                                'Streak',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Share button
                        GestureDetector(
                          onTap: () {
                            SharePlus.instance.share(
                              ShareParams(
                                text:
                                    'I solved today\'s CryptiQ Daily Challenge in '
                                    '${_formatTime(widget.timeSeconds)}! '
                                    '🔥 $streak day streak! Can you beat it?\n\n'
                                    '#CryptiQ #DailyChallenge',
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration:
                                AppTheme.goldGlowDecoration(borderRadius: 18),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.share_rounded,
                                    color: AppTheme.backgroundDark, size: 22),
                                SizedBox(width: 8),
                                Text(
                                  'Share Result',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.backgroundDark,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Home button
                        GestureDetector(
                          onTap: () {
                            context.go('/'); // Go home, clear stack
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: AppTheme.glassDecoration(
                              borderRadius: 18,
                              borderColor:
                                  AppTheme.primaryColor.withValues(alpha: 0.3),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.home_rounded,
                                    color: Colors.white, size: 22),
                                SizedBox(width: 8),
                                Text(
                                  'Home',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Confetti
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: 20,
                  minBlastForce: 5,
                  emissionFrequency: 0.06,
                  numberOfParticles: 15,
                  gravity: 0.15,
                  shouldLoop: false,
                  colors: const [
                    AppTheme.primaryColor,
                    AppTheme.accentColor,
                    Colors.orange,
                    Colors.red,
                    Colors.green,
                    Colors.blue,
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
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
