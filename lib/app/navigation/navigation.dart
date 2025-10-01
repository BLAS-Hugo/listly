import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listly/app/navigation/app_shell.dart';
import 'package:listly/app/navigation/routes/list_navigation.dart';
import 'package:listly/app/navigation/routes/settings_navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _listTabNavigatorKey = GlobalKey<NavigatorState>();
final _settingsTabNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavbar(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _listTabNavigatorKey,
          routes: [
            listHome,
            // Add more list routes here
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingsTabNavigatorKey,
          routes: [
            settingsHome,
            // Add more settings routes here
          ],
        ),
      ],
    ),
  ],
);
