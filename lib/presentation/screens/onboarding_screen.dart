import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/datasources/local_database.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  static const _onboardingKey = 'onboarding_seen';

  /// Check if onboarding has been seen
  static bool hasSeenOnboarding() {
    return LocalDatabase.instance.settingsBox
        .get(_onboardingKey, defaultValue: false);
  }

  /// Mark onboarding as complete
  static Future<void> markComplete() async {
    await LocalDatabase.instance.settingsBox.put(_onboardingKey, true);
  }

  /// Reset onboarding (for replay from settings)
  static Future<void> reset() async {
    await LocalDatabase.instance.settingsBox.put(_onboardingKey, false);
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  final _pages = const <_TutorialPage>[
    _TutorialPage(
      emoji: '🧩',
      title: 'Welcome to CryptiQ!',
      subtitle: 'Decode the Logic',
      body:
          'CryptiQ is a cryptarithm puzzle game where each letter represents a unique digit (0-9).\n\n'
          'Your goal: figure out which digit goes with which letter to make the equation true!',
      example: 'S E N D\n+ M O R E\n─────────\nM O N E Y',
    ),
    _TutorialPage(
      emoji: '👆',
      title: 'How to Play',
      subtitle: 'Select & Assign',
      body:
          '1. Tap a letter tile to select it\n'
          '2. Tap a number (0-9) to assign it\n'
          '3. Each letter must have a unique digit\n'
          '4. Long-press a letter to clear it',
      example: 'If S=9, E=5, N=6, D=7\nthen SEND = 9567',
    ),
    _TutorialPage(
      emoji: '💡',
      title: 'Need Help?',
      subtitle: 'Hints & Checking',
      body:
          '• Tap 💡 Hint to reveal one correct letter\n'
          '• Tap ✓ Check to verify your solution\n'
          '• Wrong letters glow red, correct ones glow green\n'
          '• Try to solve with fewer hints for more ⭐ stars!',
      example: '⭐⭐⭐  No hints, fast solve\n⭐⭐     1-2 hints\n⭐       3+ hints',
    ),
    _TutorialPage(
      emoji: '🔥',
      title: 'Daily Challenge',
      subtitle: 'Come Back Every Day!',
      body:
          '• A new puzzle appears every day\n'
          '• Build your streak 🔥 by playing daily\n'
          '• Unlock achievements as you play\n'
          '• 1200 levels from Easy to Expert — all FREE!',
      example: 'Ready? Let\'s go! 🚀',
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _complete();
    }
  }

  void _skip() => _complete();

  Future<void> _complete() async {
    await OnboardingScreen.markComplete();
    widget.onComplete();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: _skip,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: AppTheme.glassDecoration(borderRadius: 20),
                      child: Text(
                        _currentPage < _pages.length - 1 ? 'Skip' : '',
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              AppTheme.textSecondary.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Pages
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return _buildPage(page);
                  },
                ),
              ),

              // Dots + Button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  children: [
                    // Page dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: i == _currentPage ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: i == _currentPage
                                ? AppTheme.primaryColor
                                : AppTheme.surfaceColor,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),

                    // Next / Start button
                    GestureDetector(
                      onTap: _next,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: _currentPage == _pages.length - 1
                            ? AppTheme.goldGlowDecoration(borderRadius: 18)
                            : AppTheme.glassDecoration(
                                borderRadius: 18,
                                borderColor: AppTheme.primaryColor
                                    .withValues(alpha: 0.4),
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentPage == _pages.length - 1
                                  ? 'Start Playing'
                                  : 'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _currentPage == _pages.length - 1
                                    ? AppTheme.backgroundDark
                                    : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              _currentPage == _pages.length - 1
                                  ? Icons.play_arrow_rounded
                                  : Icons.arrow_forward_rounded,
                              color: _currentPage == _pages.length - 1
                                  ? AppTheme.backgroundDark
                                  : Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(_TutorialPage page) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Emoji
          Text(page.emoji, style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 16),

          // Title
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.goldGradient.createShader(bounds),
            child: Text(
              page.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            page.subtitle,
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary.withValues(alpha: 0.7),
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 24),

          // Body text
          Text(
            page.body,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.6,
            ),
            textAlign: TextAlign.left,
          ),

          const SizedBox(height: 20),

          // Example card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.glassDecoration(borderRadius: 14),
            child: Text(
              page.example,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.primaryColor,
                fontFamily: 'monospace',
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _TutorialPage {
  final String emoji;
  final String title;
  final String subtitle;
  final String body;
  final String example;

  const _TutorialPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.example,
  });
}
