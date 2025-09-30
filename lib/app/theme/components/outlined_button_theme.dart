import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';

OutlinedButtonThemeData buildOutlinedButtonTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
  AppPalette palette,
) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colorScheme.primary,
      textStyle: textTheme.labelLarge,
      side: BorderSide(color: palette.border),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ),
  );
}
