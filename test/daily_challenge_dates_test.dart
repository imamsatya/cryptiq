import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/core/services/daily_challenge_service.dart';

/// Run also with a daylight-saving time zone, e.g.
/// `TZ=Europe/Berlin flutter test test/daily_challenge_dates_test.dart`.
void main() {
  test('day number goes up by exactly one per calendar day, at any hour', () {
    var day = DateTime(2026, 1, 1);
    for (var i = 0; i < 365; i++) {
      for (final hour in [0, 1, 2, 3, 12, 23]) {
        final t = DateTime(day.year, day.month, day.day, hour, 30);
        // 2024-01-01 → 2026-01-01 is 731 days (2024 is a leap year)
        expect(DailyChallengeService.dayNumber(t), 731 + i, reason: '$t');
      }
      day = DateTime(day.year, day.month, day.day + 1);
    }
  });

  test('yesterday is the previous calendar date, including around DST changes', () {
    String y(DateTime t) => DailyChallengeService.yesterdayKey(t);
    expect(y(DateTime(2026, 1, 1, 0, 30)), '2025-12-31');
    expect(y(DateTime(2026, 3, 1, 0, 30)), '2026-02-28');
    expect(y(DateTime(2026, 3, 30, 0, 30)), '2026-03-29'); // after EU spring-forward
    expect(y(DateTime(2026, 10, 26, 23, 30)), '2026-10-25'); // after EU fall-back
    expect(y(DateTime(2026, 11, 2, 0, 15)), '2026-11-01'); // after US fall-back
  });

  test('matches the old formula wherever there is no DST (puzzle unchanged)', () {
    // The old seed: local difference from 2024-01-01 in whole days.
    int old(DateTime now) => now.difference(DateTime(2024, 1, 1)).inDays;
    final t0 = DateTime.utc(2026, 1, 1);
    for (var h = 0; h < 365 * 24; h += 7) {
      final utc = t0.add(Duration(hours: h));
      final wib = utc.add(const Duration(hours: 7)); // Indonesia: UTC+7, no DST
      final asLocalWallClock = DateTime(wib.year, wib.month, wib.day, wib.hour);
      if (asLocalWallClock.timeZoneOffset != DateTime(2024, 1, 1).timeZoneOffset) {
        continue; // this machine's zone has DST at this time; skip comparison
      }
      expect(DailyChallengeService.dayNumber(asLocalWallClock), old(asLocalWallClock),
          reason: '$asLocalWallClock');
    }
  });
}
