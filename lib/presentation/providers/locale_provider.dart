import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for locale selection
final localeProvider = StateProvider<String?>((ref) => null);

/// Supported locales list
const supportedLocalesList = ['en', 'id'];
