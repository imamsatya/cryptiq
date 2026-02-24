import 'package:equatable/equatable.dart';

enum DifficultyLevel { easy, medium, hard, expert }

/// Checks if a character is an uppercase letter (unknown)
bool isLetterChar(String ch) {
  final c = ch.codeUnitAt(0);
  return c >= 65 && c <= 90; // A-Z
}

/// One step in a multi-step puzzle.
class PuzzleStep {
  final List<String> operands;
  final String result;
  final String operator;

  const PuzzleStep({
    required this.operands,
    required this.result,
    this.operator = '+',
  });
}

/// A cryptarithm puzzle — single-step or multi-step.
///
/// Operands and result can contain:
/// - **Letters** (A-Z): unknowns the player must solve
/// - **Digit chars** ('0'-'9'): already-known digits shown as given
///
/// Single-step: `SEND + MORE = MONEY`
/// Multi-step:  `AA + BB = CCC`, then `CCC + SS = XXX`
class CryptarithmPuzzle extends Equatable {
  final int id;
  final int levelNumber;
  final List<String> operands;     // first-step operands (or single-step)
  final String result;             // final result
  final String operator;           // "+", "-", "×"
  final Map<String, int> solution; // letter→digit for unknowns
  final DifficultyLevel difficulty;
  final int uniqueLetters;
  final List<PuzzleStep> steps;    // empty = single-step

  const CryptarithmPuzzle({
    required this.id,
    required this.levelNumber,
    required this.operands,
    required this.result,
    this.operator = '+',
    required this.solution,
    required this.difficulty,
    required this.uniqueLetters,
    this.steps = const [],
  });

  bool get isMultiStep => steps.isNotEmpty;

  /// Get all unique LETTER characters across all steps
  List<String> get allLetters {
    final Set<String> letters = {};
    if (isMultiStep) {
      for (final step in steps) {
        for (final op in step.operands) {
          for (final ch in op.split('')) {
            if (isLetterChar(ch)) letters.add(ch);
          }
        }
        for (final ch in step.result.split('')) {
          if (isLetterChar(ch)) letters.add(ch);
        }
      }
    } else {
      for (final operand in operands) {
        for (final ch in operand.split('')) {
          if (isLetterChar(ch)) letters.add(ch);
        }
      }
      for (final ch in result.split('')) {
        if (isLetterChar(ch)) letters.add(ch);
      }
    }
    return letters.toList()..sort();
  }

  /// Get the leading letters (cannot be 0) — only for multi-char words
  Set<String> get leadingLetters {
    final Set<String> leading = {};
    if (isMultiStep) {
      for (final step in steps) {
        for (final op in step.operands) {
          if (op.length > 1 && isLetterChar(op[0])) leading.add(op[0]);
        }
        if (step.result.length > 1 && isLetterChar(step.result[0])) {
          leading.add(step.result[0]);
        }
      }
    } else {
      for (final operand in operands) {
        if (operand.length > 1 && isLetterChar(operand[0])) {
          leading.add(operand[0]);
        }
      }
      if (result.length > 1 && isLetterChar(result[0])) {
        leading.add(result[0]);
      }
    }
    return leading;
  }

  /// Convert a word (mixed letters+digits) to a number
  static int wordToNum(String word, Map<String, int> assignment) {
    int val = 0;
    for (final ch in word.split('')) {
      if (isLetterChar(ch)) {
        val = val * 10 + assignment[ch]!;
      } else {
        val = val * 10 + int.parse(ch);
      }
    }
    return val;
  }

  /// Verify if a given assignment is correct for ALL steps.
  bool verifySolution(Map<String, int> assignment) {
    final letters = allLetters;
    if (assignment.length != letters.length) return false;

    final usedDigits = assignment.values.toSet();
    if (usedDigits.length != assignment.length) return false;

    for (final letter in leadingLetters) {
      if (assignment[letter] == 0) return false;
    }

    if (isMultiStep) {
      for (final step in steps) {
        if (!_verifyStep(step, assignment)) return false;
      }
      return true;
    } else {
      return _verifySingle(assignment);
    }
  }

  bool _verifySingle(Map<String, int> assignment) {
    final operandValues = operands.map((op) => wordToNum(op, assignment)).toList();
    final resultValue = wordToNum(result, assignment);
    return switch (operator) {
      '+' => operandValues.reduce((a, b) => a + b) == resultValue,
      '-' => operandValues.first - operandValues.skip(1).reduce((a, b) => a + b) == resultValue,
      '×' => operandValues.reduce((a, b) => a * b) == resultValue,
      _ => operandValues.reduce((a, b) => a + b) == resultValue,
    };
  }

  static bool _verifyStep(PuzzleStep step, Map<String, int> assignment) {
    final opVals = step.operands.map((op) => wordToNum(op, assignment)).toList();
    final resVal = wordToNum(step.result, assignment);
    return switch (step.operator) {
      '+' => opVals.reduce((a, b) => a + b) == resVal,
      '-' => opVals.first - opVals.skip(1).reduce((a, b) => a + b) == resVal,
      '×' => opVals.reduce((a, b) => a * b) == resVal,
      _ => opVals.reduce((a, b) => a + b) == resVal,
    };
  }

  /// Check if a partial assignment is still valid
  bool isPartiallyValid(Map<String, int> assignment) {
    final usedDigits = assignment.values.toSet();
    if (usedDigits.length != assignment.length) return false;

    for (final letter in leadingLetters) {
      if (assignment.containsKey(letter) && assignment[letter] == 0) {
        return false;
      }
    }
    return true;
  }

  @override
  List<Object?> get props => [id, levelNumber, operands, result, operator, solution, steps];
}
