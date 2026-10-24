import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptiq/data/datasources/local_database.dart';

/// Opens the app's Hive boxes in a temp directory. Call once per test file,
/// from setUpAll, after TestWidgetsFlutterBinding.ensureInitialized().
Future<void> initTestDatabase() async {
  final dir = await Directory.systemTemp.createTemp('cryptiq_test');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/path_provider'),
    (call) async => dir.path,
  );
  await LocalDatabase.instance.init();
}
