import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/levels/puzzle_generator.dart';
import 'package:cryptiq/domain/entities/puzzle.dart';

void main() {
  test('PuzzleGenerator generates 1000 puzzles', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    expect(puzzles.length, 1000);
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

      final opVals = puzzle.operands.map(wordToNum).toList();
      final resVal = wordToNum(puzzle.result);

      late final bool correct;
      switch (puzzle.operator) {
        case '+':
          correct = opVals.reduce((a, b) => a + b) == resVal;
        case '-':
          correct = opVals.first - opVals.skip(1).reduce((a, b) => a + b) == resVal;
        case '×':
          correct = opVals.reduce((a, b) => a * b) == resVal;
        default:
          correct = false;
      }

      expect(correct, true,
          reason: 'Level ${puzzle.levelNumber} (${puzzle.operator}): '
              '${puzzle.operands.join(" ${puzzle.operator} ")} = ${puzzle.result} '
              '(values: ${opVals.join(" ${puzzle.operator} ")} should equal $resVal)');
    }
  });

  test('No leading zeros in solutions', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    for (final puzzle in puzzles) {
      for (final letter in puzzle.leadingLetters) {
        expect(puzzle.solution[letter], isNot(0),
            reason: 'Level ${puzzle.levelNumber}: Leading $letter should not be 0');
      }
    }
  });

  test('Level 1 is a simple tutorial puzzle', () {
    final p = PuzzleGenerator.getPuzzle(1);
    expect(p.allLetters.length, lessThanOrEqualTo(2));
    expect(p.operator, '+');
  });

  test('Mixed operations appear in later levels', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    final ops = puzzles.map((p) => p.operator).toSet();
    expect(ops.contains('+'), true);
    expect(ops.contains('-'), true);
    expect(ops.contains('×'), true);
  });

  test('Difficulty distribution is correct', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    final easy = puzzles.where((p) => p.difficulty == DifficultyLevel.easy).length;
    final medium = puzzles.where((p) => p.difficulty == DifficultyLevel.medium).length;
    final hard = puzzles.where((p) => p.difficulty == DifficultyLevel.hard).length;
    final expert = puzzles.where((p) => p.difficulty == DifficultyLevel.expert).length;
    expect(easy, 250);
    expect(medium, 250);
    expect(hard, 250);
    expect(expert, 250);
  });
}
