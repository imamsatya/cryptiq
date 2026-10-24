import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/levels/puzzle_generator.dart';

void main() {
  group('failsOnlyOnLeadingZero', () {
    // Level 351: X × 4 = J4. X=6, J=2 (6 × 4 = 24) is the answer, but
    // X=1, J=0 also makes the arithmetic true (1 × 4 = 04).
    final puzzle = PuzzleGenerator.getPuzzle(351);

    test('level 351 is the expected puzzle', () {
      expect(puzzle.operands, ['X', '4']);
      expect(puzzle.operator, '×');
      expect(puzzle.result, 'J4');
    });

    test('flags an answer that is only wrong because of a leading zero', () {
      const answer = {'X': 1, 'J': 0};
      expect(puzzle.verifySolution(answer), isFalse);
      expect(puzzle.failsOnlyOnLeadingZero(answer), isTrue);
    });

    test('does not flag the real solution or a plainly wrong answer', () {
      expect(puzzle.failsOnlyOnLeadingZero(puzzle.solution), isFalse);
      expect(puzzle.failsOnlyOnLeadingZero(const {'X': 3, 'J': 0}), isFalse);
      expect(puzzle.failsOnlyOnLeadingZero(const {'X': 1}), isFalse,
          reason: 'incomplete answers are never flagged');
    });
  });

  test('no stored solution is flagged as a leading-zero answer', () {
    for (final p in PuzzleGenerator.allPuzzles) {
      expect(p.failsOnlyOnLeadingZero(p.solution), isFalse,
          reason: 'level ${p.levelNumber}');
    }
  });

  test('a wrong digit set with a missing letter returns false, not a crash', () {
    final p = PuzzleGenerator.getPuzzle(351);
    expect(p.verifySolution(const {'X': 6, 'Q': 2}), isFalse);
  });
}
