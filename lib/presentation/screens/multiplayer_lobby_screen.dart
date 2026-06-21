import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/datasources/local_database.dart';

/// The lobby for Pass & Play multiplayer setup
class MultiplayerLobbyScreen extends StatefulWidget {
  const MultiplayerLobbyScreen({super.key});

  @override
  State<MultiplayerLobbyScreen> createState() => _MultiplayerLobbyScreenState();
}

class _MultiplayerLobbyScreenState extends State<MultiplayerLobbyScreen> {
  final List<TextEditingController> _nameControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  int _rounds = 2;
  String _difficulty = 'mixed';
  String _operation = 'mixed';
  bool _allowHints = true;

  static const _difficultyKeys = ['easy', 'medium', 'hard', 'expert', 'mixed'];
  static const _operationKeys = ['+', '-', '*', 'multi', 'mixed'];

  @override
  void initState() {
    super.initState();
    _loadPreviousConfig();
  }

  void _loadPreviousConfig() {
    final box = LocalDatabase.instance.settingsBox;
    final isPro = LocalDatabase.instance.getProStatus();

    final savedNames = box.get('mp_names') as List<dynamic>?;
    if (savedNames != null && savedNames.isNotEmpty) {
      _nameControllers.clear();
      final maxPlayers = isPro ? 6 : 2;
      for (int i = 0; i < savedNames.length && i < maxPlayers; i++) {
        _nameControllers.add(TextEditingController(text: savedNames[i].toString()));
      }
      while (_nameControllers.length < 2) {
        _nameControllers.add(TextEditingController());
      }
    }

    _rounds = box.get('mp_rounds', defaultValue: 2);
    if (!isPro && _rounds > 2) _rounds = 2;

    _difficulty = box.get('mp_difficulty', defaultValue: 'mixed');
    _operation = box.get('mp_operation', defaultValue: 'mixed');
    _allowHints = box.get('mp_allowHints', defaultValue: true);
  }

  void _showProDialog(String message) {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Text('👑', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text('CryptiQ Pro',
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel,
                style: const TextStyle(color: AppTheme.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: AppTheme.backgroundDark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.push('/store');
            },
            child: Text(AppLocalizations.of(context)!.buyProTitle,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _addPlayer() {
    final isPro = LocalDatabase.instance.getProStatus();
    if (!isPro && _nameControllers.length >= 2) {
      _showProDialog('Main beramai-ramai lebih seru! Buka batas pemain hingga 6 orang dengan CryptiQ Pro.');
      return;
    }

    final maxPlayers = isPro ? 6 : 2;
    if (_nameControllers.length < maxPlayers) {
      setState(() {
        _nameControllers.add(TextEditingController());
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
        names[i] = AppLocalizations.of(context)!.playerName(i + 1);
      }
    }
    // Save to settings
    final box = LocalDatabase.instance.settingsBox;
    box.put('mp_names', names);
    box.put('mp_rounds', _rounds);
    box.put('mp_difficulty', _difficulty);
    box.put('mp_operation', _operation);
    box.put('mp_allowHints', _allowHints);

    context.push('/multiplayer-game', extra: {
      'names': names,
      'rounds': _rounds,
      'difficulty': _difficulty,
      'operation': _operation,
      'allowHints': _allowHints,
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
    final isPro = LocalDatabase.instance.getProStatus();
    final l10n = AppLocalizations.of(context)!;

    final difficulties = {
      'easy': l10n.easy,
      'medium': l10n.medium,
      'hard': l10n.hard,
      'expert': l10n.expert,
      'mixed': l10n.mixed,
    };
    final operations = {
      '+': l10n.addition,
      '-': l10n.subtraction,
      '*': l10n.multiply,
      'multi': l10n.multiStep,
      'mixed': l10n.mixed,
    };
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
                      onTap: () { if (context.canPop()) { context.pop(); } else { context.go('/'); } },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: AppTheme.glassDecoration(borderRadius: 12),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      l10n.passAndPlay,
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
                    _sectionTitle(l10n.players),
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
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: l10n.playerNameHint,
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
                    if (_nameControllers.length < (isPro ? 6 : 4))
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
                                l10n.addPlayer,
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              if (!isPro && _nameControllers.length >= 2) ...[
                                SizedBox(width: 6),
                                Text('👑', style: TextStyle(fontSize: 14)),
                              ],
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // --- Rounds ---
                    _sectionTitle(l10n.roundsLabel(_rounds)),
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
                          max: 10,
                          divisions: 9,
                          label: '$_rounds',
                          onChanged: (v) {
                            final val = v.round();
                            if (!isPro && val > 2) {
                              _showProDialog('Tambah keseruan! Mainkan hingga 10 ronde dengan CryptiQ Pro.');
                              setState(() => _rounds = 2);
                            } else {
                              setState(() => _rounds = val);
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- Difficulty ---
                    _sectionTitle(l10n.difficulty),
                    const SizedBox(height: 8),
                    _buildChipRow(
                      options: difficulties,
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
                          'ℹ️ ${l10n.multiStepNote}',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.primaryColor.withValues(alpha: 0.7),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // --- Operation ---
                    _sectionTitle(l10n.operation),
                    const SizedBox(height: 8),
                    _buildChipRow(
                      options: operations,
                      selected: _operation,
                      onSelect: (v) => setState(() => _operation = v),
                    ),

                    const SizedBox(height: 24),

                    // --- Allow Hints ---
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: AppTheme.glassDecoration(borderRadius: 14),
                      child: Row(
                        children: [
                          Icon(Icons.lightbulb_outline_rounded,
                              color: AppTheme.primaryColor, size: 22),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              l10n.allowHints,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          Switch(
                            value: _allowHints,
                            onChanged: (val) => setState(() => _allowHints = val),
                            activeTrackColor: AppTheme.primaryColor,
                            activeThumbColor: Colors.white,
                            inactiveTrackColor: AppTheme.surfaceColor,
                          ),
                        ],
                      ),
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
                              l10n.startGame,
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
