import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';

CardThemeData buildCardThemeData(ColorScheme colorScheme, AppPalette palette) {
  return CardThemeData(
    color: palette.card,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      side: BorderSide(color: palette.borderSubtle),
    ),
  );
}
