import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/core/services/haptics.dart';
import 'package:cryptiq/data/datasources/local_database.dart';
import 'helpers/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final vibrations = <MethodCall>[];

  setUpAll(() async {
    await initTestDatabase();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'HapticFeedback.vibrate') vibrations.add(call);
      return null;
    });
  });
  setUp(vibrations.clear);

  Future<void> tapAll() async {
    await Haptics.lightImpact();
    await Haptics.mediumImpact();
    await Haptics.heavyImpact();
    await Haptics.selectionClick();
  }

  test('vibrates when Haptic Feedback is on', () async {
    await LocalDatabase.instance.setHapticsEnabled(true);
    await tapAll();
    expect(vibrations, hasLength(4));
  });

  test('stays silent when Haptic Feedback is off', () async {
    await LocalDatabase.instance.setHapticsEnabled(false);
    await tapAll();
    expect(vibrations, isEmpty);
  });
}
