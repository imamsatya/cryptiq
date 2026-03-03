import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
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

  List<_TutorialPage> _getPages(AppLocalizations l10n) => [
    _TutorialPage(
      emoji: '🧩',
      title: l10n.onboardingWelcomeTitle,
      subtitle: l10n.onboardingWelcomeSubtitle,
      body: l10n.onboardingWelcomeBody,
      example: 'S E N D\n+ M O R E\n─────────\nM O N E Y',
    ),
    _TutorialPage(
      emoji: '👆',
      title: l10n.onboardingHowToPlay,
      subtitle: l10n.onboardingSelectAssign,
      body: l10n.onboardingHowToPlayBody,
      example: l10n.onboardingExample,
    ),
    _TutorialPage(
      emoji: '💡',
      title: l10n.onboardingNeedHelp,
      subtitle: l10n.onboardingHelpSubtitle,
      body: l10n.onboardingHelpBody,
      example: l10n.onboardingStarExample,
    ),
    _TutorialPage(
      emoji: '🔥',
      title: l10n.onboardingDailyTitle,
      subtitle: l10n.onboardingDailySubtitle,
      body: l10n.onboardingDailyBody,
      example: l10n.onboardingReady,
    ),
  ];

  void _next() {
    if (_currentPage < 4 - 1) {
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
    final l10n = AppLocalizations.of(context)!;
    final pages = _getPages(l10n);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
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
                        _currentPage < pages.length - 1 ? l10n.skip : '',
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
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, index) {
                    final page = pages[index];
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
                      children: List.generate(pages.length, (i) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4),
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
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: _currentPage == pages.length - 1
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
                              _currentPage == pages.length - 1
                                  ? l10n.startPlaying
                                  : l10n.next,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _currentPage == pages.length - 1
                                    ? AppTheme.backgroundDark
                                    : Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              _currentPage == pages.length - 1
                                  ? Icons.play_arrow_rounded
                                  : Icons.arrow_forward_rounded,
                              color: _currentPage == pages.length - 1
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
          SizedBox(height: 16),

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
              style: TextStyle(
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
