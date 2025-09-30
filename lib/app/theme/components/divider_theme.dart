import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';

DividerThemeData buildDividerTheme(AppPalette palette) {
  return DividerThemeData(color: palette.borderSubtle, thickness: 1, space: 1);
}
