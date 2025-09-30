import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';

ChipThemeData buildChipTheme(
  ColorScheme colorScheme,
  TextTheme textTheme,
  AppPalette palette,
) {
  return ChipThemeData(
    backgroundColor: palette.muted,
    selectedColor: colorScheme.primaryContainer,
    disabledColor: palette.muted.withValues(alpha: 0.5),
    labelStyle: textTheme.labelMedium?.copyWith(color: colorScheme.onSurface),
    secondaryLabelStyle: textTheme.labelMedium?.copyWith(
      color: colorScheme.onPrimaryContainer,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}
