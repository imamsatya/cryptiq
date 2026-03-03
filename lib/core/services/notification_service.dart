import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import '../constants/app_constants.dart';
import '../../data/datasources/local_database.dart';
import 'daily_challenge_service.dart';

/// Manages push notifications for daily challenge reminders.
///
/// Schedules a daily notification at the configured time (default 19:00).
/// Cancels if user completes the daily challenge or disables notifications.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const _notificationId = 1;
  static const _channelId = 'daily_challenge';
  static const _channelName = 'Daily Challenge';
  static const _channelDesc = 'Reminder to complete today\'s daily challenge';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// Initialize notification plugin and timezone data.
  Future<void> initialize() async {
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

    // Schedule if enabled
    if (isEnabled) {
      await scheduleDailyReminder();
    }
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
      await scheduleDailyReminder();
    } else {
      await cancelAll();
    }
  }

  /// Schedule daily reminder notification.
  /// Shows at 19:00 local time if daily challenge not completed.
  Future<void> scheduleDailyReminder() async {
    if (!_isInitialized || kIsWeb) return;

    // Cancel existing
    await _plugin.cancel(_notificationId);

    // Don't schedule if already completed today
    if (DailyChallengeService.instance.isTodayCompleted) return;

    final now = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      AppConstants.notificationHour, // Default: 19:00
      0,
    );

    // If time already passed today, schedule for tomorrow
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    final streak = DailyChallengeService.instance.streak;
    final body = streak > 0
        ? '🔥 You have a $streak-day streak! Don\'t break it!'
        : 'A new puzzle awaits. Can you solve it?';

    await _plugin.zonedSchedule(
      _notificationId,
      '🧩 Daily Challenge Ready!',
      body,
      scheduledTime,
      NotificationDetails(
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
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
    );

    debugPrint('NotificationService: Scheduled daily reminder at ${scheduledTime.hour}:00');
  }

  /// Cancel the daily reminder (call when daily challenge completed)
  Future<void> cancelDailyReminder() async {
    if (!_isInitialized) return;
    await _plugin.cancel(_notificationId);
    debugPrint('NotificationService: Daily reminder cancelled');
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    if (!_isInitialized) return;
    await _plugin.cancelAll();
  }
}
