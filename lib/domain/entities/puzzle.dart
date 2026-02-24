import 'package:equatable/equatable.dart';

enum DifficultyLevel { easy, medium, hard, expert }

/// Checks if a character is an uppercase letter (unknown)
bool isLetterChar(String ch) {
  final c = ch.codeUnitAt(0);
  return c >= 65 && c <= 90; // A-Z
}

/// A cryptarithm puzzle.
///
/// Operands and result can contain:
/// - **Letters** (A-Z): unknowns the player must solve
/// - **Digit chars** ('0'-'9'): already-known digits shown as given
///
/// Example: `A + A = 2` → player only needs to figure out A=1
/// Example: `AB + 22 = 63` → player figures out A=4, B=1
/// Example: `SEND + MORE = MONEY` → classic full cryptarithm
class CryptarithmPuzzle extends Equatable {
  final int id;
  final int levelNumber;
  final List<String> operands;     // e.g. ["SEND", "MORE"] or ["A", "3"]
  final String result;             // e.g. "MONEY" or "5"
  final String operator;           // "+", "-", "×"
  final Map<String, int> solution; // letter→digit for unknowns only
  final DifficultyLevel difficulty;
  final int uniqueLetters;         // number of unknown letters

  const CryptarithmPuzzle({
    required this.id,
    required this.levelNumber,
    required this.operands,
    required this.result,
    this.operator = '+',
    required this.solution,
    required this.difficulty,
    required this.uniqueLetters,
  });

  /// Get all unique LETTER characters (unknowns only, excludes digit chars)
  List<String> get allLetters {
    final Set<String> letters = {};
    for (final operand in operands) {
      for (final ch in operand.split('')) {
        if (isLetterChar(ch)) letters.add(ch);
      }
    }
    for (final ch in result.split('')) {
      if (isLetterChar(ch)) letters.add(ch);
    }
    return letters.toList()..sort();
  }

  /// Get the leading letters (cannot be 0) — only for multi-char words
  Set<String> get leadingLetters {
    final Set<String> leading = {};
    for (final operand in operands) {
      if (operand.length > 1 && isLetterChar(operand[0])) {
        leading.add(operand[0]);
      }
    }
    if (result.length > 1 && isLetterChar(result[0])) {
      leading.add(result[0]);
    }
    return leading;
  }

  /// Convert a word (mixed letters+digits) to a number using an assignment
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

  /// Verify if a given assignment is a correct solution.
  /// Checks: unique digits, no leading zeros, arithmetic correctness.
  bool verifySolution(Map<String, int> assignment) {
    final letters = allLetters;
    if (assignment.length != letters.length) return false;

    // Check unique digits (each letter maps to a different digit)
    final usedDigits = assignment.values.toSet();
    if (usedDigits.length != assignment.length) return false;

    // Check leading letters are not 0
    for (final letter in leadingLetters) {
      if (assignment[letter] == 0) return false;
    }

    // Verify the arithmetic
    final operandValues = operands.map((op) => wordToNum(op, assignment)).toList();
    final resultValue = wordToNum(result, assignment);

    switch (operator) {
      case '+':
        return operandValues.reduce((a, b) => a + b) == resultValue;
      case '-':
        return operandValues.first - operandValues.skip(1).reduce((a, b) => a + b) == resultValue;
      case '×':
        return operandValues.reduce((a, b) => a * b) == resultValue;
      default:
        return operandValues.reduce((a, b) => a + b) == resultValue;
    }
  }

  /// Check if a partial assignment is still valid (no contradictions)
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
  List<Object?> get props => [id, levelNumber, operands, result, operator, solution];
}
