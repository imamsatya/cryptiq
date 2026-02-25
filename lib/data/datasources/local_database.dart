import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/user_progress.dart';
import '../../core/constants/app_constants.dart';

/// Local database using Hive for persistence
class LocalDatabase {
  LocalDatabase._();
  static final LocalDatabase instance = LocalDatabase._();

  late Box<UserProgress> _progressBox;
  late Box _settingsBox;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(UserProgressAdapter());
    
    // Open boxes
    _progressBox = await Hive.openBox<UserProgress>(AppConstants.progressBox);
    _settingsBox = await Hive.openBox(AppConstants.settingsBox);
    
    // Initialize default settings
    if (!_settingsBox.containsKey(AppConstants.soundKey)) {
      await _settingsBox.put(AppConstants.soundKey, true);
    }
    if (!_settingsBox.containsKey(AppConstants.hapticsKey)) {
      await _settingsBox.put(AppConstants.hapticsKey, true);
    }

    _isInitialized = true;
  }

  Box<UserProgress> get progressBox => _progressBox;
  Box get settingsBox => _settingsBox;

  // Progress operations
  UserProgress? getProgress(int levelNumber) {
    return _progressBox.get(levelNumber);
  }

  Future<void> saveProgress(UserProgress progress) async {
    await _progressBox.put(progress.levelNumber, progress);
  }

  List<UserProgress> getAllProgress() {
    return _progressBox.values.toList();
  }

  int getCompletedLevelsCount() {
    return _progressBox.values.where((p) => p.isCompleted).length;
  }

  int getTotalStars() {
    return _progressBox.values.fold(0, (sum, p) => sum + p.stars);
  }

  /// Get highest completed level number (for replay gap check)
  int getHighestCompletedLevel() {
    int highest = 0;
    for (final p in _progressBox.values) {
      if (p.isCompleted && p.levelNumber > highest) {
        highest = p.levelNumber;
      }
    }
    return highest;
  }

  // Settings operations
  bool getSoundEnabled() => _settingsBox.get(AppConstants.soundKey, defaultValue: true);
  bool getHapticsEnabled() => _settingsBox.get(AppConstants.hapticsKey, defaultValue: true);
  int getHintBalance() => _settingsBox.get(AppConstants.hintBalanceKey, defaultValue: 0);
  int getLastPlayedLevel() => _settingsBox.get(AppConstants.lastPlayedLevelKey, defaultValue: 0);
  bool getProStatus() => _settingsBox.get(AppConstants.proStatusKey, defaultValue: false);

  Future<void> setSoundEnabled(bool value) => _settingsBox.put(AppConstants.soundKey, value);
  Future<void> setHapticsEnabled(bool value) => _settingsBox.put(AppConstants.hapticsKey, value);
  Future<void> setLastPlayedLevel(int value) => _settingsBox.put(AppConstants.lastPlayedLevelKey, value);
  Future<void> setProStatus(bool value) => _settingsBox.put(AppConstants.proStatusKey, value);
}
