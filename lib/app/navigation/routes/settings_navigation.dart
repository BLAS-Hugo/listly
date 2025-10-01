import 'package:go_router/go_router.dart';
import 'package:listly/features/shopping_list/presentation/views/debug_screen.dart';

/// Settings tab routes
final settingsHome = GoRoute(
  path: '/settings',
  name: 'settings-home',
  builder: (context, state) => const DebugScreen(title: 'Paramètres'),
);

// Add more settings routes here as you develop
// Example:
// final settingsProfile = GoRoute(
//   path: '/settings/profile',
//   name: 'settings-profile',
//   builder: (context, state) => ProfileSettingsScreen(),
// );
//
// final settingsNotifications = GoRoute(
//   path: '/settings/notifications',
//   name: 'settings-notifications',
//   builder: (context, state) => NotificationSettingsScreen(),
// );
