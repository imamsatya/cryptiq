// Generates 200 multi-step puzzles and appends to puzzle_data.dart
// Run with: dart run tool/generate_multistep_data.dart

import 'dart:io';
import 'dart:math';

bool isLetter(String ch) {
  final c = ch.codeUnitAt(0);
  return c >= 65 && c <= 90;
}

class MStep {
  final List<String> operands;
  final String result;
  final String operator;
  MStep(this.operands, this.result, this.operator);
}

class MPuzzle {
  final List<MStep> steps;
  final Map<String, int> solution;
  final int difficulty; // 3 = expert
  final int uniqueLetters;
  MPuzzle(this.steps, this.solution, this.difficulty, this.uniqueLetters);
}

void main() {
  print('Generating 200 multi-step puzzles...');
  final sw = Stopwatch()..start();
  final rng = Random(999);

  final puzzles = <MPuzzle>[];

  // 2-step puzzles: A op B = C, C op D = E (100 puzzles)
  print('  Generating 100 two-step puzzles...');
  generate2Step(puzzles, rng, 100, 3, 6); // 3-6 unique letters
  print('    Done: ${puzzles.length}');

  // 2-step harder (50 puzzles)
  print('  Generating 50 harder two-step puzzles...');
  generate2Step(puzzles, rng, 150, 5, 8); // 5-8 unique letters
  print('    Done: ${puzzles.length}');

  // 3-step puzzles: A+B=C, C+D=E, E+F=G (50 puzzles)
  print('  Generating 50 three-step puzzles...');
  generate3Step(puzzles, rng, 200, 5, 8);
  print('    Done: ${puzzles.length}');

  sw.stop();
  print('Generated ${puzzles.length} puzzles in ${sw.elapsed.inSeconds}s');

  // Read existing data
  final existing = File('lib/levels/puzzle_data.dart').readAsStringSync();
  final closingBracket = existing.lastIndexOf('];');
  if (closingBracket == -1) {
    print('ERROR: Could not find closing bracket in puzzle_data.dart');
    return;
  }

  final buf = StringBuffer();
  buf.write(existing.substring(0, closingBracket));
  buf.writeln('  // === MULTI-STEP PUZZLES (Level 1001-${1000 + puzzles.length}) ===');

  for (int i = 0; i < puzzles.length; i++) {
    final p = puzzles[i];
    // First step's operands for backward compat
    final mainOps = p.steps.first.operands.map((o) => "'$o'").join(', ');
    final finalResult = p.steps.last.result;
    final mainOp = p.steps.first.operator;
    final sol = p.solution.entries.map((e) => "'${e.key}': ${e.value}").join(', ');

    // Steps data
    final stepsStr = p.steps.map((s) {
      final sOps = s.operands.map((o) => "'$o'").join(', ');
      return "[[$sOps], '${s.result}', '${s.operator}']";
    }).join(', ');

    buf.writeln("  [[$mainOps], '$finalResult', '$mainOp', {$sol}, ${p.difficulty}, ${p.uniqueLetters}, [$stepsStr]],");
  }
  buf.writeln('];');

  File('lib/levels/puzzle_data.dart').writeAsStringSync(buf.toString());
  print('Appended to lib/levels/puzzle_data.dart');

  // Update header
  final updatedContent = File('lib/levels/puzzle_data.dart').readAsStringSync();
  final newContent = updatedContent.replaceFirst(
    RegExp(r'// (\d+) puzzles with verified unique solutions'),
    '// ${1000 + puzzles.length} puzzles with verified unique solutions',
  );
  File('lib/levels/puzzle_data.dart').writeAsStringSync(newContent);
  print('Total: ${1000 + puzzles.length} puzzles');
}

// ================================================================
// 2-STEP GENERATION: A op B = C, C op D = E
// ================================================================

