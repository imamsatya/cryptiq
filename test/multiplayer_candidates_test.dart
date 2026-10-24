import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/domain/entities/puzzle.dart';
import 'package:cryptiq/levels/puzzle_generator.dart';

/// Lobby option keys (see MultiplayerLobbyScreen).
const difficulties = ['easy', 'medium', 'hard', 'expert', 'mixed'];
const operations = ['+', '-', '×', 'multi', 'mixed'];

List<CryptarithmPuzzle> pick(String difficulty, String operation) =>
    PuzzleGenerator.multiplayerCandidates(
        difficulty: difficulty, operation: operation);

void main() {
  test('every lobby combination has puzzles, none of them trivial', () {
    for (final d in difficulties) {
      for (final op in operations) {
        final pool = pick(d, op);
        expect(pool, isNotEmpty, reason: '$d / $op');
        expect(pool.every((p) => p.allLetters.length >= 3), isTrue,
            reason: '$d / $op');
      }
    }
  });

  test('the chosen operation is always respected', () {
    for (final d in difficulties) {
      for (final op in ['+', '-', '×']) {
        expect(pick(d, op).every((p) => !p.isMultiStep && p.operator == op),
            isTrue, reason: '$d / $op');
      }
      expect(pick(d, 'multi').every((p) => p.isMultiStep), isTrue);
    }
  });

  test('the chosen difficulty is respected when it has puzzles', () {
    for (final d in DifficultyLevel.values) {
      for (final op in ['+', '-', 'mixed']) {
        expect(pick(d.name, op).every((p) => p.difficulty == d), isTrue,
            reason: '${d.name} / $op');
      }
    }
  });

  test('Easy multiplication uses Medium, not the whole puzzle list', () {
    final pool = pick('easy', '×');
    expect(pool.map((p) => p.difficulty).toSet(), {DifficultyLevel.medium});
    expect(pool.every((p) => p.operator == '×'), isTrue);
  });

  test("'*' saved by older versions behaves like '×'", () {
    expect(pick('hard', '*').map((p) => p.levelNumber),
        pick('hard', '×').map((p) => p.levelNumber));
  });
}
