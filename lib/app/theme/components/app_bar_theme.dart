import 'package:flutter/material.dart';

AppBarTheme buildAppBarTheme(ColorScheme colorScheme, TextTheme textTheme) {
  return AppBarTheme(
    backgroundColor: colorScheme.surface,
    foregroundColor: colorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: textTheme.titleLarge?.copyWith(
      color: colorScheme.onSurface,
    ),
  );
}