void generate2Step(List<MPuzzle> puzzles, Random rng, int target, int minL, int maxL) {
  int fail = 0;
  while (puzzles.length < target && fail < 100000) {
    final ops = ['+', '-', '+', '-', '+', '×'];
    final op1 = ops[rng.nextInt(4)]; // +/- for step 1
    final op2 = ops[rng.nextInt(4)]; // +/- for step 2

    int a, b, c, d, e;

    // Step 1
    a = 10 + rng.nextInt(990);
    b = 10 + rng.nextInt(990);
    if (op1 == '+') {
      c = a + b;
    } else {
      c = a + b; // ensure c > a, c > b
      final tmp = c;
      c = tmp; // c = a + b (minuend)
      final sub = a;
      a = c; // swap: a - b = sub
      c = sub;
      // Actually: a - b = c  where a=tmp, b=b, c=sub... let me simplify
      // For subtraction: pick a > b, c = a - b
      a = 100 + rng.nextInt(900);
      b = 10 + rng.nextInt(a - 10);
      c = a - b;
    }
    if (c <= 0 || c > 99999) { fail++; continue; }

    // Step 2: use c as first operand
    d = 10 + rng.nextInt(990);
    if (op2 == '+') {
      e = c + d;
    } else {
      // c - d = e, need c > d
      if (c <= 11) { fail++; continue; }
      d = 1 + rng.nextInt(c - 1);
      e = c - d;
    }
    if (e <= 0 || e > 99999) { fail++; continue; }

    // Collect all digits
    final allNums = [a, b, c, d, e];
    final allDigits = <int>{};
    for (final n in allNums) {
      for (final ch in n.toString().split('')) {
        allDigits.add(int.parse(ch));
      }
    }
    if (allDigits.length < minL || allDigits.length > maxL) { fail++; continue; }
    if (allDigits.length > 10) { fail++; continue; }

    // Map digits to letters
    final d2l = <int, String>{};
    final pool = letterPool(rng);
    int li = 0;
    for (final dig in allDigits.toList()..sort()) {
      d2l[dig] = pool[li++];
    }

    String toWord(int num) => num.toString().split('').map((ch) => d2l[int.parse(ch)]!).join();

    final wA = toWord(a);
    final wB = toWord(b);
    final wC = toWord(c);
    final wD = toWord(d);
    final wE = toWord(e);

    final sol = <String, int>{};
    for (final entry in d2l.entries) {
      sol[entry.value] = entry.key;
    }

    // Check no leading zeros
    bool bad = false;
    for (final w in [wA, wB, wC, wD, wE]) {
      if (w.length > 1 && sol[w[0]] == 0) { bad = true; break; }
    }
    if (bad) { fail++; continue; }

    final steps = [
      MStep([wA, wB], wC, op1),
      MStep([wC, wD], wE, op2),
    ];

    // Check unique solution
    if (!hasUniqueSolution(steps, sol.keys.toList(), sol)) {
      fail++;
      continue;
    }

    // Check not duplicate
    bool dup = false;
    for (final p in puzzles) {
      if (p.steps.length == steps.length &&
          p.steps[0].operands.join() == steps[0].operands.join() &&
          p.steps[1].operands.join() == steps[1].operands.join()) {
        dup = true;
        break;
      }
    }
    if (dup) { fail++; continue; }

    puzzles.add(MPuzzle(steps, sol, 3, sol.length));
    fail = 0;
  }
}

// ================================================================
// 3-STEP GENERATION: A+B=C, C+D=E, E+F=G
// ================================================================

