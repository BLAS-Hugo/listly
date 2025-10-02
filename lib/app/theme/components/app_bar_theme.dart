import 'package:flutter/material.dart';

AppBarTheme buildAppBarTheme(ColorScheme colorScheme, TextTheme textTheme) {
  return AppBarTheme(
    backgroundColor: colorScheme.surface,
    foregroundColor: colorScheme.onSurface,
    elevation: 1,
    scrolledUnderElevation: 0,
    shadowColor: const Color.fromRGBO(0, 0, 0, 0.06),
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
    titleTextStyle: textTheme.titleLarge?.copyWith(
      color: colorScheme.onSurface,
    ),
  );
}
