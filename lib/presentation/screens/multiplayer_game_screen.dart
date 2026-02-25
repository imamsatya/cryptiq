import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/audio_service.dart';
import '../../domain/entities/puzzle.dart';
import '../../levels/puzzle_generator.dart';
import '../widgets/puzzle_display.dart';

/// Player score for one round
class PlayerRound {
  final int timeSeconds;
  final int hintsUsed;
  final bool solved;

  PlayerRound({required this.timeSeconds, required this.hintsUsed, required this.solved});

  int get score {
    if (!solved) return 0;
    // Lower time + fewer hints = higher score
    int s = max(0, 300 - timeSeconds); // base from time
    s -= hintsUsed * 30; // penalty
    return max(10, s); // minimum 10 if solved
  }
}

/// Multiplayer game screen — passes device between players
class MultiplayerGameScreen extends StatefulWidget {
  final List<String> playerNames;
  final int totalRounds;
  final String difficulty;
  final String operation;

  const MultiplayerGameScreen({
    super.key,
    required this.playerNames,
    required this.totalRounds,
    required this.difficulty,
    required this.operation,
  });

  @override
  State<MultiplayerGameScreen> createState() => _MultiplayerGameScreenState();
}

class _MultiplayerGameScreenState extends State<MultiplayerGameScreen> {
  // Game state
  int _currentRound = 0;
  int _currentPlayerIndex = 0;
  late CryptarithmPuzzle _currentPuzzle;
  late Map<String, int?> _assignments;
  String? _selectedLetter;
  int _elapsedSeconds = 0;
  int _hintsUsed = 0;
  Timer? _timer;
  bool _showHandoff = true; // show handoff screen between turns
  bool _showSuccess = false; // show success overlay
  bool _isChecking = false;

  // Results: [round][player] = score
  late List<List<PlayerRound?>> _results;

  // Puzzles per round (same puzzle for all players in a round)
  late List<CryptarithmPuzzle> _puzzles;

  @override
  void initState() {
    super.initState();
    _results = List.generate(widget.totalRounds,
        (_) => List.filled(widget.playerNames.length, null));
    _puzzles = _generatePuzzles();
    _currentPuzzle = _puzzles[0];
    _resetAssignments();
  }

  List<CryptarithmPuzzle> _generatePuzzles() {
    final all = PuzzleGenerator.allPuzzles;
    final rng = Random();

    // Filter by settings
    var candidates = all.where((p) {
      // Operation filter first (multistep ignores difficulty)
      if (widget.operation == 'multi') {
        // Only multistep puzzles, ignore difficulty
        return p.steps.isNotEmpty;
      }
      // Difficulty filter
      if (widget.difficulty != 'mixed') {
        final d = widget.difficulty;
        if (d == 'easy' && p.difficulty != DifficultyLevel.easy) return false;
        if (d == 'medium' && p.difficulty != DifficultyLevel.medium) return false;
        if (d == 'hard' && p.difficulty != DifficultyLevel.hard) return false;
        if (d == 'expert' && p.difficulty != DifficultyLevel.expert) return false;
      }
      // Single-step operation filter
      if (widget.operation != 'mixed') {
        if (p.steps.isNotEmpty) return false;
        if (p.operator != widget.operation) return false;
      }
      return true;
    }).toList();

    if (candidates.length < widget.totalRounds) {
      candidates = all; // fallback
    }

    candidates.shuffle(rng);
    return candidates.take(widget.totalRounds).toList();
  }

  void _resetAssignments() {
    _assignments = {};
    for (final letter in _currentPuzzle.solution.keys) {
      _assignments[letter] = null;
    }
    _selectedLetter = null;
    _elapsedSeconds = 0;
    _hintsUsed = 0;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _elapsedSeconds++);
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _beginTurn() {
    setState(() {
      _showHandoff = false;
      _resetAssignments();
    });
    _startTimer();
  }

  void _selectLetter(String letter) {
    setState(() => _selectedLetter = letter);
  }

