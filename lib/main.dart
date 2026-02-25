import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/services/audio_service.dart';
import 'core/services/ad_service.dart';
import 'data/datasources/local_database.dart';
import 'presentation/router/app_router.dart';
import 'presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const ProviderScope(child: CryptiqApp()));
}

class CryptiqApp extends ConsumerWidget {
  const CryptiqApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme so the entire app rebuilds when theme changes
    ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'CryptiQ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
    );
  }
}
