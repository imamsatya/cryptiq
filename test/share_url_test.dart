import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/core/constants/app_constants.dart';

void main() {
  test('share link opens the app listing and carries a decodable referrer', () {
    final uri = Uri.parse(AppConstants.shareUrl('daily'));

    expect(uri.host, 'play.google.com');
    expect(uri.queryParameters['id'], 'com.cryptiq.app');
    // Play decodes `referrer` once into utm_* pairs for acquisition reports.
    expect(Uri.splitQueryString(uri.queryParameters['referrer']!), {
      'utm_source': 'share',
      'utm_medium': 'app',
      'utm_campaign': 'daily',
    });
  });

  test('each share source gets its own campaign', () {
    for (final campaign in ['daily', 'level', 'score_card', 'stats']) {
      final referrer = Uri.parse(AppConstants.shareUrl(campaign)).queryParameters['referrer']!;
      expect(Uri.splitQueryString(referrer)['utm_campaign'], campaign);
    }
  });
}
