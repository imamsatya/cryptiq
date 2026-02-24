import 'package:audioplayers/audioplayers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';

/// Audio service for game sound effects
class AudioService {
  AudioService._();
  static final AudioService instance = AudioService._();

  final AudioPlayer _player = AudioPlayer();
  bool _soundEnabled = true;

  Future<void> init() async {
    final settingsBox = Hive.box(AppConstants.settingsBox);
    _soundEnabled = settingsBox.get(AppConstants.soundKey, defaultValue: true);
  }

  bool get soundEnabled => _soundEnabled;

  Future<void> toggleSound(bool enabled) async {
    _soundEnabled = enabled;
    final settingsBox = Hive.box(AppConstants.settingsBox);
    await settingsBox.put(AppConstants.soundKey, enabled);
  }

  Future<void> playTap() async {
    if (!_soundEnabled) return;
    await _player.play(AssetSource('audio/pop.mp3'));
  }

  Future<void> playCorrect() async {
    if (!_soundEnabled) return;
    await _player.play(AssetSource('audio/success.mp3'));
  }

  Future<void> playError() async {
    if (!_soundEnabled) return;
    await _player.play(AssetSource('audio/error.mp3'));
  }

  void dispose() {
    _player.dispose();
  }
}
