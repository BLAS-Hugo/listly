import 'package:flutter/material.dart';

TextTheme buildTextTheme({
  required Brightness brightness,
  required ColorScheme colorScheme,
}) {
  final isDark = brightness == Brightness.dark;
  final onSurface = isDark ? colorScheme.onSurface : colorScheme.onSurface;
  final onSurfaceVariant = colorScheme.onSurfaceVariant;

  const baseDisplayWeight = FontWeight.w400;
  const baseHeadlineWeight = FontWeight.w600;
  const baseTitleLargeWeight = FontWeight.w600;
  const baseTitleMediumWeight = FontWeight.w600;
  const baseTitleSmallWeight = FontWeight.w500;
  const baseBodyWeight = FontWeight.w400;
  const baseLabelLargeWeight = FontWeight.w500;
  const baseLabelMediumWeight = FontWeight.w500;
  const baseLabelSmallWeight = FontWeight.w500;

  return TextTheme(
    displayLarge: _displayLarge.copyWith(
      color: onSurface,
      fontWeight: baseDisplayWeight,
    ),
    displayMedium: _displayMedium.copyWith(
      color: onSurface,
      fontWeight: baseDisplayWeight,
    ),
    displaySmall: _displaySmall.copyWith(
      color: onSurface,
      fontWeight: baseDisplayWeight,
    ),
    headlineLarge: _headlineLarge.copyWith(
      color: onSurface,
      fontWeight: baseHeadlineWeight,
    ),
    headlineMedium: _headlineMedium.copyWith(
      color: onSurface,
      fontWeight: baseHeadlineWeight,
    ),
    headlineSmall: _headlineSmall.copyWith(
      color: onSurface,
      fontWeight: baseHeadlineWeight,
    ),
    titleLarge: _titleLarge.copyWith(
      color: onSurface,
      fontWeight: baseTitleLargeWeight,
    ),
    titleMedium: _titleMedium.copyWith(
      color: onSurface,
      fontWeight: baseTitleMediumWeight,
    ),
    titleSmall: _titleSmall.copyWith(
      color: onSurface,
      fontWeight: baseTitleSmallWeight,
    ),
    bodyLarge: _bodyLarge.copyWith(
      color: onSurface,
      fontWeight: baseBodyWeight,
    ),
    bodyMedium: _bodyMedium.copyWith(
      color: onSurfaceVariant,
      fontWeight: baseBodyWeight,
    ),
    bodySmall: _bodySmall.copyWith(
      color: onSurfaceVariant,
      fontWeight: baseBodyWeight,
    ),
    labelLarge: _labelLarge.copyWith(
      color: onSurface,
      fontWeight: baseLabelLargeWeight,
    ),
    labelMedium: _labelMedium.copyWith(
      color: onSurfaceVariant,
      fontWeight: baseLabelMediumWeight,
    ),
    labelSmall: _labelSmall.copyWith(
      color: onSurfaceVariant,
      fontWeight: baseLabelSmallWeight,
    ),
  );
}

const TextStyle _displayLarge = TextStyle(
  fontSize: 57,
  letterSpacing: -0.25,
  height: 1.12,
);

const TextStyle _displayMedium = TextStyle(
  fontSize: 45,
  letterSpacing: 0,
  height: 1.16,
);

const TextStyle _displaySmall = TextStyle(
  fontSize: 36,
  letterSpacing: 0,
  height: 1.22,
);

const TextStyle _headlineLarge = TextStyle(
  fontSize: 32,
  letterSpacing: 0,
  height: 1.25,
);

const TextStyle _headlineMedium = TextStyle(
  fontSize: 28,
  letterSpacing: 0,
  height: 1.29,
);

const TextStyle _headlineSmall = TextStyle(
  fontSize: 24,
  letterSpacing: 0,
  height: 1.33,
);

const TextStyle _titleLarge = TextStyle(
  fontSize: 22,
  letterSpacing: 0,
  height: 1.27,
);

const TextStyle _titleMedium = TextStyle(
  fontSize: 18,
  letterSpacing: 0.15,
  height: 1.33,
);

const TextStyle _titleSmall = TextStyle(
  fontSize: 16,
  letterSpacing: 0.1,
  height: 1.43,
);

const TextStyle _bodyLarge = TextStyle(
  fontSize: 16,
  letterSpacing: 0.5,
  height: 1.5,
);

const TextStyle _bodyMedium = TextStyle(
  fontSize: 14,
  letterSpacing: 0.25,
  height: 1.43,
);

const TextStyle _bodySmall = TextStyle(
  fontSize: 12,
  letterSpacing: 0.4,
  height: 1.33,
);

const TextStyle _labelLarge = TextStyle(
  fontSize: 14,
  letterSpacing: 0.1,
  height: 1.43,
);

const TextStyle _labelMedium = TextStyle(
  fontSize: 12,
  letterSpacing: 0.5,
  height: 1.33,
);

const TextStyle _labelSmall = TextStyle(
  fontSize: 11,
  letterSpacing: 0.5,
  height: 1.45,
);
