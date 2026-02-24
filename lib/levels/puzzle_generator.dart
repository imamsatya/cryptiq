import '../domain/entities/puzzle.dart';
import 'puzzle_data.dart';

/// Loads pre-computed puzzles from static data.
/// Zero generation time — all 1000 puzzles load instantly.
///
/// To regenerate: `dart run tool/generate_puzzle_data.dart`
class PuzzleGenerator {
  PuzzleGenerator._();

  static List<CryptarithmPuzzle>? _cache;

  static int get totalPuzzles => puzzleData.length;

  static List<CryptarithmPuzzle> get allPuzzles {
    _cache ??= _loadAll();
    return _cache!;
  }

  static CryptarithmPuzzle getPuzzle(int levelNumber) {
    if (levelNumber < 1 || levelNumber > totalPuzzles) {
      throw RangeError('Level $levelNumber out of range');
    }
    return allPuzzles[levelNumber - 1];
  }

  static List<CryptarithmPuzzle> getPuzzlesByDifficulty(DifficultyLevel difficulty) {
    return allPuzzles.where((p) => p.difficulty == difficulty).toList();
  }

  static const _diffMap = [
    DifficultyLevel.easy,
    DifficultyLevel.medium,
    DifficultyLevel.hard,
    DifficultyLevel.expert,
  ];

  static List<CryptarithmPuzzle> _loadAll() {
    return List.generate(puzzleData.length, (i) {
      final d = puzzleData[i];
      final ops = (d[0] as List).cast<String>();
      final res = d[1] as String;
      final op = d[2] as String;
      final sol = (d[3] as Map).cast<String, int>();
      final diff = _diffMap[d[4] as int];
      final uniqueL = d[5] as int;

      return CryptarithmPuzzle(
        id: i,
        levelNumber: i + 1,
        operands: ops,
        result: res,
        operator: op,
        solution: sol,
        difficulty: diff,
        uniqueLetters: uniqueL,
      );
    });
  }
}
