import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/datasources/local_database.dart';
import '../../l10n/app_localizations.dart';

/// Step-by-step interactive tutorial overlay for level 1.
/// Shows on first play only. Guides user through:
///   1. Understanding the puzzle format
///   2. Selecting a letter
///   3. Assigning a digit
///   4. Checking the solution
class TutorialOverlay extends StatefulWidget {
  final VoidCallback onComplete;
  const TutorialOverlay({super.key, required this.onComplete});

  static const _seenKey = 'tutorial_seen';

  static bool hasSeenTutorial() {
    return LocalDatabase.instance.settingsBox
        .get(_seenKey, defaultValue: false);
  }

  static Future<void> markSeen() async {
    await LocalDatabase.instance.settingsBox.put(_seenKey, true);
  }

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay>
    with SingleTickerProviderStateMixin {
  int _step = 0;
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  static const _steps = [
    _TutorialStep(
      icon: Icons.help_outline_rounded,
      titleKey: 'tutorialWelcomeTitle',
      bodyKey: 'tutorialWelcomeBody',
      titleFallback: 'Welcome to CryptiQ!',
      bodyFallback:
          'Each letter represents a unique digit (0-9).\n'
          'Your goal: find which digit each letter stands for\n'
          'so the equation is correct.',
    ),
    _TutorialStep(
      icon: Icons.touch_app_rounded,
      titleKey: 'tutorialSelectTitle',
      bodyKey: 'tutorialSelectBody',
      titleFallback: 'Step 1: Select a Letter',
      bodyFallback:
          'Tap on any letter tile in the equation.\n'
          'It will highlight, showing it\'s selected.',
    ),
    _TutorialStep(
      icon: Icons.dialpad_rounded,
      titleKey: 'tutorialAssignTitle',
      bodyKey: 'tutorialAssignBody',
      titleFallback: 'Step 2: Assign a Digit',
      bodyFallback:
          'Use the number pad to assign a digit (0-9)\n'
          'to the selected letter.\n'
          'Each digit can only be used once!',
    ),
    _TutorialStep(
      icon: Icons.check_circle_outline_rounded,
      titleKey: 'tutorialCheckTitle',
      bodyKey: 'tutorialCheckBody',
      titleFallback: 'Step 3: Check Your Answer',
      bodyFallback:
          'Once all letters have digits, tap "Check".\n'
          'Wrong letters turn red — fix them!\n'
          'Use Hints or Undo if you get stuck.',
    ),
    _TutorialStep(
      icon: Icons.star_rounded,
      titleKey: 'tutorialGoTitle',
      bodyKey: 'tutorialGoBody',
      titleFallback: 'You\'re Ready!',
      bodyFallback:
          'Solve fast with fewer hints for ⭐⭐⭐!\n'
          'Good luck and have fun! 🧩',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_step < _steps.length - 1) {
      _animCtrl.reverse().then((_) {
        setState(() => _step++);
        _animCtrl.forward();
      });
    } else {
      TutorialOverlay.markSeen();
      widget.onComplete();
    }
  }

  void _skip() {
    TutorialOverlay.markSeen();
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_step];
    final l10n = AppLocalizations.of(context)!;
    final isLast = _step == _steps.length - 1;

    return GestureDetector(
      onTap: _nextStep,
      child: Container(
        color: Colors.black.withValues(alpha: 0.75),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(_fadeAnim),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.surfaceColor.withValues(alpha: 0.95),
                      AppTheme.surfaceColor.withValues(alpha: 0.85),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Step indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _steps.length,
                        (i) => Container(
                          width: i == _step ? 24 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: i == _step
                                ? AppTheme.primaryColor
                                : AppTheme.primaryColor.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primaryColor.withValues(alpha: 0.15),
                      ),
                      child: Icon(step.icon, color: AppTheme.primaryColor, size: 40),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      step.titleFallback,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Body
                    Text(
                      step.bodyFallback,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Buttons
                    Row(
                      children: [
                        if (!isLast) ...[
                          TextButton(
                            onPressed: _skip,
                            child: Text(
                              l10n.close,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.4),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                        Expanded(
                          flex: isLast ? 1 : 0,
                          child: ElevatedButton(
                            onPressed: _nextStep,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              isLast ? l10n.startGame : l10n.nextLevel,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TutorialStep {
  final IconData icon;
  final String titleKey;
  final String bodyKey;
  final String titleFallback;
  final String bodyFallback;

  const _TutorialStep({
    required this.icon,
    required this.titleKey,
    required this.bodyKey,
    required this.titleFallback,
    required this.bodyFallback,
  });
}
