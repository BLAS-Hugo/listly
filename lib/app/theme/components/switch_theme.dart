import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';

SwitchThemeData buildSwitchTheme(ColorScheme colorScheme, AppPalette palette) {
  return SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return colorScheme.primary;
      }
      return palette.switchBackground;
    }),
    thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return colorScheme.onPrimary;
      }
      return colorScheme.surface;
    }),
  );
}
