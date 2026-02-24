import 'dart:math';
import '../domain/entities/puzzle.dart';

/// Generates 500 cryptarithm puzzles with smooth difficulty progression.
///
/// Progression: starts with 1-letter mixed puzzles (A+A=2), gradually adds
/// more unknown letters and larger numbers, ending with 10-letter classics.
class PuzzleGenerator {
  PuzzleGenerator._();

  static List<CryptarithmPuzzle>? _cache;

  static List<CryptarithmPuzzle> get allPuzzles {
    _cache ??= _generateAll();
    return _cache!;
  }

  static CryptarithmPuzzle getPuzzle(int levelNumber) {
    if (levelNumber < 1 || levelNumber > allPuzzles.length) {
      throw RangeError('Level $levelNumber out of range');
    }
    return allPuzzles[levelNumber - 1];
  }

  static List<CryptarithmPuzzle> getPuzzlesByDifficulty(DifficultyLevel difficulty) {
    return allPuzzles.where((p) => p.difficulty == difficulty).toList();
  }

  static int get totalPuzzles => allPuzzles.length;

  // ================================================================
  // UNIQUE SOLUTION SOLVER (column-wise constraint propagation)
  // ================================================================

  /// Count solutions (stops at maxCount). Handles mixed letter/digit strings.
  static int _countSolutions(List<String> operands, String result, int maxCount) {
    final letterSet = <String>{};
    for (final op in operands) {
      for (final ch in op.split('')) {
        if (isLetterChar(ch)) letterSet.add(ch);
      }
    }
    for (final ch in result.split('')) {
      if (isLetterChar(ch)) letterSet.add(ch);
    }
    final letters = letterSet.toList()..sort();
    final n = letters.length;
    if (n == 0) {
      // No unknowns — just check arithmetic
      return _checkFixedArithmetic(operands, result) ? 1 : 0;
    }
    if (n > 10) return 0;

    final letterIdx = <String, int>{};
    for (int i = 0; i < n; i++) {
      letterIdx[letters[i]] = i;
    }

    // Leading letters that can't be 0
    final isLeading = List.filled(n, false);
    for (final op in operands) {
      if (op.length > 1 && isLetterChar(op[0])) {
        isLeading[letterIdx[op[0]]!] = true;
      }
    }
    if (result.length > 1 && isLetterChar(result[0])) {
      isLeading[letterIdx[result[0]]!] = true;
    }

    // Build columns (right-to-left): encoded values per position
    // Encoding: >= 0 → letter index, < 0 → fixed digit (-(digit+1))
    final maxLen = [result.length, ...operands.map((o) => o.length)].reduce(max);

    final opCols = <List<int>>[]; // operand column entries
    final resCols = <int>[];      // result column entry

    for (int col = 0; col < maxLen; col++) {
      final entries = <int>[];
      for (final op in operands) {
        final pos = op.length - 1 - col;
        if (pos >= 0) {
          final ch = op[pos];
          entries.add(isLetterChar(ch) ? letterIdx[ch]! : -(int.parse(ch) + 1));
        }
      }
      final resPos = result.length - 1 - col;
      int resEntry;
      if (resPos >= 0) {
        final ch = result[resPos];
        resEntry = isLetterChar(ch) ? letterIdx[ch]! : -(int.parse(ch) + 1);
      } else {
        resEntry = -1; // digit 0
      }
      opCols.add(entries);
      resCols.add(resEntry);
    }

    // Determine assignment order: letters in rightmost columns first
    final letterPriority = List.filled(n, maxLen + 1);
    for (int col = 0; col < opCols.length; col++) {
      for (final e in opCols[col]) {
        if (e >= 0 && col < letterPriority[e]) letterPriority[e] = col;
      }
      if (resCols[col] >= 0 && col < letterPriority[resCols[col]]) {
        letterPriority[resCols[col]] = col;
      }
    }
    final assignOrder = List.generate(n, (i) => i);
    assignOrder.sort((a, b) => letterPriority[a].compareTo(letterPriority[b]));

    final assignment = List.filled(n, -1);
    final usedDigit = List.filled(10, false);
    int count = 0;

    int getDigit(int encoded) {
      return encoded >= 0 ? assignment[encoded] : -(encoded + 1);
    }

    bool checkPartial() {
      int carry = 0;
      for (int col = 0; col < opCols.length; col++) {
        bool allAssigned = true;
        for (final e in opCols[col]) {
          if (e >= 0 && assignment[e] < 0) { allAssigned = false; break; }
        }
        if (resCols[col] >= 0 && assignment[resCols[col]] < 0) allAssigned = false;

        if (!allAssigned) break;

        int colSum = carry;
        for (final e in opCols[col]) {
          colSum += getDigit(e);
        }
        if (colSum % 10 != getDigit(resCols[col])) return false;
        carry = colSum ~/ 10;
      }
      return true;
    }

    void solve(int depth) {
      if (count >= maxCount) return;

      if (depth == n) {
        // Full verify with carry
        int carry = 0;
        for (int col = 0; col < opCols.length; col++) {
          int colSum = carry;
          for (final e in opCols[col]) {
            colSum += getDigit(e);
          }
          if (colSum % 10 != getDigit(resCols[col])) return;
          carry = colSum ~/ 10;
        }
        if (carry != 0) return;
        count++;
        return;
      }

      final li = assignOrder[depth];
      final startD = isLeading[li] ? 1 : 0;

      for (int d = startD; d <= 9; d++) {
        if (usedDigit[d]) continue;
        assignment[li] = d;
        usedDigit[d] = true;

        if (checkPartial()) {
          solve(depth + 1);
        }

        assignment[li] = -1;
        usedDigit[d] = false;
        if (count >= maxCount) return;
      }
    }

    solve(0);
    return count;
  }

