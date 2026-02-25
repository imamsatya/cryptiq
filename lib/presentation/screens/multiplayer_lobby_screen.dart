import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

/// The lobby for Pass & Play multiplayer setup
class MultiplayerLobbyScreen extends StatefulWidget {
  const MultiplayerLobbyScreen({super.key});

  @override
  State<MultiplayerLobbyScreen> createState() => _MultiplayerLobbyScreenState();
}

class _MultiplayerLobbyScreenState extends State<MultiplayerLobbyScreen> {
  final List<TextEditingController> _nameControllers = [
    TextEditingController(text: 'Player 1'),
    TextEditingController(text: 'Player 2'),
  ];

  int _rounds = 3;
  String _difficulty = 'mixed';
  String _operation = 'mixed';

  static const _difficulties = {
    'easy': 'Easy',
    'medium': 'Medium',
    'hard': 'Hard',
    'expert': 'Expert',
    'mixed': 'Mixed',
  };

  static const _operations = {
    '+': 'Addition (+)',
    '-': 'Subtraction (−)',
    '*': 'Multiply (×)',
    'multi': 'Multi-step',
    'mixed': 'Mixed',
  };

  void _addPlayer() {
    if (_nameControllers.length < 4) {
      setState(() {
        _nameControllers
            .add(TextEditingController(text: 'Player ${_nameControllers.length + 1}'));
      });
    }
  }

  void _removePlayer(int index) {
    if (_nameControllers.length > 2) {
      setState(() {
        _nameControllers[index].dispose();
        _nameControllers.removeAt(index);
      });
    }
  }

  void _startGame() {
    final names = _nameControllers.map((c) => c.text.trim()).toList();
    // Ensure names are not empty
    for (int i = 0; i < names.length; i++) {
      if (names[i].isEmpty) {
        names[i] = 'Player ${i + 1}';
      }
    }
    context.push('/multiplayer-game', extra: {
      'names': names,
      'rounds': _rounds,
      'difficulty': _difficulty,
      'operation': _operation,
    });
  }

  @override
  void dispose() {
    for (final c in _nameControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: AppTheme.glassDecoration(borderRadius: 12),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Pass & Play',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // --- Players ---
                    _sectionTitle('Players'),
                    const SizedBox(height: 8),
                    ...List.generate(_nameControllers.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 4),
                          decoration:
                              AppTheme.glassDecoration(borderRadius: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _playerColor(i),
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _nameControllers[i],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Player name',
                                    hintStyle:
                                        TextStyle(color: AppTheme.textMuted),
                                  ),
                                ),
                              ),
                              if (_nameControllers.length > 2)
                                GestureDetector(
                                  onTap: () => _removePlayer(i),
                                  child: Icon(Icons.close_rounded,
                                      color: AppTheme.textMuted.withValues(alpha: 0.6),
                                      size: 20),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                    if (_nameControllers.length < 4)
                      GestureDetector(
                        onTap: _addPlayer,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppTheme.primaryColor.withValues(alpha: 0.3),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_rounded,
                                  color: AppTheme.primaryColor, size: 20),
                              SizedBox(width: 6),
                              Text(
                                'Add Player',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // --- Rounds ---
                    _sectionTitle('Rounds: $_rounds'),
                    SizedBox(height: 4),
                    Container(
                      decoration: AppTheme.glassDecoration(borderRadius: 14),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppTheme.primaryColor,
                          inactiveTrackColor: AppTheme.surfaceColor,
                          thumbColor: AppTheme.primaryColor,
                          overlayColor: AppTheme.primaryColor.withValues(alpha: 0.15),
                          trackHeight: 4,
                        ),
                        child: Slider(
                          value: _rounds.toDouble(),
                          min: 1,
                          max: 7,
                          divisions: 6,
                          label: '$_rounds',
                          onChanged: (v) =>
                              setState(() => _rounds = v.round()),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- Difficulty ---
                    _sectionTitle('Difficulty'),
                    const SizedBox(height: 8),
                    _buildChipRow(
                      options: _difficulties,
                      selected: _difficulty,
                      onSelect: (v) => setState(() => _difficulty = v),
                    ),
                    // Note when multistep is selected with difficulty
                    if (_operation == 'multi' &&
                        _difficulty != 'mixed' &&
                        _difficulty != 'hard' &&
                        _difficulty != 'expert')
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          'ℹ️ Multi-step puzzles are Hard/Expert only. Difficulty will be ignored.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.primaryColor.withValues(alpha: 0.7),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // --- Operation ---
                    _sectionTitle('Operation'),
                    const SizedBox(height: 8),
                    _buildChipRow(
                      options: _operations,
                      selected: _operation,
                      onSelect: (v) => setState(() => _operation = v),
                    ),

                    const SizedBox(height: 32),

                    // Start button
                    GestureDetector(
                      onTap: _startGame,
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
                            SizedBox(width: 8),
                            Text(
                              'Start Game',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppTheme.primaryColor.withValues(alpha: 0.8),
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildChipRow({
    required Map<String, String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.entries.map((e) {
        final isSelected = e.key == selected;
        return GestureDetector(
          onTap: () => onSelect(e.key),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding:
                EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? AppTheme.primaryColor.withValues(alpha: 0.15)
                  : AppTheme.surfaceColor.withValues(alpha: 0.4),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primaryColor.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.06),
              ),
            ),
            child: Text(
              e.value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
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
