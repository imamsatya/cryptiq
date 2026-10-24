import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/domain/entities/puzzle.dart';
import 'package:cryptiq/levels/puzzle_generator.dart';
import 'package:cryptiq/presentation/providers/game_state_provider.dart';
import 'helpers/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initTestDatabase);

  late GameStateNotifier notifier;
  late CryptarithmPuzzle puzzle;

  setUp(() {
    puzzle = PuzzleGenerator.allPuzzles
        .firstWhere((p) => p.allLetters.length >= 4 && !p.isMultiStep);
    notifier = GameStateNotifier(puzzle, null);
  });
  tearDown(() => notifier.dispose());

  void assign(String letter, int digit) {
    notifier.selectLetter(letter);
    notifier.assignDigit(digit);
  }

  test('undo after a hint keeps the hinted letter revealed', () {
    final first = puzzle.allLetters.first;
    assign(first, puzzle.solution[first]!);
    expect(notifier.useHint(), isTrue);
    final hinted = notifier.state.hintedLetters.single;

    notifier.undo();

    expect(notifier.state.assignments[hinted], puzzle.solution[hinted]);
    expect(notifier.state.assignments[first], isNull, reason: 'the assignment itself is undone');
    expect(notifier.state.usedDigits, {puzzle.solution[hinted]});
  });

  test("tapping a hinted letter's digit on another letter doesn't clear the hint", () {
    notifier.useHint();
    final hinted = notifier.state.hintedLetters.single;
    final other = puzzle.allLetters.firstWhere((l) => l != hinted);

    assign(other, puzzle.solution[hinted]!);

    expect(notifier.state.assignments[hinted], puzzle.solution[hinted]);
    expect(notifier.state.assignments[other], isNull);
  });

  test('undo after a hint took a digit from another letter keeps digits unique', () {
    final letters = puzzle.allLetters;
    final hintTarget = letters.firstWhere((l) => l != letters.first);
    // useHint() reveals the first unassigned letter, so fill letters.first
    // with the digit the hint is about to reveal for hintTarget.
    assign(letters.first, puzzle.solution[hintTarget]!);
    expect(notifier.useHint(), isTrue);
    expect(notifier.state.hintedLetters.single, hintTarget);

    notifier.undo();

    final digits = notifier.state.assignments.values.whereType<int>().toList();
    expect(digits.toSet().length, digits.length, reason: 'digits must stay unique');
    expect(notifier.state.assignments[hintTarget], puzzle.solution[hintTarget]);
  });

  test('puzzle is still solvable after hint + undo', () async {
    final first = puzzle.allLetters.first;
    assign(first, puzzle.solution[first]!);
    notifier.useHint();
    notifier.undo();

    for (final letter in puzzle.allLetters) {
      if (notifier.state.hintedLetters.contains(letter)) continue;
      assign(letter, puzzle.solution[letter]!);
    }
    expect(await notifier.checkSolution(), isTrue);
  });

  test('undo still reverts ordinary assignments', () {
    final letters = puzzle.allLetters;
    assign(letters[0], 1);
    assign(letters[1], 2);
    notifier.undo();
    expect(notifier.state.assignments[letters[1]], isNull);
    expect(notifier.state.assignments[letters[0]], 1);
    expect(notifier.state.usedDigits, {1});
  });
}