  static bool _checkFixedArithmetic(List<String> operands, String result) {
    int wordToNum(String w) {
      int v = 0;
      for (final ch in w.split('')) {
        v = v * 10 + int.parse(ch);
      }
      return v;
    }
    return operands.map(wordToNum).reduce((a, b) => a + b) == wordToNum(result);
  }

  static bool _hasUniqueSolution(List<String> operands, String result) {
    return _countSolutions(operands, result, 2) == 1;
  }

  // ================================================================
  // GENERATION WITH GRADUAL DIFFICULTY
  // ================================================================

  static List<CryptarithmPuzzle> _generateAll() {
    final puzzles = <CryptarithmPuzzle>[];
    final rng = Random(42);

    // ---- EASY (Levels 1-100) ----
    // Phase 1: Tutorial — 1 letter, tiny numbers (levels 1-10)
    _generateMixedBatch(puzzles, rng, 10, 1, 1, 1, 9, DifficultyLevel.easy);

    // Phase 2: Beginner — 1-2 letters, small numbers (levels 11-30)
    _generateMixedBatch(puzzles, rng, 20, 1, 1, 10, 50, DifficultyLevel.easy);
    _generateMixedBatch(puzzles, rng, 30, 2, 2, 10, 99, DifficultyLevel.easy);

    // Phase 3: Easy — 2-3 letters (levels 31-60)
    _generateMixedBatch(puzzles, rng, 45, 2, 2, 10, 99, DifficultyLevel.easy);
    _generateMixedBatch(puzzles, rng, 60, 3, 3, 10, 99, DifficultyLevel.easy);

    // Phase 4: Easy+ — 3-5 letters (levels 61-100)
    _generateMixedBatch(puzzles, rng, 80, 3, 4, 10, 999, DifficultyLevel.easy);
    _generateMixedBatch(puzzles, rng, 100, 4, 5, 100, 999, DifficultyLevel.easy);

    // ---- MEDIUM (Levels 101-250): Full cryptarithms, 4-7 letters ----
    _generateFullBatch(puzzles, rng, 175, DifficultyLevel.medium, 100, 999, 4, 6);

    // Insert TWO + TWO = FOUR at a good spot
    _insertCurated(puzzles, ['TWO', 'TWO'], 'FOUR',
        {'T': 7, 'W': 3, 'O': 4, 'F': 1, 'U': 6, 'R': 8}, DifficultyLevel.medium);

    _generateFullBatch(puzzles, rng, 250, DifficultyLevel.medium, 100, 9999, 5, 7);

    // ---- HARD (Levels 251-400): 6-8 letters ----
    _generateFullBatch(puzzles, rng, 350, DifficultyLevel.hard, 100, 9999, 6, 8);

    // Insert SEND + MORE = MONEY
    _insertCurated(puzzles, ['SEND', 'MORE'], 'MONEY',
        {'S': 9, 'E': 5, 'N': 6, 'D': 7, 'M': 1, 'O': 0, 'R': 8, 'Y': 2}, DifficultyLevel.hard);

    _generateFullBatch(puzzles, rng, 400, DifficultyLevel.hard, 100, 99999, 7, 8);

    // ---- EXPERT (Levels 401-500): 7-10 letters ----
    _generateFullBatch(puzzles, rng, 450, DifficultyLevel.expert, 1000, 99999, 7, 9);

    // Insert famous classics
    _insertCurated(puzzles, ['FORTY', 'TEN', 'TEN'], 'SIXTY',
        {'F': 2, 'O': 9, 'R': 7, 'T': 8, 'Y': 6, 'E': 5, 'N': 0, 'S': 3, 'I': 1, 'X': 4},
        DifficultyLevel.expert);
    _insertCurated(puzzles, ['DONALD', 'GERALD'], 'ROBERT',
        {'D': 5, 'O': 2, 'N': 6, 'A': 4, 'L': 8, 'G': 1, 'E': 9, 'R': 7, 'B': 3, 'T': 0},
        DifficultyLevel.expert);

    _generateFullBatch(puzzles, rng, 500, DifficultyLevel.expert, 1000, 99999, 8, 10);

    return puzzles;
  }

