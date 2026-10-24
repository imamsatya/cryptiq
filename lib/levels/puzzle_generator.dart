import '../domain/entities/puzzle.dart';
import 'puzzle_data.dart';

/// Loads pre-computed puzzles from static data.
/// Zero generation time — all puzzles load instantly.
///
/// To regenerate single-step: `dart run tool/generate_puzzle_data.dart`
/// To add multi-step: `dart run tool/generate_multistep_data.dart`
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

      // Parse multi-step data (optional 7th element)
      final List<PuzzleStep> steps;
      if (d.length > 6 && d[6] != null) {
        final stepsData = d[6] as List;
        steps = stepsData.map((s) {
          final step = s as List;
          final stepOps = (step[0] as List).cast<String>();
          final stepRes = step[1] as String;
          final stepOp = step[2] as String;
          return PuzzleStep(
            operands: stepOps,
            result: stepRes,
            operator: stepOp,
          );
        }).toList();
      } else {
        steps = const [];
      }

      return CryptarithmPuzzle(
        id: i,
        levelNumber: i + 1,
        operands: ops,
        result: res,
        operator: op,
        solution: sol,
        difficulty: diff,
        uniqueLetters: uniqueL,
        steps: steps,
      );
    });
  }

  /// Puzzles for a Pass & Play game. [difficulty] is easy|medium|hard|expert|
  /// mixed and [operation] is +|-|×|multi|mixed. The filters are never
  /// dropped: a combination with no puzzles (Easy ×) uses the nearest
  /// difficulty instead.
  static List<CryptarithmPuzzle> multiplayerCandidates({
    required String difficulty,
    required String operation,
  }) {
    final op = operation == '*' ? '×' : operation; // '*' was saved by 1.0.1
    final pool = allPuzzles.where((p) {
      if (p.allLetters.length < 3) return false; // too trivial to race on
      return switch (op) {
        'multi' => p.isMultiStep,
        'mixed' => true,
        _ => !p.isMultiStep && p.operator == op,
      };
    }).toList();
    if (pool.isEmpty) {
      return allPuzzles.where((p) => p.allLetters.length >= 3).toList();
    }

    // Multi-step puzzles are all Expert, so their difficulty is ignored.
    final selected = DifficultyLevel.values.asNameMap()[difficulty];
    if (op == 'multi' || selected == null) return pool;

    // Nearest difficulty first; harder before easier on ties.
    final order = DifficultyLevel.values.toList()
      ..sort((a, b) {
        final da = (a.index - selected.index).abs();
        final db = (b.index - selected.index).abs();
        return da != db ? da.compareTo(db) : b.index.compareTo(a.index);
      });
    for (final d in order) {
      final match = pool.where((p) => p.difficulty == d).toList();
      if (match.isNotEmpty) return match;
    }
    return pool;
  }

  static String getDifficultyName(int levelNumber) {
    if (levelNumber <= 250) return 'Easy';
    if (levelNumber <= 500) return 'Medium';
    if (levelNumber <= 750) return 'Hard';
    return 'Expert';
  }
}
