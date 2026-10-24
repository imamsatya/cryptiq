import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/core/constants/app_constants.dart';
import 'package:cryptiq/core/services/notification_service.dart';
import 'package:cryptiq/data/datasources/local_database.dart';
import 'helpers/test_database.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initTestDatabase);

  group('nextReminderTime', () {
    DateTime next(DateTime now, {bool done = false}) =>
        NotificationService.nextReminderTime(now, todayCompleted: done, hour: 19);

    test('later today when the challenge is not done yet', () {
      expect(next(DateTime(2026, 10, 24, 10)), DateTime(2026, 10, 24, 19));
    });

    test('tomorrow when 19:00 has already passed', () {
      expect(next(DateTime(2026, 10, 24, 20)), DateTime(2026, 10, 25, 19));
      expect(next(DateTime(2026, 10, 24, 19)), DateTime(2026, 10, 25, 19));
    });

    test("tomorrow when today's challenge is done, instead of no reminder", () {
      expect(next(DateTime(2026, 10, 24, 10), done: true), DateTime(2026, 10, 25, 19));
    });

    test('rolls over month and year ends', () {
      expect(next(DateTime(2026, 10, 31, 21)), DateTime(2026, 11, 1, 19));
      expect(next(DateTime(2026, 12, 31, 21)), DateTime(2027, 1, 1, 19));
    });
  });

  group('reminderStrings', () {
    tearDown(() async {
      binding.platformDispatcher.clearLocalesTestValue();
      await LocalDatabase.instance.settingsBox.put(AppConstants.localeKey, 'system');
    });

    String title() => NotificationService.instance.reminderStrings().notifTitle;

    test('uses the language chosen in Settings', () async {
      await LocalDatabase.instance.settingsBox.put(AppConstants.localeKey, 'id');
      expect(title(), '🧩 Tantangan Harian Siap!');
    });

    test('System Default uses the first translated device language', () {
      binding.platformDispatcher.localesTestValue = const [Locale('ru'), Locale('ja')];
      expect(title(), '🧩 デイリーチャレンジの準備ができました！');
    });

    test('untranslated device language falls back to English', () {
      binding.platformDispatcher.localesTestValue = const [Locale('ru', 'RU')];
      expect(title(), '🧩 Daily Challenge Ready!');
    });
  });
}
