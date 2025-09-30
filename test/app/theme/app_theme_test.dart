import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listly/app/theme/app_theme.dart';
import 'package:listly/app/theme/colors.dart';

void main() {
  group('AppTheme', () {
    group('light theme', () {
      late ThemeData theme;

      setUp(() {
        theme = AppTheme.light();
      });

      test('has correct brightness', () {
        expect(theme.brightness, equals(Brightness.light));
      });

      test('uses Material 3', () {
        expect(theme.useMaterial3, isTrue);
      });

      test('has correct color scheme', () {
        expect(theme.colorScheme, equals(lightColorScheme));
        expect(theme.colorScheme.brightness, equals(Brightness.light));
      });

      test('has light AppPalette extension', () {
        final palette = theme.extension<AppPalette>();
        expect(palette, isNotNull);
        expect(palette, equals(AppPalette.light));
      });

      test('has correct scaffold background color', () {
        expect(
          theme.scaffoldBackgroundColor,
          equals(lightColorScheme.surface),
        );
      });

      test('has non-null text theme', () {
        expect(theme.textTheme, isNotNull);
        expect(theme.textTheme.displayLarge, isNotNull);
        expect(theme.textTheme.bodyMedium, isNotNull);
        expect(theme.textTheme.labelLarge, isNotNull);
      });

      test('has card theme configured', () {
        expect(theme.cardTheme, isNotNull);
        expect(theme.cardTheme.color, equals(AppPalette.light.card));
        expect(theme.cardTheme.elevation, equals(0));
        expect(theme.cardTheme.shadowColor, equals(Colors.transparent));
        expect(theme.cardTheme.shape, isA<RoundedRectangleBorder>());
      });

      test('has app bar theme configured', () {
        expect(theme.appBarTheme, isNotNull);
        expect(
          theme.appBarTheme.backgroundColor,
          equals(lightColorScheme.surface),
        );
        expect(theme.appBarTheme.elevation, equals(0));
        expect(theme.appBarTheme.scrolledUnderElevation, equals(0));
        expect(theme.appBarTheme.centerTitle, isFalse);
      });

      test('has elevated button theme configured', () {
        expect(theme.elevatedButtonTheme, isNotNull);
        expect(theme.elevatedButtonTheme.style, isNotNull);
      });

      test('has outlined button theme configured', () {
        expect(theme.outlinedButtonTheme, isNotNull);
        expect(theme.outlinedButtonTheme.style, isNotNull);
      });

      test('has input decoration theme configured', () {
        expect(theme.inputDecorationTheme, isNotNull);
        expect(theme.inputDecorationTheme.filled, isTrue);
        expect(
          theme.inputDecorationTheme.fillColor,
          equals(AppPalette.light.inputBackground),
        );
      });

      test('has chip theme configured', () {
        expect(theme.chipTheme, isNotNull);
        expect(
          theme.chipTheme.backgroundColor,
          equals(AppPalette.light.muted),
        );
      });

      test('has divider theme configured', () {
        expect(theme.dividerTheme, isNotNull);
        expect(
          theme.dividerTheme.color,
          equals(AppPalette.light.borderSubtle),
        );
        expect(theme.dividerTheme.thickness, equals(1));
      });

      test('has icon theme configured', () {
        expect(theme.iconTheme, isNotNull);
        expect(
          theme.iconTheme.color,
          equals(lightColorScheme.onSurfaceVariant),
        );
      });

      test('has navigation rail theme configured', () {
        expect(theme.navigationRailTheme, isNotNull);
        expect(
          theme.navigationRailTheme.backgroundColor,
          equals(AppPalette.light.sidebar),
        );
      });

      test('has switch theme configured', () {
        expect(theme.switchTheme, isNotNull);
        expect(theme.switchTheme.trackColor, isNotNull);
        expect(theme.switchTheme.thumbColor, isNotNull);
      });
    });

    group('dark theme', () {
      late ThemeData theme;

      setUp(() {
        theme = AppTheme.dark();
      });

      test('has correct brightness', () {
        expect(theme.brightness, equals(Brightness.dark));
      });

      test('uses Material 3', () {
        expect(theme.useMaterial3, isTrue);
      });

      test('has correct color scheme', () {
        expect(theme.colorScheme, equals(darkColorScheme));
        expect(theme.colorScheme.brightness, equals(Brightness.dark));
      });

      test('has dark AppPalette extension', () {
        final palette = theme.extension<AppPalette>();
        expect(palette, isNotNull);
        expect(palette, equals(AppPalette.dark));
      });

      test('has correct scaffold background color', () {
        expect(
          theme.scaffoldBackgroundColor,
          equals(darkColorScheme.surface),
        );
      });

      test('has non-null text theme', () {
        expect(theme.textTheme, isNotNull);
        expect(theme.textTheme.displayLarge, isNotNull);
        expect(theme.textTheme.bodyMedium, isNotNull);
        expect(theme.textTheme.labelLarge, isNotNull);
      });

      test('has card theme configured', () {
        expect(theme.cardTheme, isNotNull);
        expect(theme.cardTheme.color, equals(AppPalette.dark.card));
        expect(theme.cardTheme.elevation, equals(0));
        expect(theme.cardTheme.shadowColor, equals(Colors.transparent));
        expect(theme.cardTheme.shape, isA<RoundedRectangleBorder>());
      });

      test('has app bar theme configured', () {
        expect(theme.appBarTheme, isNotNull);
        expect(
          theme.appBarTheme.backgroundColor,
          equals(darkColorScheme.surface),
        );
        expect(theme.appBarTheme.elevation, equals(0));
        expect(theme.appBarTheme.scrolledUnderElevation, equals(0));
        expect(theme.appBarTheme.centerTitle, isFalse);
      });

      test('has elevated button theme configured', () {
        expect(theme.elevatedButtonTheme, isNotNull);
        expect(theme.elevatedButtonTheme.style, isNotNull);
      });

      test('has outlined button theme configured', () {
        expect(theme.outlinedButtonTheme, isNotNull);
        expect(theme.outlinedButtonTheme.style, isNotNull);
      });

      test('has input decoration theme configured', () {
        expect(theme.inputDecorationTheme, isNotNull);
        expect(theme.inputDecorationTheme.filled, isTrue);
        expect(
          theme.inputDecorationTheme.fillColor,
          equals(AppPalette.dark.inputBackground),
        );
      });

      test('has chip theme configured', () {
        expect(theme.chipTheme, isNotNull);
        expect(
          theme.chipTheme.backgroundColor,
          equals(AppPalette.dark.muted),
        );
      });

      test('has divider theme configured', () {
        expect(theme.dividerTheme, isNotNull);
        expect(
          theme.dividerTheme.color,
          equals(AppPalette.dark.borderSubtle),
        );
        expect(theme.dividerTheme.thickness, equals(1));
      });

      test('has icon theme configured', () {
        expect(theme.iconTheme, isNotNull);
        expect(
          theme.iconTheme.color,
          equals(darkColorScheme.onSurfaceVariant),
        );
      });

      test('has navigation rail theme configured', () {
        expect(theme.navigationRailTheme, isNotNull);
        expect(
          theme.navigationRailTheme.backgroundColor,
          equals(AppPalette.dark.sidebar),
        );
      });

      test('has switch theme configured', () {
        expect(theme.switchTheme, isNotNull);
        expect(theme.switchTheme.trackColor, isNotNull);
        expect(theme.switchTheme.thumbColor, isNotNull);
      });
    });

    group('theme consistency', () {
      test('light and dark themes have different color schemes', () {
        final light = AppTheme.light();
        final dark = AppTheme.dark();

        expect(light.colorScheme, isNot(equals(dark.colorScheme)));
        expect(light.colorScheme.primary, isNot(equals(dark.colorScheme.primary)));
      });

      test('both themes use Material 3', () {
        final light = AppTheme.light();
        final dark = AppTheme.dark();

        expect(light.useMaterial3, isTrue);
        expect(dark.useMaterial3, isTrue);
      });

      test('both themes have all required components configured', () {
        final light = AppTheme.light();
        final dark = AppTheme.dark();

        // Check that both themes have all component themes configured
        expect(light.cardTheme, isNotNull);
        expect(dark.cardTheme, isNotNull);

        expect(light.appBarTheme, isNotNull);
        expect(dark.appBarTheme, isNotNull);

        expect(light.elevatedButtonTheme, isNotNull);
        expect(dark.elevatedButtonTheme, isNotNull);

        expect(light.outlinedButtonTheme, isNotNull);
        expect(dark.outlinedButtonTheme, isNotNull);

        expect(light.inputDecorationTheme, isNotNull);
        expect(dark.inputDecorationTheme, isNotNull);

        expect(light.chipTheme, isNotNull);
        expect(dark.chipTheme, isNotNull);

        expect(light.dividerTheme, isNotNull);
        expect(dark.dividerTheme, isNotNull);

        expect(light.iconTheme, isNotNull);
        expect(dark.iconTheme, isNotNull);

        expect(light.navigationRailTheme, isNotNull);
        expect(dark.navigationRailTheme, isNotNull);

        expect(light.switchTheme, isNotNull);
        expect(dark.switchTheme, isNotNull);
      });

      test('both themes have AppPalette extension', () {
        final light = AppTheme.light();
        final dark = AppTheme.dark();

        final lightPalette = light.extension<AppPalette>();
        final darkPalette = dark.extension<AppPalette>();

        expect(lightPalette, isNotNull);
        expect(darkPalette, isNotNull);
        expect(lightPalette, isNot(equals(darkPalette)));
      });
    });
  });
}