void generate3Step(List<MPuzzle> puzzles, Random rng, int target, int minL, int maxL) {
  int fail = 0;
  while (puzzles.length < target && fail < 100000) {
    final ops = ['+', '-', '+', '+'];

    int a = 10 + rng.nextInt(90);
    int b = 10 + rng.nextInt(90);
    int c = a + b;
    int d = 10 + rng.nextInt(90);
    int e, f, g;

    final op2 = ops[rng.nextInt(ops.length)];
    if (op2 == '+') {
      e = c + d;
    } else {
      if (c <= 11) { fail++; continue; }
      d = 1 + rng.nextInt(c - 1);
      e = c - d;
    }
    if (e <= 0 || e > 9999) { fail++; continue; }

    f = 10 + rng.nextInt(90);
    final op3 = ops[rng.nextInt(ops.length)];
    if (op3 == '+') {
      g = e + f;
    } else {
      if (e <= 11) { fail++; continue; }
      f = 1 + rng.nextInt(e - 1);
      g = e - f;
    }
    if (g <= 0 || g > 99999) { fail++; continue; }

    final allNums = [a, b, c, d, e, f, g];
    final allDigits = <int>{};
    for (final n in allNums) {
      for (final ch in n.toString().split('')) {
        allDigits.add(int.parse(ch));
      }
    }
    if (allDigits.length < minL || allDigits.length > maxL) { fail++; continue; }
    if (allDigits.length > 10) { fail++; continue; }

    final d2l = <int, String>{};
    final pool = letterPool(rng);
    int li = 0;
    for (final dig in allDigits.toList()..sort()) {
      d2l[dig] = pool[li++];
    }

    String toWord(int num) => num.toString().split('').map((ch) => d2l[int.parse(ch)]!).join();

    final wA = toWord(a); final wB = toWord(b); final wC = toWord(c);
    final wD = toWord(d); final wE = toWord(e);
    final wF = toWord(f); final wG = toWord(g);

    final sol = <String, int>{};
    for (final entry in d2l.entries) { sol[entry.value] = entry.key; }

    bool bad = false;
    for (final w in [wA, wB, wC, wD, wE, wF, wG]) {
      if (w.length > 1 && sol[w[0]] == 0) { bad = true; break; }
    }
    if (bad) { fail++; continue; }

    final steps = [
      MStep([wA, wB], wC, '+'),
      MStep([wC, wD], wE, op2),
      MStep([wE, wF], wG, op3),
    ];

    if (!hasUniqueSolution(steps, sol.keys.toList(), sol)) {
      fail++;
      continue;
    }

    bool dup = false;
    for (final p in puzzles) {
      if (p.steps.length == steps.length &&
          p.steps[0].operands.join() == steps[0].operands.join()) {
        dup = true;
        break;
      }
    }
    if (dup) { fail++; continue; }

    puzzles.add(MPuzzle(steps, sol, 3, sol.length));
    fail = 0;
  }
}

// ================================================================
// SOLVER: check unique solution across all steps
// ================================================================

bool hasUniqueSolution(List<MStep> steps, List<String> letters, Map<String, int> expected) {
  final n = letters.length;
  if (n > 10) return false;

  final leading = <String>{};
  for (final step in steps) {
    for (final op in step.operands) {
      if (op.length > 1 && isLetter(op[0])) leading.add(op[0]);
    }
    if (step.result.length > 1 && isLetter(step.result[0])) {
      leading.add(step.result[0]);
    }
  }

  int count = 0;
  final asgn = List.filled(n, -1);
  final used = List.filled(10, false);

  bool checkAll() {
    final m = <String, int>{};
    for (int i = 0; i < n; i++) m[letters[i]] = asgn[i];
    for (final step in steps) {
      int w2n(String w) {
        int v = 0;
        for (final ch in w.split('')) {
          v = v * 10 + (isLetter(ch) ? m[ch]! : int.parse(ch));
        }
        return v;
      }
      final opVals = step.operands.map(w2n).toList();
      final resVal = w2n(step.result);
      bool valid;
      if (step.operator == '+') { valid = opVals.reduce((a, b) => a + b) == resVal; }
      else if (step.operator == '-') { valid = opVals.first - opVals.skip(1).reduce((a, b) => a + b) == resVal; }
      else if (step.operator == '×') { valid = opVals.reduce((a, b) => a * b) == resVal; }
      else { valid = opVals.reduce((a, b) => a + b) == resVal; }
      if (!valid) return false;
    }
    return true;
  }

  void solve(int depth) {
    if (count >= 2) return;
    if (depth == n) {
      if (checkAll()) count++;
      return;
    }
    final letter = letters[depth];
    for (int d = leading.contains(letter) ? 1 : 0; d <= 9; d++) {
      if (used[d]) continue;
      asgn[depth] = d;
      used[d] = true;
      solve(depth + 1);
      used[d] = false;
      if (count >= 2) return;
    }
  }

  solve(0);
  return count == 1;
}

List<String> letterPool(Random rng) {
  final pools = ['ABCDEFGHIJ','KLMNOPQRST','UVWXYZABCD','ACEGIKMOQS','BDFHJLNPRT','STNRLOAEIM'];
  final pool = pools[rng.nextInt(pools.length)].split('');
  pool.shuffle(rng);
  return pool;
}