  /// Insert a curated puzzle at the current position
  static void _insertCurated(
    List<CryptarithmPuzzle> puzzles,
    List<String> ops,
    String res,
    Map<String, int> sol,
    DifficultyLevel diff,
  ) {
    puzzles.add(CryptarithmPuzzle(
      id: puzzles.length,
      levelNumber: puzzles.length + 1,
      operands: ops,
      result: res,
      operator: '+',
      solution: sol,
      difficulty: diff,
      uniqueLetters: sol.length,
    ));
  }

  // ================================================================
  // MIXED PUZZLE GENERATION (some digits given, some as letters)
  // ================================================================

  /// Generate mixed puzzles where only [minLetters]-[maxLetters] digits
  /// become letter unknowns, rest are shown as given digits.
  static void _generateMixedBatch(
    List<CryptarithmPuzzle> puzzles,
    Random rng,
    int targetCount,
    int minLetters,
    int maxLetters,
    int minVal,
    int maxVal,
    DifficultyLevel difficulty,
  ) {
    int failures = 0;
    while (puzzles.length < targetCount && failures < 50000) {
      final p = _generateMixedPuzzle(
        rng, puzzles.length, minLetters, maxLetters, minVal, maxVal, difficulty,
      );
      if (p != null && !_isDuplicate(puzzles, p)) {
        if (_hasUniqueSolution(p.operands, p.result)) {
          puzzles.add(p);
          failures = 0;
        } else {
          failures++;
        }
      } else {
        failures++;
      }
    }
  }

  /// Generate a single mixed puzzle.
  static CryptarithmPuzzle? _generateMixedPuzzle(
    Random rng,
    int index,
    int minLetters,
    int maxLetters,
    int minVal,
    int maxVal,
    DifficultyLevel difficulty,
  ) {
    for (int attempt = 0; attempt < 500; attempt++) {
      final a = minVal + rng.nextInt(maxVal - minVal + 1);
      final b = minVal + rng.nextInt(maxVal - minVal + 1);
      final c = a + b;

      if (c.toString()[0] == '0') continue;

      final aStr = a.toString();
      final bStr = b.toString();
      final cStr = c.toString();

      // Collect unique digits used across all three numbers
      final allChars = <String>{};
      allChars.addAll(aStr.split(''));
      allChars.addAll(bStr.split(''));
      allChars.addAll(cStr.split(''));
      final uniqueDigits = allChars.map(int.parse).toSet().toList();

      // Need enough unique digits to assign to letters
      final targetLetters = minLetters + rng.nextInt(maxLetters - minLetters + 1);
      if (uniqueDigits.length < targetLetters) continue;

      // Randomly select which digits become letter unknowns
      uniqueDigits.shuffle(rng);
      final letteredDigits = uniqueDigits.take(targetLetters).toSet();

      // Map each selected digit to a unique letter
      final digitToLetter = <int, String>{};
      final letterPool = _getLetterPool(rng);
      int li = 0;
      for (final d in letteredDigits) {
        digitToLetter[d] = letterPool[li++];
      }

      // Build mixed strings: letters for unknowns, digit chars for knowns
      String convertNum(String numStr) {
        return numStr.split('').map((ch) {
          final d = int.parse(ch);
          return digitToLetter.containsKey(d) ? digitToLetter[d]! : ch;
        }).join();
      }

      final word1 = convertNum(aStr);
      final word2 = convertNum(bStr);
      final wordResult = convertNum(cStr);

      // Build solution (only for lettered digits)
      final solution = <String, int>{};
      for (final entry in digitToLetter.entries) {
        solution[entry.value] = entry.key;
      }

      // Check leading: if a multi-char word starts with a letter, it can't be 0
      bool leadingZero = false;
      for (final w in [word1, word2, wordResult]) {
        if (w.length > 1 && isLetterChar(w[0]) && solution[w[0]] == 0) {
          leadingZero = true;
          break;
        }
      }
      if (leadingZero) continue;

      return CryptarithmPuzzle(
        id: index,
        levelNumber: index + 1,
        operands: [word1, word2],
        result: wordResult,
        operator: '+',
        solution: solution,
        difficulty: difficulty,
        uniqueLetters: solution.length,
      );
    }
    return null;
  }

