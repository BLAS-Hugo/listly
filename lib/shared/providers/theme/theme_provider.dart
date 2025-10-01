import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/app/theme/app_theme.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.light; // Default to light mode.

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

class CurrentThemeNotifier extends Notifier<ThemeData> {
  @override
  ThemeData build() => AppTheme.light();

  void toggleTheme() {
    if (state == AppTheme.light()) {
      state = AppTheme.dark();
    } else {
      state = AppTheme.light();
    }
  }
}

final currentThemeNotifierProvider =
    NotifierProvider<CurrentThemeNotifier, ThemeData>(CurrentThemeNotifier.new);
