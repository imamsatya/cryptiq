import 'dart:math';
import '../domain/entities/puzzle.dart';

/// Generates 1000 cryptarithm puzzles with mixed operations (+, −, ×)
/// and smooth difficulty progression. Every puzzle has a unique solution.
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
  // GENERATION
  // ================================================================

  static List<CryptarithmPuzzle> _generateAll() {
    final puzzles = <CryptarithmPuzzle>[];
    final rng = Random(42);

    // ============================================================
    // EASY (1-250): Learn + then −
    // ============================================================

    // Tutorial addition: 1 letter (1-10)
    _mixedBatch(puzzles, rng, 10, 1, 1, 1, 9, DifficultyLevel.easy, '+');
    // Beginner addition: 1-2 letters (11-40)
    _mixedBatch(puzzles, rng, 25, 1, 1, 10, 50, DifficultyLevel.easy, '+');
    _mixedBatch(puzzles, rng, 40, 2, 2, 10, 99, DifficultyLevel.easy, '+');
    // Easy addition: 2-3 letters (41-80)
    _mixedBatch(puzzles, rng, 60, 2, 3, 10, 99, DifficultyLevel.easy, '+');
    _mixedBatch(puzzles, rng, 80, 3, 3, 10, 99, DifficultyLevel.easy, '+');
    // Easy+ addition: 3-5 letters (81-130)
    _mixedBatch(puzzles, rng, 105, 3, 4, 10, 999, DifficultyLevel.easy, '+');
    _fullBatch(puzzles, rng, 130, DifficultyLevel.easy, 100, 999, 4, 5, '+');
    // Introduce subtraction: 1-2 letters (131-160)
    _mixedBatch(puzzles, rng, 145, 1, 2, 1, 50, DifficultyLevel.easy, '-');
    _mixedBatch(puzzles, rng, 160, 2, 3, 10, 99, DifficultyLevel.easy, '-');
    // Subtraction: 3-4 letters (161-200)
    _mixedBatch(puzzles, rng, 180, 3, 4, 10, 99, DifficultyLevel.easy, '-');
    _fullBatch(puzzles, rng, 200, DifficultyLevel.easy, 10, 999, 3, 5, '-');
    // Mix + and − (201-250)
    _fullBatch(puzzles, rng, 225, DifficultyLevel.easy, 100, 999, 4, 5, '+');
    _fullBatch(puzzles, rng, 250, DifficultyLevel.easy, 100, 999, 4, 5, '-');

    // ============================================================
    // MEDIUM (251-500): Master +/−, learn ×
    // ============================================================

    _fullBatch(puzzles, rng, 290, DifficultyLevel.medium, 100, 999, 5, 6, '+');
    _fullBatch(puzzles, rng, 330, DifficultyLevel.medium, 100, 999, 5, 6, '-');
    // Introduce multiplication: 1-3 letters (331-380)
    _mixedBatch(puzzles, rng, 350, 1, 2, 2, 9, DifficultyLevel.medium, '×');
    _mixedBatch(puzzles, rng, 370, 2, 3, 2, 20, DifficultyLevel.medium, '×');
    _mulBatch(puzzles, rng, 390, DifficultyLevel.medium, 2, 30, 3, 5);
    // Mix all three (391-500)
    _fullBatch(puzzles, rng, 420, DifficultyLevel.medium, 100, 9999, 5, 7, '+');
    // TWO + TWO = FOUR
    _curated(puzzles, ['TWO', 'TWO'], 'FOUR',
        {'T': 7, 'W': 3, 'O': 4, 'F': 1, 'U': 6, 'R': 8}, DifficultyLevel.medium, '+');
    _fullBatch(puzzles, rng, 460, DifficultyLevel.medium, 100, 9999, 5, 7, '-');
    _mulBatch(puzzles, rng, 500, DifficultyLevel.medium, 10, 99, 4, 6);

    // ============================================================
    // HARD (501-750): All operations, larger puzzles
    // ============================================================

    _fullBatch(puzzles, rng, 540, DifficultyLevel.hard, 100, 9999, 6, 8, '+');
    // SEND + MORE = MONEY
    _curated(puzzles, ['SEND', 'MORE'], 'MONEY',
        {'S': 9, 'E': 5, 'N': 6, 'D': 7, 'M': 1, 'O': 0, 'R': 8, 'Y': 2},
        DifficultyLevel.hard, '+');
    _fullBatch(puzzles, rng, 590, DifficultyLevel.hard, 100, 9999, 6, 8, '-');
    _mulBatch(puzzles, rng, 630, DifficultyLevel.hard, 10, 999, 5, 7);
    _fullBatch(puzzles, rng, 690, DifficultyLevel.hard, 100, 99999, 7, 8, '+');
    _fullBatch(puzzles, rng, 750, DifficultyLevel.hard, 100, 99999, 7, 8, '-');

    // ============================================================
    // EXPERT (751-1000): Maximum difficulty
    // ============================================================

    _fullBatch(puzzles, rng, 820, DifficultyLevel.expert, 1000, 99999, 7, 9, '+');
    _fullBatch(puzzles, rng, 880, DifficultyLevel.expert, 1000, 99999, 7, 9, '-');
    _mulBatch(puzzles, rng, 920, DifficultyLevel.expert, 10, 9999, 6, 7);
    // Classics
    _curated(puzzles, ['FORTY', 'TEN', 'TEN'], 'SIXTY',
        {'F': 2, 'O': 9, 'R': 7, 'T': 8, 'Y': 6, 'E': 5, 'N': 0, 'S': 3, 'I': 1, 'X': 4},
        DifficultyLevel.expert, '+');
    _curated(puzzles, ['DONALD', 'GERALD'], 'ROBERT',
        {'D': 5, 'O': 2, 'N': 6, 'A': 4, 'L': 8, 'G': 1, 'E': 9, 'R': 7, 'B': 3, 'T': 0},
        DifficultyLevel.expert, '+');
    _fullBatch(puzzles, rng, 960, DifficultyLevel.expert, 1000, 99999, 8, 10, '+');
    _fullBatch(puzzles, rng, 1000, DifficultyLevel.expert, 1000, 99999, 8, 10, '-');

    return puzzles;
  }

  // ================================================================
  // CURATED
  // ================================================================

  static void _curated(List<CryptarithmPuzzle> p, List<String> ops, String res,
      Map<String, int> sol, DifficultyLevel diff, String op) {
    p.add(CryptarithmPuzzle(
      id: p.length, levelNumber: p.length + 1,
      operands: ops, result: res, operator: op, solution: sol,
      difficulty: diff, uniqueLetters: sol.length,
    ));
  }

  // ================================================================
  // MIXED PUZZLE GENERATION (some digits given, some letters)
  // ================================================================

  static void _mixedBatch(List<CryptarithmPuzzle> puzzles, Random rng,
      int target, int minL, int maxL, int minV, int maxV,
      DifficultyLevel diff, String op) {
    int fail = 0;
    while (puzzles.length < target && fail < 50000) {
      final p = _genMixed(rng, puzzles.length, minL, maxL, minV, maxV, diff, op);
      if (p != null && !_isDup(puzzles, p)) {
        if (_hasUnique(p.operands, p.result, op)) {
          puzzles.add(p);
          fail = 0;
        } else {
          fail++;
        }
      } else {
        fail++;
      }
    }
  }

  static CryptarithmPuzzle? _genMixed(Random rng, int idx, int minL, int maxL,
      int minV, int maxV, DifficultyLevel diff, String op) {
    for (int attempt = 0; attempt < 500; attempt++) {
      int a, b, c;
      List<String> operands;
      String result;

      if (op == '+') {
        a = minV + rng.nextInt(maxV - minV + 1);
        b = minV + rng.nextInt(maxV - minV + 1);
        c = a + b;
        operands = [a.toString(), b.toString()];
        result = c.toString();
      } else if (op == '-') {
        // Generate addition a + b = c, present as c - a = b
        a = minV + rng.nextInt(maxV - minV + 1);
        b = minV + rng.nextInt(maxV - minV + 1);
        c = a + b;
        operands = [c.toString(), a.toString()];
        result = b.toString();
      } else {
        // Multiplication: a × b = c
        final aMin = minV < 2 ? 2 : minV;
        final bMax = maxV < 9 ? maxV : 9;
        a = aMin + rng.nextInt((maxV - aMin + 1).clamp(1, 999999));
        b = 2 + rng.nextInt((bMax - 2 + 1).clamp(1, 8));
        if (a < b) { final t = a; a = b; b = t; } // a >= b
        c = a * b;
        operands = [a.toString(), b.toString()];
        result = c.toString();
      }

      if (result[0] == '0') continue;
      for (final o in operands) {
        if (o[0] == '0') continue;
      }

      // Collect unique digits
      final allChars = <String>{};
      for (final o in operands) {
        allChars.addAll(o.split(''));
      }
      allChars.addAll(result.split(''));
      final uniqueDigits = allChars.map(int.parse).toSet().toList();

      final targetL = minL + rng.nextInt(maxL - minL + 1);
      if (uniqueDigits.length < targetL) continue;

      uniqueDigits.shuffle(rng);
      final lettered = uniqueDigits.take(targetL).toSet();

      final d2l = <int, String>{};
      final pool = _letterPool(rng);
      int li = 0;
      for (final d in lettered) {
        d2l[d] = pool[li++];
      }

      String convert(String s) => s.split('').map((ch) {
            final d = int.parse(ch);
            return d2l.containsKey(d) ? d2l[d]! : ch;
          }).join();

      final words = operands.map(convert).toList();
      final wordRes = convert(result);

      final sol = <String, int>{};
      for (final e in d2l.entries) {
        sol[e.value] = e.key;
      }

      // Leading zero check
      bool bad = false;
      for (final w in [...words, wordRes]) {
        if (w.length > 1 && isLetterChar(w[0]) && sol[w[0]] == 0) {
          bad = true;
          break;
        }
      }
      if (bad) continue;

      return CryptarithmPuzzle(
        id: idx, levelNumber: idx + 1, operands: words, result: wordRes,
        operator: op, solution: sol, difficulty: diff, uniqueLetters: sol.length,
      );
    }
    return null;
  }

  // ================================================================
  // FULL CRYPTARITHM GENERATION (all digits are letters)
  // ================================================================

  static void _fullBatch(List<CryptarithmPuzzle> puzzles, Random rng,
      int target, DifficultyLevel diff, int minV, int maxV,
      int minL, int maxL, String op) {
    int fail = 0;
    while (puzzles.length < target && fail < 100000) {
      final p = _genFull(rng, puzzles.length, diff, minV, maxV, minL, maxL, op);
      if (p != null && !_isDup(puzzles, p)) {
        if (_hasUnique(p.operands, p.result, op)) {
          puzzles.add(p);
          fail = 0;
        } else {
          fail++;
        }
      } else {
        fail++;
      }
    }
  }

  static CryptarithmPuzzle? _genFull(Random rng, int idx, DifficultyLevel diff,
      int minV, int maxV, int minL, int maxL, String op) {
    for (int attempt = 0; attempt < 200; attempt++) {
      int a, b, c;
      List<String> numOps;
      String numRes;

      if (op == '+') {
        a = minV + rng.nextInt(maxV - minV + 1);
        b = minV + rng.nextInt(maxV - minV + 1);
        c = a + b;
        numOps = [a.toString(), b.toString()];
        numRes = c.toString();
      } else if (op == '-') {
        a = minV + rng.nextInt(maxV - minV + 1);
        b = minV + rng.nextInt(maxV - minV + 1);
        c = a + b;
        numOps = [c.toString(), a.toString()];
        numRes = b.toString();
      } else {
        final aMin2 = minV < 2 ? 2 : minV;
        final bMax2 = (maxV ~/ 10) < 2 ? 2 : (maxV ~/ 10 < 9 ? maxV ~/ 10 : 9);
        a = aMin2 + rng.nextInt((maxV - aMin2 + 1).clamp(1, 999999));
        b = 2 + rng.nextInt((bMax2 - 2 + 1).clamp(1, 8));
        if (a < b) { final t = a; a = b; b = t; }
        c = a * b;
        numOps = [a.toString(), b.toString()];
        numRes = c.toString();
      }

      if (numRes[0] == '0') continue;

      final allDigits = <int>{};
      for (final s in [...numOps, numRes]) {
        for (final ch in s.split('')) {
          allDigits.add(int.parse(ch));
        }
      }

      if (allDigits.length < minL || allDigits.length > maxL) continue;
      if (allDigits.length > 10) continue;

      final d2l = <int, String>{};
      final pool = _letterPool(rng);
      int li = 0;
      for (final d in allDigits.toList()..sort()) {
        d2l[d] = pool[li++];
      }

      final sol = <String, int>{};
      for (final e in d2l.entries) {
        sol[e.value] = e.key;
      }

      String toWord(String s) =>
          s.split('').map((ch) => d2l[int.parse(ch)]!).join();

      final words = numOps.map(toWord).toList();
      final wordRes = toWord(numRes);

      bool bad = false;
      for (final w in [...words, wordRes]) {
        if (w.length > 1 && sol[w[0]] == 0) {
          bad = true;
          break;
        }
      }
      if (bad) continue;

      return CryptarithmPuzzle(
        id: idx, levelNumber: idx + 1, operands: words, result: wordRes,
        operator: op, solution: sol, difficulty: diff, uniqueLetters: sol.length,
      );
    }
    return null;
  }

  // ================================================================
  // MULTIPLICATION-SPECIFIC BATCH
  // ================================================================

  static void _mulBatch(List<CryptarithmPuzzle> puzzles, Random rng,
      int target, DifficultyLevel diff, int minV, int maxV,
      int minL, int maxL) {
    _fullBatch(puzzles, rng, target, diff, minV, maxV, minL, maxL, '×');
  }

  // ================================================================
  // UNIQUE SOLUTION VERIFICATION
  // ================================================================

  static bool _hasUnique(List<String> ops, String res, String op) {
    if (op == '+') {
      return _countAdd(ops, res, 2) == 1;
    } else if (op == '-') {
      // A - B = C  ⟺  B + C = A (same unique constraint)
      return _countAdd([ops[1], res], ops[0], 2) == 1;
    } else {
      return _countBrute(ops, res, op, 2) == 1;
    }
  }

  // ---- Column-wise solver for addition (fast) ----

  static int _countAdd(List<String> operands, String result, int maxCount) {
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
    if (n == 0) return _checkFixed(operands, result, '+') ? 1 : 0;
    if (n > 10) return 0;

    final lIdx = <String, int>{};
    for (int i = 0; i < n; i++) {
      lIdx[letters[i]] = i;
    }

    final isLead = List.filled(n, false);
    for (final op in operands) {
      if (op.length > 1 && isLetterChar(op[0])) isLead[lIdx[op[0]]!] = true;
    }
    if (result.length > 1 && isLetterChar(result[0])) {
      isLead[lIdx[result[0]]!] = true;
    }

    final maxLen = [result.length, ...operands.map((o) => o.length)].reduce(max);
    final opCols = <List<int>>[];
    final resCols = <int>[];

    for (int col = 0; col < maxLen; col++) {
      final entries = <int>[];
      for (final op in operands) {
        final pos = op.length - 1 - col;
        if (pos >= 0) {
          final ch = op[pos];
          entries.add(isLetterChar(ch) ? lIdx[ch]! : -(int.parse(ch) + 1));
        }
      }
      final resPos = result.length - 1 - col;
      int resEntry;
      if (resPos >= 0) {
        final ch = result[resPos];
        resEntry = isLetterChar(ch) ? lIdx[ch]! : -(int.parse(ch) + 1);
      } else {
        resEntry = -1;
      }
      opCols.add(entries);
      resCols.add(resEntry);
    }

    final priority = List.filled(n, maxLen + 1);
    for (int col = 0; col < opCols.length; col++) {
      for (final e in opCols[col]) {
        if (e >= 0 && col < priority[e]) priority[e] = col;
      }
      if (resCols[col] >= 0 && col < priority[resCols[col]]) {
        priority[resCols[col]] = col;
      }
    }
    final order = List.generate(n, (i) => i);
    order.sort((a, b) => priority[a].compareTo(priority[b]));

    final asgn = List.filled(n, -1);
    final used = List.filled(10, false);
    int count = 0;

    int dig(int enc) => enc >= 0 ? asgn[enc] : -(enc + 1);

    bool partial() {
      int carry = 0;
      for (int col = 0; col < opCols.length; col++) {
        bool allSet = true;
        for (final e in opCols[col]) {
          if (e >= 0 && asgn[e] < 0) { allSet = false; break; }
        }
        if (resCols[col] >= 0 && asgn[resCols[col]] < 0) allSet = false;
        if (!allSet) break;
        int s = carry;
        for (final e in opCols[col]) {
          s += dig(e);
        }
        if (s % 10 != dig(resCols[col])) return false;
        carry = s ~/ 10;
      }
      return true;
    }

    void solve(int depth) {
      if (count >= maxCount) return;
      if (depth == n) {
        int carry = 0;
        for (int col = 0; col < opCols.length; col++) {
          int s = carry;
          for (final e in opCols[col]) {
            s += dig(e);
          }
          if (s % 10 != dig(resCols[col])) return;
          carry = s ~/ 10;
        }
        if (carry != 0) return;
        count++;
        return;
      }
      final li = order[depth];
      for (int d = isLead[li] ? 1 : 0; d <= 9; d++) {
        if (used[d]) continue;
        asgn[li] = d;
        used[d] = true;
        if (partial()) solve(depth + 1);
        asgn[li] = -1;
        used[d] = false;
        if (count >= maxCount) return;
      }
    }

    solve(0);
    return count;
  }

  // ---- Brute-force solver for multiplication (and any op) ----

  static int _countBrute(
      List<String> operands, String result, String op, int maxCount) {
    final letterSet = <String>{};
    for (final o in operands) {
      for (final ch in o.split('')) {
        if (isLetterChar(ch)) letterSet.add(ch);
      }
    }
    for (final ch in result.split('')) {
      if (isLetterChar(ch)) letterSet.add(ch);
    }
    final letters = letterSet.toList()..sort();
    final n = letters.length;
    if (n == 0) return _checkFixed(operands, result, op) ? 1 : 0;
    if (n > 10) return 0;

    final leading = <String>{};
    for (final o in operands) {
      if (o.length > 1 && isLetterChar(o[0])) leading.add(o[0]);
    }
    if (result.length > 1 && isLetterChar(result[0])) {
      leading.add(result[0]);
    }

    int count = 0;
    final asgn = List.filled(n, -1);
    final used = List.filled(10, false);

    void solve(int depth) {
      if (count >= maxCount) return;
      if (depth == n) {
        final m = <String, int>{};
        for (int i = 0; i < n; i++) {
          m[letters[i]] = asgn[i];
        }
        int w2n(String w) {
          int v = 0;
          for (final ch in w.split('')) {
            v = v * 10 + (isLetterChar(ch) ? m[ch]! : int.parse(ch));
          }
          return v;
        }
        final opVals = operands.map(w2n).toList();
        final resVal = w2n(result);
        final bool valid = switch (op) {
          '×' => opVals.reduce((a, b) => a * b) == resVal,
          '-' => opVals.first - opVals.skip(1).reduce((a, b) => a + b) ==
              resVal,
          _ => opVals.reduce((a, b) => a + b) == resVal,
        };
        if (valid) count++;
        return;
      }
      final letter = letters[depth];
      for (int d = leading.contains(letter) ? 1 : 0; d <= 9; d++) {
        if (used[d]) continue;
        asgn[depth] = d;
        used[d] = true;
        solve(depth + 1);
        used[d] = false;
        if (count >= maxCount) return;
      }
    }

    solve(0);
    return count;
  }

  // ---- Fixed arithmetic check ----

  static bool _checkFixed(List<String> operands, String result, String op) {
    int w2n(String w) {
      int v = 0;
      for (final ch in w.split('')) {
        v = v * 10 + int.parse(ch);
      }
      return v;
    }
    final opVals = operands.map(w2n).toList();
    final resVal = w2n(result);
    return switch (op) {
      '×' => opVals.reduce((a, b) => a * b) == resVal,
      '-' => opVals.first - opVals.skip(1).reduce((a, b) => a + b) == resVal,
      _ => opVals.reduce((a, b) => a + b) == resVal,
    };
  }

  // ================================================================
  // HELPERS
  // ================================================================

  static bool _isDup(List<CryptarithmPuzzle> existing, CryptarithmPuzzle p) {
    for (final e in existing) {
      if (e.operands.join() == p.operands.join() &&
          e.result == p.result &&
          e.operator == p.operator) {
        return true;
      }
    }
    return false;
  }

  static List<String> _letterPool(Random rng) {
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
