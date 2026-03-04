import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/services/audio_service.dart';
import 'core/services/ad_service.dart';
import 'core/services/iap_service.dart';
import 'core/services/notification_service.dart';
import 'data/datasources/local_database.dart';
import 'presentation/router/app_router.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/locale_provider.dart';
import 'presentation/widgets/error_screen.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Friendly error screen instead of red screen of death
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorScreen(details: details);
  };

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize database FIRST (theme reads from it)
  await LocalDatabase.instance.init();

  // Set system UI overlay style (after DB init so theme can read settings)
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppTheme.backgroundDark,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Initialize audio
  await AudioService.instance.init();

  // Initialize ads
  await AdService.instance.initialize();

  // Initialize in-app purchases
  await IapService.instance.initialize();

  // Initialize notifications
  await NotificationService.instance.initialize();

  // Catch async errors
  runZonedGuarded(() {
    runApp(const ProviderScope(child: CryptiqApp()));
  }, (error, stack) {
    debugPrint('Uncaught error: $error');
    debugPrint('$stack');
  });
}

class CryptiqApp extends ConsumerWidget {
  const CryptiqApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme and locale so the entire app rebuilds on change
    ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'CryptiQ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
