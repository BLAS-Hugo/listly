import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';

InputDecorationTheme buildInputDecorationTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
  AppPalette palette,
) {
  return InputDecorationTheme(
    filled: true,
    fillColor: palette.inputBackground,
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: palette.borderSubtle),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: palette.borderSubtle),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: palette.ring, width: 1.5),
    ),
    labelStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant,
    ),
    hintStyle: textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
    ),
  );
}
