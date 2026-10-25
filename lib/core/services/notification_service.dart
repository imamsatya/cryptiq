import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import '../constants/app_constants.dart';
import '../../data/datasources/local_database.dart';
import '../../l10n/app_localizations.dart';
import 'daily_challenge_service.dart';

/// Manages push notifications for daily challenge reminders.
///
/// Reminds at the configured hour (default 19:00 local time) on days the
/// daily challenge isn't done yet. Rescheduled on app start, when the
/// challenge is completed and when the app language changes.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const _reminderId = 1; // next reminder, may mention the streak
  static const _repeatingReminderId = 2; // daily from the day after, generic
  static const _channelId = 'daily_challenge';
  static const _channelName = 'Daily Challenge';
  static const _channelDesc = 'Reminder to complete today\'s daily challenge';
  static const _permissionAskedKey = 'notification_permission_asked';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  Future<void>? _initialization;

  /// Initialize notification plugin and timezone data. Safe to call again:
  /// later calls wait for the first one.
  Future<void> initialize() => _initialization ??= _initialize();

  Future<void> _initialize() async {
    if (kIsWeb) return; // No notifications on web

    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );

    _isInitialized = true;
    debugPrint('NotificationService: Initialized');

    await scheduleDailyReminder();
  }

  /// Whether notifications are enabled in settings
  bool get isEnabled {
    return LocalDatabase.instance.settingsBox
        .get(AppConstants.notificationKey, defaultValue: true);
  }

  /// Toggle notifications on/off
  Future<void> setEnabled(bool enabled) async {
    await LocalDatabase.instance.settingsBox
        .put(AppConstants.notificationKey, enabled);
    if (enabled) {
      await _requestPermission();
      await scheduleDailyReminder();
    } else {
      await cancelAll();
    }
  }

  /// Asks once for the Android 13+ notification permission; without it the
  /// reminder is silently blocked. Re-enabling in Settings asks again.
  Future<void> requestPermissionOnce() async {
    await initialize();
    if (!_isInitialized || !isEnabled) return;
    final box = LocalDatabase.instance.settingsBox;
    if (box.get(_permissionAskedKey, defaultValue: false) as bool) return;
    await box.put(_permissionAskedKey, true);
    await _requestPermission();
  }

  Future<void> _requestPermission() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  /// Today at [hour] if today's challenge isn't done and that time is still
  /// ahead, otherwise tomorrow at [hour] (local time).
  @visibleForTesting
  static DateTime nextReminderTime(
    DateTime now, {
    required bool todayCompleted,
    int hour = AppConstants.notificationHour,
  }) {
    final today = DateTime(now.year, now.month, now.day, hour);
    if (!todayCompleted && today.isAfter(now)) return today;
    return DateTime(now.year, now.month, now.day + 1, hour);
  }

  /// Strings in the app's language: the one chosen in Settings, else the
  /// first translated device language, else English — like the app itself.
  @visibleForTesting
  AppLocalizations reminderStrings() {
    final saved = LocalDatabase.instance.settingsBox
        .get(AppConstants.localeKey, defaultValue: 'system') as String;
    final preferred = saved == 'system'
        ? WidgetsBinding.instance.platformDispatcher.locales
        : [Locale(saved)];
    for (final locale in preferred) {
      for (final supported in AppLocalizations.supportedLocales) {
        if (supported.languageCode == locale.languageCode) {
          return lookupAppLocalizations(supported);
        }
      }
    }
    return lookupAppLocalizations(const Locale('en'));
  }

  /// Schedule the reminders: the next one (today or tomorrow), then a daily
  /// repeat from the day after in case the app isn't opened in between.
  Future<void> scheduleDailyReminder() async {
    if (!_isInitialized || kIsWeb || !isEnabled) return;

    await cancelDailyReminder();

    final daily = DailyChallengeService.instance;
    final now = DateTime.now();
    final next = nextReminderTime(now, todayCompleted: daily.isTodayCompleted);
    final dayAfter = DateTime(next.year, next.month, next.day + 1, next.hour);
    // The streak is still alive at `next` only if today's challenge is done
    // or `next` is today; otherwise it will have broken by then.
    final nextIsToday = next.isBefore(DateTime(now.year, now.month, now.day + 1));
    final streak = (daily.isTodayCompleted || nextIsToday) ? daily.streak : 0;

    final strings = reminderStrings();
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: const BigTextStyleInformation(''),
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    // tz.local is never set (it defaults to UTC), so schedule the local
    // wall-clock time as an absolute UTC time. After a DST change the repeat
    // drifts by an hour until the app next reschedules it.
    //
    // Both calls are wrapped: the plugin's own scheduled-notifications cache
    // round-trip (Gson TypeToken) can throw "Missing type parameter" on some
    // Android versions, and one failing must not stop the other from trying.
    final scheduledNext = await _scheduleQuietly(() => _plugin.zonedSchedule(
          _reminderId,
          strings.notifTitle,
          streak > 0 ? strings.notifBodyStreak(streak) : strings.notifBodyDefault,
          tz.TZDateTime.from(next, tz.UTC),
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        ));
    final scheduledRepeat = await _scheduleQuietly(() => _plugin.zonedSchedule(
          _repeatingReminderId,
          strings.notifTitle,
          strings.notifBodyDefault,
          tz.TZDateTime.from(dayAfter, tz.UTC),
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
        ));

    if (scheduledNext && scheduledRepeat) {
      debugPrint('NotificationService: Next reminder at $next');
    } else {
      debugPrint('NotificationService: reminder scheduling failed on this '
          'device (plugin error) — no reminder will fire');
    }
  }

  Future<bool> _scheduleQuietly(Future<void> Function() schedule) async {
    try {
      await schedule();
      return true;
    } catch (e) {
      debugPrint('NotificationService: zonedSchedule failed, ignoring: $e');
      return false;
    }
  }

  /// Cancel the scheduled reminders
  Future<void> cancelDailyReminder() async {
    if (!_isInitialized) return;
    // The plugin can throw "Missing type parameter" when cancelling an id
    // that was never scheduled (e.g. right after a fresh install) — a known
    // flutter_local_notifications quirk. Don't let it block scheduling below.
    await _cancelQuietly(_reminderId);
    await _cancelQuietly(_repeatingReminderId);
  }

  Future<void> _cancelQuietly(int id) async {
    try {
      await _plugin.cancel(id);
    } catch (e) {
      debugPrint('NotificationService: cancel($id) failed, ignoring: $e');
    }
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    if (!_isInitialized) return;
    await _plugin.cancelAll();
  }
}
