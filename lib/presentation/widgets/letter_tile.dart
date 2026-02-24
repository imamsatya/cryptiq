import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Individual letter tile showing the letter and its assigned digit
class LetterTile extends StatelessWidget {
  final String letter;
  final int? digit;
  final bool isSelected;
  final bool isWrong;
  final bool isCorrect;
  final bool isHinted;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const LetterTile({
    super.key,
    required this.letter,
    this.digit,
    this.isSelected = false,
    this.isWrong = false,
    this.isCorrect = false,
    this.isHinted = false,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;

    if (isSelected) {
      bgColor = AppTheme.primaryColor.withValues(alpha: 0.15);
      textColor = AppTheme.primaryColor;
      borderColor = AppTheme.primaryColor;
    } else if (isWrong) {
      bgColor = AppTheme.errorColor.withValues(alpha: 0.12);
      textColor = AppTheme.errorColor;
      borderColor = AppTheme.errorColor.withValues(alpha: 0.5);
    } else if (isCorrect || isHinted) {
      bgColor = AppTheme.successColor.withValues(alpha: 0.12);
      textColor = AppTheme.successColor;
      borderColor = AppTheme.successColor.withValues(alpha: 0.5);
    } else if (digit != null) {
      bgColor = AppTheme.surfaceLight;
      textColor = Colors.white;
      borderColor = Colors.white.withValues(alpha: 0.15);
    } else {
      bgColor = AppTheme.surfaceColor.withValues(alpha: 0.5);
      textColor = AppTheme.textSecondary;
      borderColor = Colors.white.withValues(alpha: 0.08);
    }

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 56,
        height: 64,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter,
              style: TextStyle(
                fontSize: digit != null ? 11 : 18,
                fontWeight: FontWeight.w600,
                color: digit != null ? textColor.withValues(alpha: 0.5) : textColor,
              ),
            ),
            if (digit != null) ...[
              Text(
                '$digit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
            if (isHinted)
              Icon(Icons.lock_rounded, size: 10, color: textColor.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
