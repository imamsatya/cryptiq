import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Individual letter tile showing the letter and its assigned digit.
/// Animates with scale+glow when hint is applied.
class LetterTile extends StatefulWidget {
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
  State<LetterTile> createState() => _LetterTileState();
}

class _LetterTileState extends State<LetterTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _hintAnimCtrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;
  bool _prevHinted = false;

  @override
  void initState() {
    super.initState();
    _hintAnimCtrl = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 1.0), weight: 60),
    ]).animate(CurvedAnimation(parent: _hintAnimCtrl, curve: Curves.easeOutBack));
    _glowAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _hintAnimCtrl, curve: Curves.easeOut),
    );
    _prevHinted = widget.isHinted;
  }

  @override
  void didUpdateWidget(LetterTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger animation when hint is applied (isHinted goes false→true)
    if (widget.isHinted && !_prevHinted) {
      _hintAnimCtrl.forward(from: 0);
    }
    _prevHinted = widget.isHinted;
  }

  @override
  void dispose() {
    _hintAnimCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;

    if (widget.isSelected) {
      bgColor = AppTheme.primaryColor.withValues(alpha: 0.15);
      textColor = AppTheme.primaryColor;
      borderColor = AppTheme.primaryColor;
    } else if (widget.isWrong) {
      bgColor = AppTheme.errorColor.withValues(alpha: 0.12);
      textColor = AppTheme.errorColor;
      borderColor = AppTheme.errorColor.withValues(alpha: 0.5);
    } else if (widget.isCorrect || widget.isHinted) {
      bgColor = AppTheme.successColor.withValues(alpha: 0.12);
      textColor = AppTheme.successColor;
      borderColor = AppTheme.successColor.withValues(alpha: 0.5);
    } else if (widget.digit != null) {
      bgColor = AppTheme.surfaceLight;
      textColor = Colors.white;
      borderColor = Colors.white.withValues(alpha: 0.15);
    } else {
      bgColor = AppTheme.surfaceColor.withValues(alpha: 0.5);
      textColor = AppTheme.textSecondary;
      borderColor = Colors.white.withValues(alpha: 0.08);
    }

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: _hintAnimCtrl,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnim.value,
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
                  width: widget.isSelected ? 2.5 : 1.5,
                ),
                boxShadow: [
                  if (widget.isSelected)
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  // Hint glow animation
                  if (_glowAnim.value > 0 && widget.isHinted)
                    BoxShadow(
                      color: AppTheme.successColor.withValues(
                          alpha: 0.5 * (1 - _glowAnim.value)),
                      blurRadius: 20 * _glowAnim.value,
                      spreadRadius: 4 * _glowAnim.value,
                    ),
                ],
              ),
              child: child,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.letter,
              style: TextStyle(
                fontSize: widget.digit != null ? 11 : 18,
                fontWeight: FontWeight.w600,
                color: widget.digit != null
                    ? textColor.withValues(alpha: 0.5)
                    : textColor,
              ),
            ),
            if (widget.digit != null) ...[
              Text(
                '${widget.digit}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
            if (widget.isHinted)
              Icon(Icons.lock_rounded,
                  size: 10, color: textColor.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
