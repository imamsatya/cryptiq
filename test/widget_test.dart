import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/levels/puzzle_generator.dart';
import 'package:cryptiq/domain/entities/puzzle.dart';

void main() {
  test('PuzzleGenerator generates 500 puzzles', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    expect(puzzles.length, 500);
  });

  test('All puzzles have valid solutions', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    for (final puzzle in puzzles) {
      int wordToNum(String word) {
        int val = 0;
        for (final ch in word.split('')) {
          if (isLetterChar(ch)) {
            val = val * 10 + puzzle.solution[ch]!;
          } else {
            val = val * 10 + int.parse(ch);
          }
        }
        return val;
      }

      final operandValues = puzzle.operands.map(wordToNum).toList();
      final resultValue = wordToNum(puzzle.result);
      final sum = operandValues.reduce((a, b) => a + b);

      expect(sum, resultValue,
          reason: 'Level ${puzzle.levelNumber}: ${puzzle.operands.join(" + ")} = ${puzzle.result} '
              '(${operandValues.join(" + ")} should equal $resultValue but got $sum)');
    }
  });

  test('No leading zeros in solutions', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    for (final puzzle in puzzles) {
      for (final letter in puzzle.leadingLetters) {
        expect(puzzle.solution[letter], isNot(0),
            reason: 'Level ${puzzle.levelNumber}: Leading letter $letter should not be 0');
      }
    }
  });

  test('Early levels have few unknowns (gradual difficulty)', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    // Level 1 should have only 1 unknown letter
    expect(puzzles[0].allLetters.length, lessThanOrEqualTo(2));
    // Level 10 should still be easy
    expect(puzzles[9].allLetters.length, lessThanOrEqualTo(2));
  });

  test('Level 1 is a simple 1-letter puzzle', () {
    final p = PuzzleGenerator.getPuzzle(1);
    print('Level 1: ${p.operands.join(" + ")} = ${p.result} '
        '(${p.uniqueLetters} letters, solution: ${p.solution})');
    expect(p.allLetters.length, lessThanOrEqualTo(2));
  });
}
