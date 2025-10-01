import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';
import 'package:listly/app/theme/components/components.dart';
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
      cardTheme: buildCardThemeData(colorScheme, palette),
      appBarTheme: buildAppBarTheme(colorScheme, textTheme),
      elevatedButtonTheme: buildElevatedButtonTheme(colorScheme, textTheme),
      outlinedButtonTheme: buildOutlinedButtonTheme(
        colorScheme,
        textTheme,
        palette,
      ),
      inputDecorationTheme: buildInputDecorationTheme(
        colorScheme,
        textTheme,
        palette,
      ),
      chipTheme: buildChipTheme(colorScheme, textTheme, palette),
      dividerTheme: buildDividerTheme(palette),
      iconTheme: buildIconTheme(colorScheme),
      navigationBarTheme: buildNavigationBarTheme(
        textTheme,
        colorScheme,
        palette,
      ),
      navigationRailTheme: buildNavigationRailTheme(textTheme, palette),
      switchTheme: buildSwitchTheme(colorScheme, palette),
    );
  }
}
