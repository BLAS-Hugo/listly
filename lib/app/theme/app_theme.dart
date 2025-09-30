import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';
import 'package:listly/app/theme/typography.dart';

class AppTheme {
  static ThemeData light() => _buildTheme(
    colorScheme: lightColorScheme,
    palette: AppPalette.light,
    brightness: Brightness.light,
  );

  static ThemeData dark() => _buildTheme(
    colorScheme: darkColorScheme,
    palette: AppPalette.dark,
    brightness: Brightness.dark,
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required AppPalette palette,
    required Brightness brightness,
  }) {
    final textTheme = buildTextTheme(
      brightness: brightness,
      colorScheme: colorScheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[palette],
      scaffoldBackgroundColor: colorScheme.surface,
      cardTheme: CardThemeData(
        color: palette.card,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: palette.borderSubtle),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: textTheme.labelLarge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: palette.border),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
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
      ),
      chipTheme: ChipThemeData(
        backgroundColor: palette.muted,
        selectedColor: colorScheme.primaryContainer,
        disabledColor: palette.muted.withValues(alpha: 0.5),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: palette.borderSubtle,
        thickness: 1,
        space: 1,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: palette.sidebar,
        selectedIconTheme: IconThemeData(color: palette.sidebarPrimary),
        unselectedIconTheme: IconThemeData(color: palette.onSidebarAccent),
        selectedLabelTextStyle: textTheme.labelLarge?.copyWith(
          color: palette.sidebarPrimary,
        ),
        unselectedLabelTextStyle: textTheme.labelLarge?.copyWith(
          color: palette.onSidebarAccent,
        ),
        indicatorColor: palette.sidebarRing,
      ),
      switchTheme: SwitchThemeData(
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
      ),
    );
  }
}
