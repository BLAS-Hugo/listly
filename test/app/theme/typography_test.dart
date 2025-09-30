import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listly/app/theme/colors.dart';
import 'package:listly/app/theme/typography.dart';

void main() {
  group('buildTextTheme', () {
    group('light text theme', () {
      late TextTheme textTheme;
      late ColorScheme colorScheme;

      setUp(() {
        colorScheme = lightColorScheme;
        textTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: colorScheme,
        );
      });

      test('has all text styles defined', () {
        expect(textTheme.displayLarge, isNotNull);
        expect(textTheme.displayMedium, isNotNull);
        expect(textTheme.displaySmall, isNotNull);
        expect(textTheme.headlineLarge, isNotNull);
        expect(textTheme.headlineMedium, isNotNull);
        expect(textTheme.headlineSmall, isNotNull);
        expect(textTheme.titleLarge, isNotNull);
        expect(textTheme.titleMedium, isNotNull);
        expect(textTheme.titleSmall, isNotNull);
        expect(textTheme.bodyLarge, isNotNull);
        expect(textTheme.bodyMedium, isNotNull);
        expect(textTheme.bodySmall, isNotNull);
        expect(textTheme.labelLarge, isNotNull);
        expect(textTheme.labelMedium, isNotNull);
        expect(textTheme.labelSmall, isNotNull);
      });

      group('display styles', () {
        test('displayLarge has correct properties', () {
          final style = textTheme.displayLarge!;
          expect(style.fontSize, equals(57));
          expect(style.letterSpacing, equals(-0.25));
          expect(style.height, equals(1.12));
          expect(style.fontWeight, equals(FontWeight.w400));
          expect(style.color, equals(colorScheme.onSurface));
        });

        test('displayMedium has correct properties', () {
          final style = textTheme.displayMedium!;
          expect(style.fontSize, equals(45));
          expect(style.letterSpacing, equals(0));
          expect(style.height, equals(1.16));
          expect(style.fontWeight, equals(FontWeight.w400));
          expect(style.color, equals(colorScheme.onSurface));
        });

        test('displaySmall has correct properties', () {
          final style = textTheme.displaySmall!;
          expect(style.fontSize, equals(36));
          expect(style.letterSpacing, equals(0));
          expect(style.height, equals(1.22));
          expect(style.fontWeight, equals(FontWeight.w400));
          expect(style.color, equals(colorScheme.onSurface));
        });
      });

      group('headline styles', () {
        test('headlineLarge has correct properties', () {
          final style = textTheme.headlineLarge!;
          expect(style.fontSize, equals(32));
          expect(style.letterSpacing, equals(0));
          expect(style.height, equals(1.25));
          expect(style.fontWeight, equals(FontWeight.w600));
          expect(style.color, equals(colorScheme.onSurface));
        });

        test('headlineMedium has correct properties', () {
          final style = textTheme.headlineMedium!;
          expect(style.fontSize, equals(28));
          expect(style.letterSpacing, equals(0));
          expect(style.height, equals(1.29));
          expect(style.fontWeight, equals(FontWeight.w600));
          expect(style.color, equals(colorScheme.onSurface));
        });

        test('headlineSmall has correct properties', () {
          final style = textTheme.headlineSmall!;
          expect(style.fontSize, equals(24));
          expect(style.letterSpacing, equals(0));
          expect(style.height, equals(1.33));
          expect(style.fontWeight, equals(FontWeight.w600));
          expect(style.color, equals(colorScheme.onSurface));
        });
      });

      group('title styles', () {
        test('titleLarge has correct properties', () {
          final style = textTheme.titleLarge!;
          expect(style.fontSize, equals(22));
          expect(style.letterSpacing, equals(0));
          expect(style.height, equals(1.27));
          expect(style.fontWeight, equals(FontWeight.w600));
          expect(style.color, equals(colorScheme.onSurface));
        });

        test('titleMedium has correct properties', () {
          final style = textTheme.titleMedium!;
          expect(style.fontSize, equals(18));
          expect(style.letterSpacing, equals(0.15));
          expect(style.height, equals(1.33));
          expect(style.fontWeight, equals(FontWeight.w600));
          expect(style.color, equals(colorScheme.onSurface));
        });

        test('titleSmall has correct properties', () {
          final style = textTheme.titleSmall!;
          expect(style.fontSize, equals(16));
          expect(style.letterSpacing, equals(0.1));
          expect(style.height, equals(1.43));
          expect(style.fontWeight, equals(FontWeight.w500));
          expect(style.color, equals(colorScheme.onSurface));
        });
      });

      group('body styles', () {
        test('bodyLarge has correct properties', () {
          final style = textTheme.bodyLarge!;
          expect(style.fontSize, equals(16));
          expect(style.letterSpacing, equals(0.5));
          expect(style.height, equals(1.5));
          expect(style.fontWeight, equals(FontWeight.w400));
          expect(style.color, equals(colorScheme.onSurface));
        });

        test('bodyMedium has correct properties', () {
          final style = textTheme.bodyMedium!;
          expect(style.fontSize, equals(14));
          expect(style.letterSpacing, equals(0.25));
          expect(style.height, equals(1.43));
          expect(style.fontWeight, equals(FontWeight.w400));
          expect(style.color, equals(colorScheme.onSurfaceVariant));
        });

        test('bodySmall has correct properties', () {
          final style = textTheme.bodySmall!;
          expect(style.fontSize, equals(12));
          expect(style.letterSpacing, equals(0.4));
          expect(style.height, equals(1.33));
          expect(style.fontWeight, equals(FontWeight.w400));
          expect(style.color, equals(colorScheme.onSurfaceVariant));
        });
      });

      group('label styles', () {
        test('labelLarge has correct properties', () {
          final style = textTheme.labelLarge!;
          expect(style.fontSize, equals(14));
          expect(style.letterSpacing, equals(0.1));
          expect(style.height, equals(1.43));
          expect(style.fontWeight, equals(FontWeight.w500));
          expect(style.color, equals(colorScheme.onSurface));
        });

        test('labelMedium has correct properties', () {
          final style = textTheme.labelMedium!;
          expect(style.fontSize, equals(12));
          expect(style.letterSpacing, equals(0.5));
          expect(style.height, equals(1.33));
          expect(style.fontWeight, equals(FontWeight.w500));
          expect(style.color, equals(colorScheme.onSurfaceVariant));
        });

        test('labelSmall has correct properties', () {
          final style = textTheme.labelSmall!;
          expect(style.fontSize, equals(11));
          expect(style.letterSpacing, equals(0.5));
          expect(style.height, equals(1.45));
          expect(style.fontWeight, equals(FontWeight.w500));
          expect(style.color, equals(colorScheme.onSurfaceVariant));
        });
      });
    });

    group('dark text theme', () {
      late TextTheme textTheme;
      late ColorScheme colorScheme;

      setUp(() {
        colorScheme = darkColorScheme;
        textTheme = buildTextTheme(
          brightness: Brightness.dark,
          colorScheme: colorScheme,
        );
      });

      test('has all text styles defined', () {
        expect(textTheme.displayLarge, isNotNull);
        expect(textTheme.displayMedium, isNotNull);
        expect(textTheme.displaySmall, isNotNull);
        expect(textTheme.headlineLarge, isNotNull);
        expect(textTheme.headlineMedium, isNotNull);
        expect(textTheme.headlineSmall, isNotNull);
        expect(textTheme.titleLarge, isNotNull);
        expect(textTheme.titleMedium, isNotNull);
        expect(textTheme.titleSmall, isNotNull);
        expect(textTheme.bodyLarge, isNotNull);
        expect(textTheme.bodyMedium, isNotNull);
        expect(textTheme.bodySmall, isNotNull);
        expect(textTheme.labelLarge, isNotNull);
        expect(textTheme.labelMedium, isNotNull);
        expect(textTheme.labelSmall, isNotNull);
      });

      test('uses dark color scheme colors', () {
        expect(textTheme.displayLarge!.color, equals(colorScheme.onSurface));
        expect(textTheme.bodyMedium!.color, equals(colorScheme.onSurfaceVariant));
        expect(textTheme.labelMedium!.color, equals(colorScheme.onSurfaceVariant));
      });

      test('has same font sizes as light theme', () {
        final lightTextTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.displayLarge!.fontSize,
          equals(lightTextTheme.displayLarge!.fontSize),
        );
        expect(
          textTheme.bodyMedium!.fontSize,
          equals(lightTextTheme.bodyMedium!.fontSize),
        );
        expect(
          textTheme.labelLarge!.fontSize,
          equals(lightTextTheme.labelLarge!.fontSize),
        );
      });

      test('has same font weights as light theme', () {
        final lightTextTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.displayLarge!.fontWeight,
          equals(lightTextTheme.displayLarge!.fontWeight),
        );
        expect(
          textTheme.headlineLarge!.fontWeight,
          equals(lightTextTheme.headlineLarge!.fontWeight),
        );
        expect(
          textTheme.bodyMedium!.fontWeight,
          equals(lightTextTheme.bodyMedium!.fontWeight),
        );
      });
    });

    group('text theme consistency', () {
      test('display styles have increasing font sizes', () {
        final textTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.displayLarge!.fontSize! > textTheme.displayMedium!.fontSize!,
          isTrue,
        );
        expect(
          textTheme.displayMedium!.fontSize! > textTheme.displaySmall!.fontSize!,
          isTrue,
        );
      });

      test('headline styles have increasing font sizes', () {
        final textTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.headlineLarge!.fontSize! >
              textTheme.headlineMedium!.fontSize!,
          isTrue,
        );
        expect(
          textTheme.headlineMedium!.fontSize! >
              textTheme.headlineSmall!.fontSize!,
          isTrue,
        );
      });

      test('title styles have increasing font sizes', () {
        final textTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.titleLarge!.fontSize! > textTheme.titleMedium!.fontSize!,
          isTrue,
        );
        expect(
          textTheme.titleMedium!.fontSize! > textTheme.titleSmall!.fontSize!,
          isTrue,
        );
      });

      test('body styles have increasing font sizes', () {
        final textTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.bodyLarge!.fontSize! > textTheme.bodyMedium!.fontSize!,
          isTrue,
        );
        expect(
          textTheme.bodyMedium!.fontSize! > textTheme.bodySmall!.fontSize!,
          isTrue,
        );
      });

      test('label styles have increasing font sizes', () {
        final textTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.labelLarge!.fontSize! > textTheme.labelMedium!.fontSize!,
          isTrue,
        );
        expect(
          textTheme.labelMedium!.fontSize! > textTheme.labelSmall!.fontSize!,
          isTrue,
        );
      });

      test('headlines are bolder than body text', () {
        final textTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.headlineLarge!.fontWeight!.index >
              textTheme.bodyLarge!.fontWeight!.index,
          isTrue,
        );
      });

      test('labels are bolder than body text', () {
        final textTheme = buildTextTheme(
          brightness: Brightness.light,
          colorScheme: lightColorScheme,
        );

        expect(
          textTheme.labelLarge!.fontWeight!.index >=
              textTheme.bodyLarge!.fontWeight!.index,
          isTrue,
        );
      });
    });
  });
}
