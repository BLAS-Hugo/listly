import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listly/app/theme/colors.dart';

void main() {
  group('AppPalette', () {
    group('light palette', () {
      test('has all colors defined', () {
        expect(AppPalette.light.card, isNotNull);
        expect(AppPalette.light.onCard, isNotNull);
        expect(AppPalette.light.popover, isNotNull);
        expect(AppPalette.light.onPopover, isNotNull);
        expect(AppPalette.light.surfaceElevated, isNotNull);
        expect(AppPalette.light.muted, isNotNull);
        expect(AppPalette.light.onMuted, isNotNull);
        expect(AppPalette.light.accent, isNotNull);
        expect(AppPalette.light.onAccent, isNotNull);
        expect(AppPalette.light.success, isNotNull);
        expect(AppPalette.light.onSuccess, isNotNull);
        expect(AppPalette.light.destructive, isNotNull);
        expect(AppPalette.light.onDestructive, isNotNull);
        expect(AppPalette.light.border, isNotNull);
        expect(AppPalette.light.borderSubtle, isNotNull);
        expect(AppPalette.light.ring, isNotNull);
        expect(AppPalette.light.inputBackground, isNotNull);
        expect(AppPalette.light.switchBackground, isNotNull);
        expect(AppPalette.light.sidebar, isNotNull);
        expect(AppPalette.light.onSidebar, isNotNull);
        expect(AppPalette.light.sidebarPrimary, isNotNull);
        expect(AppPalette.light.onSidebarPrimary, isNotNull);
        expect(AppPalette.light.sidebarAccent, isNotNull);
        expect(AppPalette.light.onSidebarAccent, isNotNull);
        expect(AppPalette.light.sidebarBorder, isNotNull);
        expect(AppPalette.light.sidebarRing, isNotNull);
      });

      test('has light colors with correct values', () {
        expect(AppPalette.light.card, equals(const Color(0xFFFFFFFF)));
        expect(AppPalette.light.onCard, equals(const Color(0xFF1A1A1A)));
        expect(AppPalette.light.success, equals(const Color(0xFF2D7A3E)));
        expect(AppPalette.light.destructive, equals(const Color(0xFFD32F2F)));
      });
    });

    group('dark palette', () {
      test('has all colors defined', () {
        expect(AppPalette.dark.card, isNotNull);
        expect(AppPalette.dark.onCard, isNotNull);
        expect(AppPalette.dark.popover, isNotNull);
        expect(AppPalette.dark.onPopover, isNotNull);
        expect(AppPalette.dark.surfaceElevated, isNotNull);
        expect(AppPalette.dark.muted, isNotNull);
        expect(AppPalette.dark.onMuted, isNotNull);
        expect(AppPalette.dark.accent, isNotNull);
        expect(AppPalette.dark.onAccent, isNotNull);
        expect(AppPalette.dark.success, isNotNull);
        expect(AppPalette.dark.onSuccess, isNotNull);
        expect(AppPalette.dark.destructive, isNotNull);
        expect(AppPalette.dark.onDestructive, isNotNull);
        expect(AppPalette.dark.border, isNotNull);
        expect(AppPalette.dark.borderSubtle, isNotNull);
        expect(AppPalette.dark.ring, isNotNull);
        expect(AppPalette.dark.inputBackground, isNotNull);
        expect(AppPalette.dark.switchBackground, isNotNull);
        expect(AppPalette.dark.sidebar, isNotNull);
        expect(AppPalette.dark.onSidebar, isNotNull);
        expect(AppPalette.dark.sidebarPrimary, isNotNull);
        expect(AppPalette.dark.onSidebarPrimary, isNotNull);
        expect(AppPalette.dark.sidebarAccent, isNotNull);
        expect(AppPalette.dark.onSidebarAccent, isNotNull);
        expect(AppPalette.dark.sidebarBorder, isNotNull);
        expect(AppPalette.dark.sidebarRing, isNotNull);
      });

      test('has dark colors with correct values', () {
        expect(AppPalette.dark.card, equals(const Color(0xFF1E1E1E)));
        expect(AppPalette.dark.onCard, equals(const Color(0xFFE0E0E0)));
        expect(AppPalette.dark.success, equals(const Color(0xFF4CAF50)));
        expect(AppPalette.dark.destructive, equals(const Color(0xFFEF5350)));
      });
    });

    group('copyWith', () {
      test('creates copy with updated card color', () {
        const palette = AppPalette.light;
        const newColor = Color(0xFF123456);
        final updated = palette.copyWith(card: newColor);

        expect(updated.card, equals(newColor));
        expect(updated.onCard, equals(palette.onCard));
        expect(updated.success, equals(palette.success));
      });

      test('creates copy with multiple updated colors', () {
        const palette = AppPalette.light;
        const newCard = Color(0xFF111111);
        const newSuccess = Color(0xFF222222);

        final updated = palette.copyWith(card: newCard, success: newSuccess);

        expect(updated.card, equals(newCard));
        expect(updated.success, equals(newSuccess));
        expect(updated.onCard, equals(palette.onCard));
        expect(updated.destructive, equals(palette.destructive));
      });

      test('creates identical copy when no parameters provided', () {
        const palette = AppPalette.light;
        final updated = palette.copyWith();

        expect(updated.card, equals(palette.card));
        expect(updated.onCard, equals(palette.onCard));
        expect(updated.success, equals(palette.success));
        expect(updated.destructive, equals(palette.destructive));
      });
    });

    group('lerp', () {
      test('lerps between light and dark at t=0', () {
        final result = AppPalette.light.lerp(AppPalette.dark, 0.0);

        expect(result.card, equals(AppPalette.light.card));
        expect(result.onCard, equals(AppPalette.light.onCard));
        expect(result.success, equals(AppPalette.light.success));
      });

      test('lerps between light and dark at t=1', () {
        final result = AppPalette.light.lerp(AppPalette.dark, 1.0);

        expect(result.card, equals(AppPalette.dark.card));
        expect(result.onCard, equals(AppPalette.dark.onCard));
        expect(result.success, equals(AppPalette.dark.success));
      });

      test('lerps between light and dark at t=0.5', () {
        final result = AppPalette.light.lerp(AppPalette.dark, 0.5);

        // The result should be somewhere between light and dark
        expect(result.card, isNotNull);
        expect(result.card, isNot(equals(AppPalette.light.card)));
        expect(result.card, isNot(equals(AppPalette.dark.card)));
      });

      test('returns this when other is null', () {
        final result = AppPalette.light.lerp(null, 0.5);

        expect(result.card, equals(AppPalette.light.card));
        expect(result.onCard, equals(AppPalette.light.onCard));
        expect(result.success, equals(AppPalette.light.success));
      });
    });

    group('palette differences', () {
      test('light and dark palettes have different card colors', () {
        expect(AppPalette.light.card, isNot(equals(AppPalette.dark.card)));
      });

      test('light and dark palettes have different success colors', () {
        expect(
          AppPalette.light.success,
          isNot(equals(AppPalette.dark.success)),
        );
      });

      test('light and dark palettes have different sidebar colors', () {
        expect(
          AppPalette.light.sidebar,
          isNot(equals(AppPalette.dark.sidebar)),
        );
      });

      test('light palette has lighter surface colors', () {
        // Light card should have higher lightness than dark card
        final lightHSL = HSLColor.fromColor(AppPalette.light.card);
        final darkHSL = HSLColor.fromColor(AppPalette.dark.card);

        expect(lightHSL.lightness, greaterThan(darkHSL.lightness));
      });
    });
  });

  group('lightColorScheme', () {
    test('has correct brightness', () {
      expect(lightColorScheme.brightness, equals(Brightness.light));
    });

    test('has all required colors defined', () {
      expect(lightColorScheme.primary, isNotNull);
      expect(lightColorScheme.onPrimary, isNotNull);
      expect(lightColorScheme.primaryContainer, isNotNull);
      expect(lightColorScheme.onPrimaryContainer, isNotNull);
      expect(lightColorScheme.secondary, isNotNull);
      expect(lightColorScheme.onSecondary, isNotNull);
      expect(lightColorScheme.secondaryContainer, isNotNull);
      expect(lightColorScheme.onSecondaryContainer, isNotNull);
      expect(lightColorScheme.tertiary, isNotNull);
      expect(lightColorScheme.onTertiary, isNotNull);
      expect(lightColorScheme.tertiaryContainer, isNotNull);
      expect(lightColorScheme.onTertiaryContainer, isNotNull);
      expect(lightColorScheme.error, isNotNull);
      expect(lightColorScheme.onError, isNotNull);
      expect(lightColorScheme.errorContainer, isNotNull);
      expect(lightColorScheme.onErrorContainer, isNotNull);
      expect(lightColorScheme.surface, isNotNull);
      expect(lightColorScheme.onSurface, isNotNull);
      expect(lightColorScheme.onSurfaceVariant, isNotNull);
      expect(lightColorScheme.outline, isNotNull);
      expect(lightColorScheme.outlineVariant, isNotNull);
    });

    test('has correct primary color', () {
      expect(lightColorScheme.primary, equals(const Color(0xFF2D7A3E)));
    });

    test('has correct error color', () {
      expect(lightColorScheme.error, equals(const Color(0xFFD32F2F)));
    });

    test('has light surface colors', () {
      expect(lightColorScheme.surface, equals(const Color(0xFFFFFFFF)));
    });
  });

  group('darkColorScheme', () {
    test('has correct brightness', () {
      expect(darkColorScheme.brightness, equals(Brightness.dark));
    });

    test('has all required colors defined', () {
      expect(darkColorScheme.primary, isNotNull);
      expect(darkColorScheme.onPrimary, isNotNull);
      expect(darkColorScheme.primaryContainer, isNotNull);
      expect(darkColorScheme.onPrimaryContainer, isNotNull);
      expect(darkColorScheme.secondary, isNotNull);
      expect(darkColorScheme.onSecondary, isNotNull);
      expect(darkColorScheme.secondaryContainer, isNotNull);
      expect(darkColorScheme.onSecondaryContainer, isNotNull);
      expect(darkColorScheme.tertiary, isNotNull);
      expect(darkColorScheme.onTertiary, isNotNull);
      expect(darkColorScheme.tertiaryContainer, isNotNull);
      expect(darkColorScheme.onTertiaryContainer, isNotNull);
      expect(darkColorScheme.error, isNotNull);
      expect(darkColorScheme.onError, isNotNull);
      expect(darkColorScheme.errorContainer, isNotNull);
      expect(darkColorScheme.onErrorContainer, isNotNull);
      expect(darkColorScheme.surface, isNotNull);
      expect(darkColorScheme.onSurface, isNotNull);
      expect(darkColorScheme.onSurfaceVariant, isNotNull);
      expect(darkColorScheme.outline, isNotNull);
      expect(darkColorScheme.outlineVariant, isNotNull);
    });

    test('has correct primary color', () {
      expect(darkColorScheme.primary, equals(const Color(0xFF4CAF50)));
    });

    test('has correct error color', () {
      expect(darkColorScheme.error, equals(const Color(0xFFEF5350)));
    });

    test('has dark surface colors', () {
      expect(darkColorScheme.surface, equals(const Color(0xFF1E1E1E)));
    });
  });

  group('color scheme differences', () {
    test('light and dark have different primary colors', () {
      expect(lightColorScheme.primary, isNot(equals(darkColorScheme.primary)));
    });

    test('light and dark have different surface colors', () {
      expect(lightColorScheme.surface, isNot(equals(darkColorScheme.surface)));
    });

    test('light and dark have different error colors', () {
      expect(lightColorScheme.error, isNot(equals(darkColorScheme.error)));
    });

    test('light has lighter surface than dark', () {
      final lightHSL = HSLColor.fromColor(lightColorScheme.surface);
      final darkHSL = HSLColor.fromColor(darkColorScheme.surface);

      expect(lightHSL.lightness, greaterThan(darkHSL.lightness));
    });
  });

  group('color accessibility', () {
    test('light scheme has sufficient contrast on surfaces', () {
      // Ensure onSurface has different lightness than surface for contrast
      final surfaceHSL = HSLColor.fromColor(lightColorScheme.surface);
      final onSurfaceHSL = HSLColor.fromColor(lightColorScheme.onSurface);

      expect(
        (surfaceHSL.lightness - onSurfaceHSL.lightness).abs(),
        greaterThan(0.3),
      );
    });

    test('dark scheme has sufficient contrast on surfaces', () {
      // Ensure onSurface has different lightness than surface for contrast
      final surfaceHSL = HSLColor.fromColor(darkColorScheme.surface);
      final onSurfaceHSL = HSLColor.fromColor(darkColorScheme.onSurface);

      expect(
        (surfaceHSL.lightness - onSurfaceHSL.lightness).abs(),
        greaterThan(0.3),
      );
    });

    test('success colors have white text', () {
      expect(AppPalette.light.onSuccess, equals(const Color(0xFFFFFFFF)));
      expect(AppPalette.dark.onSuccess, equals(const Color(0xFFFFFFFF)));
    });

    test('destructive colors have white text', () {
      expect(AppPalette.light.onDestructive, equals(const Color(0xFFFFFFFF)));
      expect(AppPalette.dark.onDestructive, equals(const Color(0xFFFFFFFF)));
    });
  });
}
