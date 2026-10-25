import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:cryptiq/core/services/daily_challenge_service.dart';
import 'package:cryptiq/data/datasources/local_database.dart';
import 'helpers/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initTestDatabase);

  final daily = DailyChallengeService.instance;
  Box box() => LocalDatabase.instance.settingsBox;
  var now = DateTime(2026, 10, 25, 10);

  /// Streak of [streak] days whose last completed day was [daysAgo] days ago.
  Future<void> played({required int streak, required int daysAgo}) async {
    await box().clear();
    final last = DateTime(now.year, now.month, now.day - daysAgo);
    await box().put('daily_streak', streak);
    await box().put('daily_last_streak_date', DailyChallengeService.dateKey(last));
  }

  setUp(() {
    now = DateTime(2026, 10, 25, 10);
    daily.clock = () => now;
  });
  tearDown(() => daily.clock = DateTime.now);

  test('missing exactly one day offers to revive the old streak', () async {
    await played(streak: 12, daysAgo: 2);
    expect(daily.streak, 0, reason: 'the streak is broken');
    expect(daily.revivableStreak, 12);
    expect(daily.shouldOfferRevive, isTrue);
  });

  test('reviving keeps the streak, and today continues it', () async {
    await played(streak: 12, daysAgo: 2);
    expect(await daily.reviveStreak(), isTrue);
    expect(daily.streak, 12);
    expect(daily.revivableStreak, 0, reason: 'nothing left to revive');

    await daily.completeDaily(60);
    expect(daily.streak, 13);
  });

  test('reviving does not mark the missed day as solved', () async {
    await played(streak: 12, daysAgo: 2);
    await daily.reviveStreak();
    expect(daily.completedDates, isNot(contains('2026-10-24')));
  });

  test('no revive when the streak is still alive or long gone', () async {
    await played(streak: 12, daysAgo: 1);
    expect(daily.revivableStreak, 0, reason: 'played yesterday: nothing broken');
    await played(streak: 12, daysAgo: 3);
    expect(daily.revivableStreak, 0, reason: 'two days missed');
  });

  test('no revive for a one-day streak', () async {
    await played(streak: 1, daysAgo: 2);
    expect(daily.revivableStreak, 0);
  });

  test("no revive once today's challenge is done (streak already restarted)", () async {
    await played(streak: 12, daysAgo: 2);
    await daily.completeDaily(60);
    expect(daily.streak, 1);
    expect(daily.revivableStreak, 0);
  });

  test('one revive per 7 days', () async {
    await played(streak: 12, daysAgo: 2);
    await daily.reviveStreak();

    // Three days later the user misses a day again: too soon.
    now = DateTime(2026, 10, 28, 10);
    await box().put('daily_last_streak_date', '2026-10-26');
    expect(daily.revivableStreak, 0);

    // Seven days after the revive it's allowed again.
    now = DateTime(2026, 11, 1, 10);
    await box().put('daily_last_streak_date', '2026-10-30');
    expect(daily.revivableStreak, 12);
  });

  test('"No thanks" hides the offer for the rest of the day only', () async {
    await played(streak: 12, daysAgo: 2);
    await daily.dismissRevive();
    expect(daily.shouldOfferRevive, isFalse);
    expect(daily.revivableStreak, 12, reason: 'still possible from elsewhere');
  });
}
