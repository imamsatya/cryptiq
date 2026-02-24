import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/puzzle.dart';

/// Displays the cryptarithm equation visually.
/// Handles single-step AND multi-step (cascading) puzzles.
class PuzzleDisplay extends StatelessWidget {
  final CryptarithmPuzzle puzzle;
  final Map<String, int?> assignments;
  final Set<String> wrongLetters;
  final Set<String> correctLetters;
  final Set<String> hintedLetters;
  final String? selectedLetter;
  final Function(String) onLetterTap;

  const PuzzleDisplay({
    super.key,
    required this.puzzle,
    required this.assignments,
    required this.wrongLetters,
    required this.correctLetters,
    required this.hintedLetters,
    required this.selectedLetter,
    required this.onLetterTap,
  });

  @override
  Widget build(BuildContext context) {
    if (puzzle.isMultiStep) {
      return _buildMultiStep();
    }
    return _buildSingleStep();
  }

  // ================================================================
  // SINGLE-STEP (existing layout)
  // ================================================================

  Widget _buildSingleStep() {
    final maxLen = [
      ...puzzle.operands.map((o) => o.length),
      puzzle.result.length,
    ].reduce((a, b) => a > b ? a : b);

    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: AppTheme.glassDecoration(borderRadius: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < puzzle.operands.length; i++) ...[
                _buildOperandRow(puzzle.operands[i], maxLen, puzzle.operator,
                    showOperator: i == puzzle.operands.length - 1),
                if (i < puzzle.operands.length - 1) const SizedBox(height: 8),
              ],
              const SizedBox(height: 4),
              _buildDivider(maxLen),
              const SizedBox(height: 8),
              _buildWordRow(puzzle.result, maxLen),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // MULTI-STEP (cascading layout)
  // ================================================================

  Widget _buildMultiStep() {
    // Find max word length across all steps
    int maxLen = 0;
    for (final step in puzzle.steps) {
      for (final op in step.operands) {
        if (op.length > maxLen) maxLen = op.length;
      }
      if (step.result.length > maxLen) maxLen = step.result.length;
    }

    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: AppTheme.glassDecoration(borderRadius: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int s = 0; s < puzzle.steps.length; s++) ...[
                // For step 0: show ALL operands
                // For step 1+: skip first operand (it's the previous result, already shown)
                if (s == 0)
                  for (int i = 0; i < puzzle.steps[s].operands.length; i++) ...[
                    _buildOperandRow(
                      puzzle.steps[s].operands[i],
                      maxLen,
                      puzzle.steps[s].operator,
                      showOperator: i == puzzle.steps[s].operands.length - 1,
                    ),
                    if (i < puzzle.steps[s].operands.length - 1)
                      const SizedBox(height: 6),
                  ]
                else
                  // Show remaining operands (skip index 0 = previous result)
                  for (int i = 1; i < puzzle.steps[s].operands.length; i++) ...[
                    _buildOperandRow(
                      puzzle.steps[s].operands[i],
                      maxLen,
                      puzzle.steps[s].operator,
                      showOperator: true,
                    ),
                  ],
                const SizedBox(height: 4),
                _buildDivider(maxLen),
                const SizedBox(height: 6),
                // Result
                _buildWordRow(puzzle.steps[s].result, maxLen),
                // Spacing between steps (except after last)
                if (s < puzzle.steps.length - 1) const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // SHARED WIDGETS
  // ================================================================

  Widget _buildDivider(int maxLen) {
    return Container(
      height: 3,
      width: maxLen * 52.0 + 40,
      decoration: BoxDecoration(
        gradient: AppTheme.goldGradient,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildOperandRow(String word, int maxLen, String operator,
      {bool showOperator = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          child: showOperator
              ? Text(
                  operator,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                )
              : null,
        ),
        ...List.generate(maxLen - word.length, (_) => const SizedBox(width: 52)),
        ...word.split('').map((ch) => _buildCell(ch)),
      ],
    );
  }

  Widget _buildWordRow(String word, int maxLen) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 40),
        ...List.generate(maxLen - word.length, (_) => const SizedBox(width: 52)),
        ...word.split('').map((ch) => _buildCell(ch)),
      ],
    );
  }

  Widget _buildCell(String ch) {
    if (!isLetterChar(ch)) {
      return _buildGivenDigitCell(ch);
    }
    return _buildLetterCell(ch);
  }

  Widget _buildGivenDigitCell(String digitChar) {
    return Container(
      width: 48,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          digitChar,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor.withValues(alpha: 0.85),
          ),
        ),
      ),
    );
  }

  Widget _buildLetterCell(String letter) {
    final digit = assignments[letter];
    final isSelected = selectedLetter == letter;
    final isWrong = wrongLetters.contains(letter);
    final isCorrect = correctLetters.contains(letter);
    final isHinted = hintedLetters.contains(letter);
    final hasDigit = digit != null;

    Color bgColor;
    Color textColor;
    Color borderColor;

    if (isSelected) {
      bgColor = AppTheme.primaryColor.withValues(alpha: 0.2);
      textColor = AppTheme.primaryColor;
      borderColor = AppTheme.primaryColor;
    } else if (isWrong) {
      bgColor = AppTheme.errorColor.withValues(alpha: 0.15);
      textColor = AppTheme.errorColor;
      borderColor = AppTheme.errorColor;
    } else if (isCorrect || isHinted) {
      bgColor = AppTheme.successColor.withValues(alpha: 0.15);
      textColor = AppTheme.successColor;
      borderColor = AppTheme.successColor;
    } else if (hasDigit) {
      bgColor = AppTheme.surfaceLight;
      textColor = Colors.white;
      borderColor = AppTheme.primaryColor.withValues(alpha: 0.3);
    } else {
      bgColor = AppTheme.surfaceColor.withValues(alpha: 0.4);
      textColor = AppTheme.textSecondary;
      borderColor = Colors.white.withValues(alpha: 0.1);
    }

    return GestureDetector(
      onTap: () => onLetterTap(letter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
          boxShadow: isSelected
              ? [BoxShadow(color: AppTheme.primaryColor.withValues(alpha: 0.25), blurRadius: 10)]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter,
              style: TextStyle(
                fontSize: hasDigit ? 10 : 22,
                fontWeight: FontWeight.w600,
                color: hasDigit ? textColor.withValues(alpha: 0.6) : textColor,
              ),
            ),
            if (hasDigit)
              Text(
                '$digit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
