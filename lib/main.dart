import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/app/theme/app_theme.dart';
import 'package:listly/firebase_options.dart';
import 'package:listly/shared/localization/localization.dart';
import 'package:listly/shared/providers/database/database_provider.dart';
import 'package:listly/shared/providers/navigation/navigation_provider.dart';
import 'package:listly/shared/providers/theme/theme_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Sembast database
  final appDocumentDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDocumentDir.path, 'local_storage.db');
  final database = await databaseFactoryIo.openDatabase(dbPath);

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    appLocalization.init(
      mapLocales: [
        const MapLocale('en', US.en_US),
        const MapLocale('fr', FR.fr_FR),
      ],
      initLanguageCode:
          WidgetsBinding.instance.platformDispatcher.locale.languageCode,
    );
    appLocalization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  @override
  void dispose() {
    appLocalization.onTranslatedLanguage = null;
    super.dispose();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final router = ref.watch(routerProvider);

    final theme = themeMode == ThemeMode.light
        ? AppTheme.light()
        : AppTheme.dark();
    return MaterialApp.router(
      supportedLocales: appLocalization.supportedLocales,
      localizationsDelegates: appLocalization.localizationsDelegates,
      routerConfig: router,
      theme: theme,
      themeMode: themeMode,
    );
  }
}