  void _assignDigit(int digit) {
    if (_selectedLetter == null) return;

    // Check if digit already used by another letter
    final existing = _assignments.entries
        .where((e) => e.value == digit && e.key != _selectedLetter)
        .firstOrNull;
    if (existing != null) {
      // Clear the other assignment
      _assignments[existing.key] = null;
    }

    setState(() {
      _assignments[_selectedLetter!] = digit;
      // Auto-advance to next empty letter
      final letters = _currentPuzzle.solution.keys;
      final nextEmpty = letters
          .where((l) => l != _selectedLetter && _assignments[l] == null)
          .firstOrNull;
      _selectedLetter = nextEmpty;
    });
  }

  void _useHint() {
    final unassigned = _currentPuzzle.solution.keys
        .where((l) => _assignments[l] == null)
        .toList();
    if (unassigned.isEmpty) return;

    final rng = Random();
    final letter = unassigned[rng.nextInt(unassigned.length)];
    setState(() {
      _assignments[letter] = _currentPuzzle.solution[letter];
      _hintsUsed++;
    });
  }

  Future<void> _checkSolution() async {
    if (_isChecking) return;
    _isChecking = true;

    // Check if all letters assigned
    final allFilled = _assignments.values.every((v) => v != null);
    if (!allFilled) {
      _isChecking = false;
      return;
    }

    // Verify solution
    bool correct = true;
    for (final entry in _currentPuzzle.solution.entries) {
      if (_assignments[entry.key] != entry.value) {
        correct = false;
        break;
      }
    }

    if (correct) {
      AudioService.instance.playCorrect();
      HapticFeedback.heavyImpact();
      _stopTimer();

      _results[_currentRound][_currentPlayerIndex] = PlayerRound(
        timeSeconds: _elapsedSeconds,
        hintsUsed: _hintsUsed,
        solved: true,
      );

      // Show success overlay briefly
      setState(() => _showSuccess = true);
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      setState(() => _showSuccess = false);
      await _advanceTurn();
    } else {
      AudioService.instance.playError();
      HapticFeedback.heavyImpact();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('❌ Incorrect — try again!',
                style: TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFFE53935),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
    _isChecking = false;
  }

  void _giveUp() {
    _stopTimer();
    _results[_currentRound][_currentPlayerIndex] = PlayerRound(
      timeSeconds: _elapsedSeconds,
      hintsUsed: _hintsUsed,
      solved: false,
    );
    _advanceTurn();
  }

  Future<void> _advanceTurn() async {
    final nextPlayer = _currentPlayerIndex + 1;

    if (nextPlayer < widget.playerNames.length) {
      // Next player, same round
      setState(() {
        _currentPlayerIndex = nextPlayer;
        _showHandoff = true;
        _resetAssignments();
      });
    } else {
      // All players done this round
      final nextRound = _currentRound + 1;
      if (nextRound < widget.totalRounds) {
        // Next round
        setState(() {
          _currentRound = nextRound;
          _currentPlayerIndex = 0;
          _currentPuzzle = _puzzles[nextRound];
          _showHandoff = true;
          _resetAssignments();
        });
      } else {
        // Game over — go to results
        if (mounted) {
          context.go('/multiplayer-result', extra: {
            'names': widget.playerNames,
            'results': _results,
            'rounds': widget.totalRounds,
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showHandoff) {
      return _buildHandoffScreen();
    }
    return Stack(
      children: [
        _buildGameScreen(),
        if (_showSuccess) _buildSuccessOverlay(),
      ],
    );
  }

  Widget _buildSuccessOverlay() {
    final playerName = widget.playerNames[_currentPlayerIndex];
    final result = _results[_currentRound][_currentPlayerIndex];
    final score = result?.score ?? 0;

    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.7),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.surfaceLight,
                  AppTheme.surfaceColor,
                ],
              ),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('✅', style: TextStyle(fontSize: 48)),
                SizedBox(height: 12),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.goldGradient.createShader(bounds),
                  child: const Text(
                    'Correct!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$playerName scored $score pts',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatTime(_elapsedSeconds)} • $_hintsUsed hints',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandoffScreen() {
    final playerName = widget.playerNames[_currentPlayerIndex];
    final playerColor = _playerColor(_currentPlayerIndex);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Round indicator
                  Text(
                    'Round ${_currentRound + 1} of ${widget.totalRounds}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Player avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: playerColor.withValues(alpha: 0.2),
                      border: Border.all(color: playerColor, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        playerName.isNotEmpty
                            ? playerName[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: playerColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Player name
                  Text(
                    playerName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pass the device to this player',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Ready button
                  GestureDetector(
                    onTap: _beginTurn,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration:
                          AppTheme.goldGlowDecoration(borderRadius: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow_rounded,
                              color: AppTheme.backgroundDark, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            "I'm Ready!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.backgroundDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameScreen() {
    final playerName = widget.playerNames[_currentPlayerIndex];
    final playerColor = _playerColor(_currentPlayerIndex);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    // Player badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: playerColor.withValues(alpha: 0.2),
                        border: Border.all(color: playerColor.withValues(alpha: 0.5)),
                      ),
                      child: Text(
                        playerName,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: playerColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Round
                    Text(
                      'R${_currentRound + 1}/${widget.totalRounds}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Timer
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: AppTheme.glassDecoration(borderRadius: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.timer_outlined,
                              color: AppTheme.textSecondary, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(_elapsedSeconds),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Puzzle display
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      PuzzleDisplay(
                        puzzle: _currentPuzzle,
                        assignments: _assignments,
                        selectedLetter: _selectedLetter,
                        onLetterTap: _selectLetter,
                        wrongLetters: const {},
                        correctLetters: const {},
                        hintedLetters: const {},
                      ),
                    ],
                  ),
                ),
              ),

              // Number pad + actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Number pad
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: List.generate(10, (i) {
                        final usedByOther = _assignments.values.contains(i);
                        return GestureDetector(
                          onTap: _selectedLetter != null
                              ? () => _assignDigit(i)
                              : null,
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: usedByOther
                                  ? AppTheme.surfaceColor.withValues(alpha: 0.3)
                                  : AppTheme.surfaceColor,
                              border: Border.all(
                                color: usedByOther
                                    ? Colors.white.withValues(alpha: 0.05)
                                    : AppTheme.primaryColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$i',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: usedByOther
                                      ? AppTheme.textMuted
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),

                    // Action buttons
                    Row(
                      children: [
                        // Give up
                        GestureDetector(
                          onTap: _giveUp,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 14),
                            decoration:
                                AppTheme.glassDecoration(borderRadius: 12),
                            child: const Text('Give Up',
                                style: TextStyle(
                                    color: AppTheme.textMuted, fontSize: 13)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Hint
                        GestureDetector(
                          onTap: _useHint,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 14),
                            decoration:
                                AppTheme.glassDecoration(borderRadius: 12),
                            child: Row(
                              children: [
                                Icon(Icons.lightbulb_outline,
                                    color: AppTheme.primaryColor, size: 18),
                                const SizedBox(width: 4),
                                Text('Hint ($_hintsUsed)',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Check
                        Expanded(
                          child: GestureDetector(
                            onTap: _checkSolution,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              decoration: AppTheme.goldGlowDecoration(
                                  borderRadius: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_rounded,
                                      color: AppTheme.backgroundDark,
                                      size: 18),
                                  SizedBox(width: 4),
                                  Text('Check',
                                      style: TextStyle(
                                        color: AppTheme.backgroundDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  static Color _playerColor(int index) {
    const colors = [
      Color(0xFF4CAF50),
      Color(0xFF2196F3),
      Color(0xFFFF9800),
      Color(0xFFE91E63),
    ];
    return colors[index % colors.length];
  }
}
