import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/levels/puzzle_generator.dart';
import 'package:cryptiq/domain/entities/puzzle.dart';

void main() {
  test('PuzzleGenerator generates 1200 puzzles', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    expect(puzzles.length, 1200);
  });

  test('All puzzles have valid solutions', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    for (final puzzle in puzzles) {
      expect(puzzle.verifySolution(puzzle.solution), true,
          reason: 'Level ${puzzle.levelNumber} (${puzzle.operator}): '
              'solution verification failed');
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
    expect(p.isMultiStep, false);
  });

  test('Mixed operations appear in later levels', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    final ops = puzzles.map((p) => p.operator).toSet();
    expect(ops.contains('+'), true);
    expect(ops.contains('-'), true);
    expect(ops.contains('×'), true);
  });

  test('Multi-step puzzles exist in levels 1001-1200', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    final multiStep = puzzles.where((p) => p.isMultiStep).toList();
    expect(multiStep.length, 200);
    expect(multiStep.first.levelNumber, greaterThanOrEqualTo(1001));
  });

  test('Multi-step puzzle solutions verify across all steps', () {
    final puzzles = PuzzleGenerator.allPuzzles.where((p) => p.isMultiStep);
    for (final puzzle in puzzles) {
      expect(puzzle.steps.length, greaterThanOrEqualTo(2),
          reason: 'Level ${puzzle.levelNumber}: multi-step should have 2+ steps');
      expect(puzzle.verifySolution(puzzle.solution), true,
          reason: 'Level ${puzzle.levelNumber}: multi-step verification failed');
    }
  });

  test('Difficulty distribution', () {
    final puzzles = PuzzleGenerator.allPuzzles;
    final easy = puzzles.where((p) => p.difficulty == DifficultyLevel.easy).length;
    final medium = puzzles.where((p) => p.difficulty == DifficultyLevel.medium).length;
    final hard = puzzles.where((p) => p.difficulty == DifficultyLevel.hard).length;
    final expert = puzzles.where((p) => p.difficulty == DifficultyLevel.expert).length;
    expect(easy, 250);
    expect(medium, 250);
    expect(hard, 250);
    expect(expert, 450); // 250 single + 200 multi-step
  });
}
