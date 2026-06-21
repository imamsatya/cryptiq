import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Number pad (0-9) for assigning digits to letters
class NumberPad extends StatelessWidget {
  final Set<int> usedDigits;
  final Function(int) onDigitTap;
  final Function(int)? onDigitLongPress;
  final VoidCallback? onClearTap;
  final bool enabled;

  const NumberPad({
    super.key,
    required this.usedDigits,
    required this.onDigitTap,
    this.onClearTap,
    this.onDigitLongPress,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Clear button
          if (onClearTap != null)
            GestureDetector(
              onTap: enabled ? onClearTap : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 34,
                height: 46,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  color: enabled
                      ? AppTheme.surfaceLight.withValues(alpha: 0.5)
                      : AppTheme.surfaceColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: enabled
                        ? Colors.redAccent.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.05),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.backspace_outlined,
                    size: 18,
                    color: enabled ? Colors.redAccent.withValues(alpha: 0.8) : AppTheme.textMuted,
                  ),
                ),
              ),
            ),
          ...List.generate(10, (index) {
            final isUsed = usedDigits.contains(index);

            return GestureDetector(
              onTap: enabled ? () => onDigitTap(index) : null,
              onLongPress: onDigitLongPress != null ? () => onDigitLongPress!(index) : null,
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
        ],
      ),
    ));
  }
}
