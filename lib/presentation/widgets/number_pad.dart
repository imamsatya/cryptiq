import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Number pad (0-9) for assigning digits to letters
class NumberPad extends StatelessWidget {
  final Set<int> usedDigits;
  final Function(int) onDigitTap;
  final bool enabled;

  const NumberPad({
    super.key,
    required this.usedDigits,
    required this.onDigitTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(10, (index) {
          final isUsed = usedDigits.contains(index);

          return GestureDetector(
            onTap: enabled ? () => onDigitTap(index) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 34,
              height: 46,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isUsed
                    ? AppTheme.primaryColor.withValues(alpha: 0.15)
                    : (enabled
                        ? AppTheme.surfaceLight
                        : AppTheme.surfaceColor.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isUsed
                      ? AppTheme.primaryColor.withValues(alpha: 0.4)
                      : (enabled
                          ? Colors.white.withValues(alpha: 0.12)
                          : Colors.white.withValues(alpha: 0.05)),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isUsed
                        ? AppTheme.primaryColor.withValues(alpha: 0.5)
                        : (enabled
                            ? Colors.white
                            : AppTheme.textMuted),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