  // ================================================================
  // FULL CRYPTARITHM GENERATION (all digits are letters)
  // ================================================================

  static void _generateFullBatch(
    List<CryptarithmPuzzle> puzzles,
    Random rng,
    int targetCount,
    DifficultyLevel difficulty,
    int minVal,
    int maxVal,
    int minLetters,
    int maxLetters,
  ) {
    int failures = 0;
    while (puzzles.length < targetCount && failures < 100000) {
      final p = _generateFullPuzzle(rng, puzzles.length, difficulty, minVal, maxVal, minLetters, maxLetters);
      if (p != null && !_isDuplicate(puzzles, p)) {
        if (_hasUniqueSolution(p.operands, p.result)) {
          puzzles.add(p);
          failures = 0;
        } else {
          failures++;
        }
      } else {
        failures++;
      }
    }
  }

  static CryptarithmPuzzle? _generateFullPuzzle(
    Random rng,
    int index,
    DifficultyLevel difficulty,
    int minVal,
    int maxVal,
    int minLetters,
    int maxLetters,
  ) {
    for (int attempt = 0; attempt < 200; attempt++) {
      final a = minVal + rng.nextInt(maxVal - minVal + 1);
      final b = minVal + rng.nextInt(maxVal - minVal + 1);
      final c = a + b;

      final aStr = a.toString();
      final bStr = b.toString();
      final cStr = c.toString();

      final allDigits = <int>{};
      for (final ch in aStr.split('')) { allDigits.add(int.parse(ch)); }
      for (final ch in bStr.split('')) { allDigits.add(int.parse(ch)); }
      for (final ch in cStr.split('')) { allDigits.add(int.parse(ch)); }

      if (allDigits.length < minLetters || allDigits.length > maxLetters) continue;
      if (allDigits.length > 10) continue;
      if (aStr[0] == '0' || bStr[0] == '0' || cStr[0] == '0') continue;

      final digitToLetter = <int, String>{};
      final availableLetters = _getLetterPool(rng);
      int letterIdx = 0;
      for (final d in allDigits.toList()..sort()) {
        digitToLetter[d] = availableLetters[letterIdx++];
      }

      final solution = <String, int>{};
      for (final entry in digitToLetter.entries) {
        solution[entry.value] = entry.key;
      }

      String numToWord(String num) =>
          num.split('').map((ch) => digitToLetter[int.parse(ch)]!).join();

      final word1 = numToWord(aStr);
      final word2 = numToWord(bStr);
      final wordResult = numToWord(cStr);

      if (solution[word1[0]] == 0 || solution[word2[0]] == 0 || solution[wordResult[0]] == 0) {
        continue;
      }

      return CryptarithmPuzzle(
        id: index,
        levelNumber: index + 1,
        operands: [word1, word2],
        result: wordResult,
        operator: '+',
        solution: solution,
        difficulty: difficulty,
        uniqueLetters: solution.length,
      );
    }
    return null;
  }

  // ================================================================
  // HELPERS
  // ================================================================

  static bool _isDuplicate(List<CryptarithmPuzzle> existing, CryptarithmPuzzle puzzle) {
    for (final p in existing) {
      if (p.operands.join() == puzzle.operands.join() && p.result == puzzle.result) {
        return true;
      }
    }
    return false;
  }

  static List<String> _getLetterPool(Random rng) {
    final pools = [
      'ABCDEFGHIJ', 'KLMNOPQRST', 'UVWXYZABCD',
      'ACEGIKMOQS', 'BDFHJLNPRT', 'STNRLOAEIM',
      'PWGYHBKDCF', 'MRJXZQVWUE',
    ];
    final pool = pools[rng.nextInt(pools.length)].split('');
    pool.shuffle(rng);
    return pool;
  }
}
