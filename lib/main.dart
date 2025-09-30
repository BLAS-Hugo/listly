import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/app/theme/app_theme.dart';
import 'package:listly/features/shopping_list/presentation/views/debug_screen.dart';
import 'package:listly/firebase_options.dart';
import 'package:listly/shared/providers/database/database_provider.dart';
import 'package:listly/shared/providers/theme/theme_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    final theme = themeMode == ThemeMode.light
        ? AppTheme.light()
        : AppTheme.dark();
    return MaterialApp(home: DebugScreen(), theme: theme, themeMode: themeMode);
  }
}
