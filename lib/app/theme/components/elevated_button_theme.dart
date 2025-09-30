import 'package:flutter/material.dart';

ElevatedButtonThemeData buildElevatedButtonTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      textStyle: textTheme.labelLarge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ),
  );
}
