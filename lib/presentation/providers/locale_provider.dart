import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/notification_service.dart';
import '../../data/datasources/local_database.dart';
import '../../l10n/app_localizations.dart';

/// Supported locales with English first. When the device language has no
/// translation (e.g. Russian), Flutter falls back to the first supported
/// locale — and the generated list is alphabetical, which would be Arabic.
final appSupportedLocales = <Locale>[
  const Locale('en'),
  ...AppLocalizations.supportedLocales.where((l) => l.languageCode != 'en'),
];

/// Language options with display names and flags
class LanguageOption {
  final String code;
  final String name;
  final String flag;
  const LanguageOption(this.code, this.name, this.flag);
}

const supportedLanguages = [
  LanguageOption('system', 'System Default', '📱'),
  LanguageOption('en', 'English', '🇺🇸'),
  LanguageOption('es', 'Español', '🇪🇸'),
  LanguageOption('pt', 'Português', '🇧🇷'),
  LanguageOption('de', 'Deutsch', '🇩🇪'),
  LanguageOption('fr', 'Français', '🇫🇷'),
  LanguageOption('ja', '日本語', '🇯🇵'),
  LanguageOption('ko', '한국어', '🇰🇷'),
  LanguageOption('id', 'Bahasa Indonesia', '🇮🇩'),
  LanguageOption('zh', '简体中文', '🌐'),
  LanguageOption('hi', 'हिन्दी', '🌐'),
  LanguageOption('ar', 'العربية', '🌐'),
];

/// Manages the locale selection with Hive persistence
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale?> {
  static const _localeKey = 'selected_locale';

  LocaleNotifier() : super(null) {
    _load();
  }

  void _load() {
    final db = LocalDatabase.instance;
    if (!db.isInitialized) return;
    final code = db.settingsBox.get(_localeKey) as String?;
    if (code != null && code != 'system') {
      state = Locale(code);
    }
  }

  Future<void> setLocale(String code) async {
    final db = LocalDatabase.instance;
    await db.settingsBox.put(_localeKey, code);
    state = code == 'system' ? null : Locale(code);
    NotificationService.instance.scheduleDailyReminder(); // text follows the language
  }

  String get selectedCode {
    final db = LocalDatabase.instance;
    if (!db.isInitialized) return 'system';
    return db.settingsBox.get(_localeKey, defaultValue: 'system') as String;
  }
}
