// Exports all puzzles to CSV format (easily importable to Excel/Google Sheets)
// Run with: dart run tool/export_puzzles_csv.dart

import 'dart:io';

// Parse puzzle_data.dart (simple regex-based parser)
void main() {
  final source = File('lib/levels/puzzle_data.dart').readAsStringSync();
  
  // Extract each puzzle line
  final lineRegex = RegExp(r"\[\[(.+?)\],\s*'(.+?)',\s*'(.+?)',\s*\{(.+?)\},\s*(\d+),\s*(\d+)\]");
  final matches = lineRegex.allMatches(source).toList();
  
  final diffNames = ['Easy', 'Medium', 'Hard', 'Expert'];
  
  final buf = StringBuffer();
  buf.writeln('Level,Difficulty,Operator,Operand1,Operand2,Operand3,Result,UniqueLetters,Solution');
  
  for (int i = 0; i < matches.length; i++) {
    final m = matches[i];
    final opsRaw = m.group(1)!;
    final result = m.group(2)!;
    final operator = m.group(3)!;
    final solRaw = m.group(4)!;
    final diff = int.parse(m.group(5)!);
    final uniq = m.group(6)!;
    
    // Parse operands
    final opRegex = RegExp(r"'(.+?)'");
    final ops = opRegex.allMatches(opsRaw).map((m) => m.group(1)!).toList();
    
    // Parse solution
    final solEntries = <String>[];
    final solRegex = RegExp(r"'(\w)': (\d+)");
    for (final sm in solRegex.allMatches(solRaw)) {
      solEntries.add('${sm.group(1)}=${sm.group(2)}');
    }
    
    // Format operator for display
    final opDisplay = operator == '×' ? 'x' : operator;
    
    // Build equation string for readable column
    final equation = '${ops.join(' $opDisplay ')} = $result';
    
    final op1 = ops.isNotEmpty ? ops[0] : '';
    final op2 = ops.length > 1 ? ops[1] : '';
    final op3 = ops.length > 2 ? ops[2] : '';
    
    buf.writeln('${i + 1},${diffNames[diff]},$opDisplay,$op1,$op2,$op3,$result,$uniq,"${solEntries.join(', ')}"');
  }
  
  final outputFile = File('cryptiq_puzzles.csv');
  outputFile.writeAsStringSync(buf.toString());
  print('Exported ${matches.length} puzzles to ${outputFile.path}');
  
  // Print summary
  int addCount = 0, subCount = 0, mulCount = 0;
  for (final m in matches) {
    final op = m.group(3)!;
    if (op == '+') addCount++;
    else if (op == '-') subCount++;
    else if (op == '×') mulCount++;
  }
  print('');
  print('Summary:');
  print('  Addition (+): $addCount');
  print('  Subtraction (-): $subCount');
  print('  Multiplication (×): $mulCount');
  print('  Total: ${matches.length}');
  
  // Print first × level
  for (int i = 0; i < matches.length; i++) {
    if (matches[i].group(3) == '×') {
      print('  First × puzzle: Level ${i + 1}');
      break;
    }
  }
  for (int i = 0; i < matches.length; i++) {
    if (matches[i].group(3) == '-') {
      print('  First - puzzle: Level ${i + 1}');
      break;
    }
  }
}
