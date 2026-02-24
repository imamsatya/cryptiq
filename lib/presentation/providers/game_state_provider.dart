import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/puzzle.dart';
import '../../levels/puzzle_generator.dart';
import '../../data/repositories/progress_repository.dart';
import '../../core/constants/app_constants.dart';
import '../../data/datasources/local_database.dart';

/// Game state for a single puzzle session
class GameState {
  final CryptarithmPuzzle puzzle;
  final Map<String, int?> assignments;  // letter -> assigned digit (null if unassigned)
  final String? selectedLetter;          // currently selected letter
  final Set<int> usedDigits;            // digits already assigned
  final int hintsUsed;
  final int elapsedSeconds;
  final bool isComplete;
  final bool isChecking;
  final Set<String> wrongLetters;       // letters with wrong assignments (after check)
  final Set<String> correctLetters;     // letters confirmed correct
  final Set<String> hintedLetters;      // letters revealed by hints

  const GameState({
    required this.puzzle,
    this.assignments = const {},
    this.selectedLetter,
    this.usedDigits = const {},
    this.hintsUsed = 0,
    this.elapsedSeconds = 0,
    this.isComplete = false,
    this.isChecking = false,
    this.wrongLetters = const {},
    this.correctLetters = const {},
    this.hintedLetters = const {},
  });

  GameState copyWith({
    CryptarithmPuzzle? puzzle,
    Map<String, int?>? assignments,
    String? selectedLetter,
    bool clearSelectedLetter = false,
    Set<int>? usedDigits,
    int? hintsUsed,
    int? elapsedSeconds,
    bool? isComplete,
    bool? isChecking,
    Set<String>? wrongLetters,
    Set<String>? correctLetters,
    Set<String>? hintedLetters,
  }) {
    return GameState(
      puzzle: puzzle ?? this.puzzle,
      assignments: assignments ?? this.assignments,
      selectedLetter: clearSelectedLetter ? null : (selectedLetter ?? this.selectedLetter),
      usedDigits: usedDigits ?? this.usedDigits,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isComplete: isComplete ?? this.isComplete,
      isChecking: isChecking ?? this.isChecking,
      wrongLetters: wrongLetters ?? this.wrongLetters,
      correctLetters: correctLetters ?? this.correctLetters,
      hintedLetters: hintedLetters ?? this.hintedLetters,
    );
  }

  /// Calculate stars based on hints and time
  int calculateStars() {
    if (hintsUsed <= AppConstants.threeStarMaxHints) return 3;
    if (hintsUsed <= AppConstants.twoStarMaxHints) return 2;
    return 1;
  }
}

/// Game state notifier
class GameStateNotifier extends StateNotifier<GameState> {
  final ProgressRepository _progressRepo;
  Timer? _timer;

  GameStateNotifier(CryptarithmPuzzle puzzle, this._progressRepo)
      : super(GameState(
          puzzle: puzzle,
          assignments: {for (final l in puzzle.allLetters) l: null},
        )) {
    // Defer timer start to avoid setState during initial build
    Future.microtask(() => _startTimer());
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!state.isComplete && mounted) {
        state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
      }
    });
  }

  /// Select a letter tile
  void selectLetter(String letter) {
    if (state.isComplete) return;
    if (state.hintedLetters.contains(letter)) return; // Can't change hinted letters
    
    state = state.copyWith(
      selectedLetter: state.selectedLetter == letter ? null : letter,
      wrongLetters: {}, // Clear wrong markers on new selection
      isChecking: false,
    );
  }

  /// Assign a digit to the selected letter
  void assignDigit(int digit) {
    if (state.isComplete || state.selectedLetter == null) return;

    final letter = state.selectedLetter!;
    if (state.hintedLetters.contains(letter)) return;

    final newAssignments = Map<String, int?>.from(state.assignments);
    final newUsedDigits = Set<int>.from(state.usedDigits);

    // Remove old assignment if exists
    final oldDigit = newAssignments[letter];
    if (oldDigit != null) {
      newUsedDigits.remove(oldDigit);
    }

    // Remove digit from any other letter that had it
    for (final entry in newAssignments.entries) {
      if (entry.value == digit && entry.key != letter) {
        newAssignments[entry.key] = null;
        break;
      }
    }

    // Assign new digit
    newAssignments[letter] = digit;
    newUsedDigits.add(digit);

    state = state.copyWith(
      assignments: newAssignments,
      usedDigits: newUsedDigits,
      clearSelectedLetter: true,
      wrongLetters: {},
      isChecking: false,
    );
  }

  /// Remove assignment from selected letter
  void clearLetter(String letter) {
    if (state.isComplete) return;
    if (state.hintedLetters.contains(letter)) return;

    final newAssignments = Map<String, int?>.from(state.assignments);
    final newUsedDigits = Set<int>.from(state.usedDigits);

    final digit = newAssignments[letter];
    if (digit != null) {
      newUsedDigits.remove(digit);
      newAssignments[letter] = null;
    }

    state = state.copyWith(
      assignments: newAssignments,
      usedDigits: newUsedDigits,
      wrongLetters: {},
    );
  }

  /// Clear all assignments (except hinted). Works even when game is complete.
  void clearAll() {
    final newAssignments = Map<String, int?>.from(state.assignments);
    final newUsedDigits = <int>{};

    for (final letter in newAssignments.keys) {
      if (!state.hintedLetters.contains(letter)) {
        newAssignments[letter] = null;
      } else {
        final digit = newAssignments[letter];
        if (digit != null) newUsedDigits.add(digit);
      }
    }

    state = state.copyWith(
      assignments: newAssignments,
      usedDigits: newUsedDigits,
      clearSelectedLetter: true,
      wrongLetters: {},
      correctLetters: state.hintedLetters,
      isComplete: false,
      isChecking: false,
    );

    // Restart timer if it was stopped
    _startTimer();
  }

  /// Full reset: clears everything including hints
  void resetGame() {
    _timer?.cancel();
    state = GameState(
      puzzle: state.puzzle,
      assignments: {for (final l in state.puzzle.allLetters) l: null},
    );
    Future.microtask(() => _startTimer());
  }

  /// Check current solution
  Future<bool> checkSolution() async {
    // Verify all letters are assigned
    final unassigned = state.assignments.entries.where((e) => e.value == null).map((e) => e.key).toList();
    if (unassigned.isNotEmpty) {
      return false;
    }

    // Build non-null assignment map
    final assignment = <String, int>{};
    for (final entry in state.assignments.entries) {
      assignment[entry.key] = entry.value!;
    }

    // Check against solution
    if (state.puzzle.verifySolution(assignment)) {
      _timer?.cancel();
      
      // Save progress
      final stars = state.calculateStars();
      await _progressRepo.completeLevel(
        levelNumber: state.puzzle.levelNumber,
        timeSeconds: state.elapsedSeconds,
        hintsUsed: state.hintsUsed,
        stars: stars,
      );

      state = state.copyWith(
        isComplete: true,
        correctLetters: assignment.keys.toSet(),
        wrongLetters: {},
      );
      return true;
    }

    // Solution is incorrect — mark all non-hinted letters as wrong
    // (since puzzles may have multiple solutions, we can't tell which specific letters are right)
    final wrong = assignment.keys.where((l) => !state.hintedLetters.contains(l)).toSet();

    state = state.copyWith(
      wrongLetters: wrong,
      correctLetters: state.hintedLetters,
      isChecking: true,
    );
    return false;
  }

  /// Use a hint - reveals one correct letter
  bool useHint() {
    if (state.isComplete) return false;

    final db = LocalDatabase.instance;
    final balance = db.getHintBalance();
    if (balance <= 0) return false;

    // Find an unassigned or wrongly assigned letter
    String? targetLetter;
    
    // Priority 1: wrongly assigned letters
    for (final letter in state.wrongLetters) {
      if (!state.hintedLetters.contains(letter)) {
        targetLetter = letter;
        break;
      }
    }

    // Priority 2: unassigned letters
    if (targetLetter == null) {
      for (final entry in state.assignments.entries) {
        if (entry.value == null && !state.hintedLetters.contains(entry.key)) {
          targetLetter = entry.key;
          break;
        }
      }
    }

    // Priority 3: any non-hinted letter that's wrong
    if (targetLetter == null) {
      for (final entry in state.assignments.entries) {
        if (!state.hintedLetters.contains(entry.key) &&
            entry.value != state.puzzle.solution[entry.key]) {
          targetLetter = entry.key;
          break;
        }
      }
    }

    if (targetLetter == null) return false; // All already correct

    final correctDigit = state.puzzle.solution[targetLetter]!;

    // Remove the digit from any other letter
    final newAssignments = Map<String, int?>.from(state.assignments);
    final newUsedDigits = Set<int>.from(state.usedDigits);

    for (final entry in newAssignments.entries) {
      if (entry.value == correctDigit && entry.key != targetLetter) {
        newAssignments[entry.key] = null;
        newUsedDigits.remove(correctDigit);
        break;
      }
    }

    // Remove old digit of target letter
    final oldDigit = newAssignments[targetLetter];
    if (oldDigit != null) {
      newUsedDigits.remove(oldDigit);
    }

    // Assign correct digit
    newAssignments[targetLetter] = correctDigit;
    newUsedDigits.add(correctDigit);

    // Deduct hint
    db.setHintBalance(balance - 1);

    state = state.copyWith(
      assignments: newAssignments,
      usedDigits: newUsedDigits,
      hintsUsed: state.hintsUsed + 1,
      hintedLetters: {...state.hintedLetters, targetLetter},
      correctLetters: {...state.correctLetters, targetLetter},
      wrongLetters: state.wrongLetters.difference({targetLetter}),
      clearSelectedLetter: true,
    );

    return true;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Provider family for game state per level
final gameStateProvider = StateNotifierProvider.autoDispose
    .family<GameStateNotifier, GameState, int>(
  (ref, levelNumber) {
    final puzzle = PuzzleGenerator.getPuzzle(levelNumber);
    final repo = ProgressRepository();
    return GameStateNotifier(puzzle, repo);
  },
);

/// Provider for hint balance
final hintBalanceProvider = StateProvider<int>((ref) {
  return LocalDatabase.instance.getHintBalance();
});
