import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listly/app/theme/colors.dart';
import 'package:listly/app/theme/components/components.dart';
import 'package:listly/app/theme/typography.dart';

void main() {
  group('Component Theme Builders', () {
    late ColorScheme lightColorScheme;
    late ColorScheme darkColorScheme;
    late AppPalette lightPalette;
    late AppPalette darkPalette;
    late TextTheme lightTextTheme;
    late TextTheme darkTextTheme;

    setUp(() {
      lightColorScheme = const ColorScheme.light();
      darkColorScheme = const ColorScheme.dark();
      lightPalette = AppPalette.light;
      darkPalette = AppPalette.dark;
      lightTextTheme = buildTextTheme(
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
      );
      darkTextTheme = buildTextTheme(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
      );
    });

    group('buildCardThemeData', () {
      test('returns configured CardThemeData for light theme', () {
        final cardTheme = buildCardThemeData(lightColorScheme, lightPalette);

        expect(cardTheme, isNotNull);
        expect(cardTheme.color, equals(lightPalette.card));
        expect(cardTheme.elevation, equals(0));
        expect(cardTheme.shadowColor, equals(Colors.transparent));
        expect(cardTheme.shape, isA<RoundedRectangleBorder>());
      });

      test('returns configured CardThemeData for dark theme', () {
        final cardTheme = buildCardThemeData(darkColorScheme, darkPalette);

        expect(cardTheme, isNotNull);
        expect(cardTheme.color, equals(darkPalette.card));
        expect(cardTheme.elevation, equals(0));
        expect(cardTheme.shadowColor, equals(Colors.transparent));
      });

      test('has rounded corners', () {
        final cardTheme = buildCardThemeData(lightColorScheme, lightPalette);
        final shape = cardTheme.shape! as RoundedRectangleBorder;

        expect(
          shape.borderRadius,
          equals(const BorderRadius.all(Radius.circular(12))),
        );
      });

      test('has border with correct color', () {
        final cardTheme = buildCardThemeData(lightColorScheme, lightPalette);
        final shape = cardTheme.shape! as RoundedRectangleBorder;

        expect(shape.side.color, equals(lightPalette.borderSubtle));
      });
    });

    group('buildAppBarTheme', () {
      test('returns configured AppBarTheme for light theme', () {
        final appBarTheme = buildAppBarTheme(lightColorScheme, lightTextTheme);

        expect(appBarTheme, isNotNull);
        expect(appBarTheme.backgroundColor, equals(lightColorScheme.surface));
        expect(appBarTheme.foregroundColor, equals(lightColorScheme.onSurface));
        expect(appBarTheme.elevation, equals(1));
        expect(appBarTheme.scrolledUnderElevation, equals(0));
        expect(appBarTheme.centerTitle, isFalse);
      });

      test('returns configured AppBarTheme for dark theme', () {
        final appBarTheme = buildAppBarTheme(darkColorScheme, darkTextTheme);

        expect(appBarTheme, isNotNull);
        expect(appBarTheme.backgroundColor, equals(darkColorScheme.surface));
        expect(appBarTheme.foregroundColor, equals(darkColorScheme.onSurface));
      });

      test('has correct title text style', () {
        final appBarTheme = buildAppBarTheme(lightColorScheme, lightTextTheme);

        expect(appBarTheme.titleTextStyle, isNotNull);
        expect(
          appBarTheme.titleTextStyle!.color,
          equals(lightColorScheme.onSurface),
        );
      });
    });

    group('buildElevatedButtonTheme', () {
      test('returns configured ElevatedButtonThemeData for light theme', () {
        final buttonTheme = buildElevatedButtonTheme(
          lightColorScheme,
          lightTextTheme,
        );

        expect(buttonTheme, isNotNull);
        expect(buttonTheme.style, isNotNull);
      });

      test('has correct colors', () {
        final buttonTheme = buildElevatedButtonTheme(
          lightColorScheme,
          lightTextTheme,
        );
        final style = buttonTheme.style!;

        final bgColor = style.backgroundColor?.resolve({});
        final fgColor = style.foregroundColor?.resolve({});

        expect(bgColor, equals(lightColorScheme.primary));
        expect(fgColor, equals(lightColorScheme.onPrimary));
      });

      test('has rounded corners', () {
        final buttonTheme = buildElevatedButtonTheme(
          lightColorScheme,
          lightTextTheme,
        );
        final style = buttonTheme.style!;
        final shape = style.shape?.resolve({});

        expect(shape, isA<RoundedRectangleBorder>());
        expect(
          (shape! as RoundedRectangleBorder).borderRadius,
          equals(const BorderRadius.all(Radius.circular(12))),
        );
      });

      test('has correct padding', () {
        final buttonTheme = buildElevatedButtonTheme(
          lightColorScheme,
          lightTextTheme,
        );
        final style = buttonTheme.style!;
        final padding = style.padding?.resolve({});

        expect(
          padding,
          equals(const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
        );
      });
    });

    group('buildOutlinedButtonTheme', () {
      test('returns configured OutlinedButtonThemeData for light theme', () {
        final buttonTheme = buildOutlinedButtonTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );

        expect(buttonTheme, isNotNull);
        expect(buttonTheme.style, isNotNull);
      });

      test('has correct colors', () {
        final buttonTheme = buildOutlinedButtonTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );
        final style = buttonTheme.style!;

        final fgColor = style.foregroundColor?.resolve({});
        expect(fgColor, equals(lightColorScheme.primary));
      });

      test('has border with correct color', () {
        final buttonTheme = buildOutlinedButtonTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );
        final style = buttonTheme.style!;
        final side = style.side?.resolve({});

        expect(side?.color, equals(lightPalette.border));
      });

      test('has rounded corners', () {
        final buttonTheme = buildOutlinedButtonTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );
        final style = buttonTheme.style!;
        final shape = style.shape?.resolve({});

        expect(shape, isA<RoundedRectangleBorder>());
        expect(
          (shape! as RoundedRectangleBorder).borderRadius,
          equals(const BorderRadius.all(Radius.circular(12))),
        );
      });

      test('has correct padding', () {
        final buttonTheme = buildOutlinedButtonTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );
        final style = buttonTheme.style!;
        final padding = style.padding?.resolve({});

        expect(
          padding,
          equals(const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
        );
      });
    });

    group('buildInputDecorationTheme', () {
      test('returns configured InputDecorationTheme for light theme', () {
        final inputTheme = buildInputDecorationTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );

        expect(inputTheme, isNotNull);
        expect(inputTheme.filled, isTrue);
        expect(inputTheme.fillColor, equals(lightPalette.inputBackground));
      });

      test('has correct border configuration', () {
        final inputTheme = buildInputDecorationTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );

        expect(inputTheme.border, isA<OutlineInputBorder>());
        expect(inputTheme.enabledBorder, isA<OutlineInputBorder>());
        expect(inputTheme.focusedBorder, isA<OutlineInputBorder>());
      });

      test('enabled border has correct color', () {
        final inputTheme = buildInputDecorationTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );
        final border = inputTheme.enabledBorder;

        expect(border, isA<OutlineInputBorder>());
        expect(
          (border! as OutlineInputBorder).borderSide.color,
          equals(lightPalette.borderSubtle),
        );
      });

      test('focused border has correct color and width', () {
        final inputTheme = buildInputDecorationTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );
        final border = inputTheme.focusedBorder;

        expect(border, isA<OutlineInputBorder>());
        expect(
          (border! as OutlineInputBorder).borderSide.color,
          equals(lightPalette.ring),
        );
        expect((border as OutlineInputBorder).borderSide.width, equals(1.5));
      });

      test('has correct label and hint styles', () {
        final inputTheme = buildInputDecorationTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );

        expect(inputTheme.labelStyle, isNotNull);
        expect(inputTheme.hintStyle, isNotNull);
        expect(
          inputTheme.labelStyle!.color,
          equals(lightColorScheme.onSurfaceVariant),
        );
      });
    });

    group('buildChipTheme', () {
      test('returns configured ChipThemeData for light theme', () {
        final chipTheme = buildChipTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );

        expect(chipTheme, isNotNull);
        expect(chipTheme.backgroundColor, equals(lightPalette.muted));
        expect(
          chipTheme.selectedColor,
          equals(lightColorScheme.primaryContainer),
        );
      });

      test('has correct disabled color', () {
        final chipTheme = buildChipTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );

        expect(
          chipTheme.disabledColor,
          equals(lightPalette.muted.withValues(alpha: 0.5)),
        );
      });

      test('has correct label styles', () {
        final chipTheme = buildChipTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );

        expect(chipTheme.labelStyle, isNotNull);
        expect(chipTheme.secondaryLabelStyle, isNotNull);
      });

      test('has rounded shape', () {
        final chipTheme = buildChipTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );
        final shape = chipTheme.shape;

        expect(shape, isA<RoundedRectangleBorder>());
        expect(
          (shape! as RoundedRectangleBorder).borderRadius,
          equals(const BorderRadius.all(Radius.circular(12))),
        );
      });
    });

    group('buildDividerTheme', () {
      test('returns configured DividerThemeData for light theme', () {
        final dividerTheme = buildDividerTheme(lightPalette);

        expect(dividerTheme, isNotNull);
        expect(dividerTheme.color, equals(lightPalette.borderSubtle));
        expect(dividerTheme.thickness, equals(1));
        expect(dividerTheme.space, equals(1));
      });

      test('returns configured DividerThemeData for dark theme', () {
        final dividerTheme = buildDividerTheme(darkPalette);

        expect(dividerTheme, isNotNull);
        expect(dividerTheme.color, equals(darkPalette.borderSubtle));
        expect(dividerTheme.thickness, equals(1));
        expect(dividerTheme.space, equals(1));
      });
    });

    group('buildIconTheme', () {
      test('returns configured IconThemeData for light theme', () {
        final iconTheme = buildIconTheme(lightColorScheme);

        expect(iconTheme, isNotNull);
        expect(iconTheme.color, equals(lightColorScheme.onSurfaceVariant));
      });

      test('returns configured IconThemeData for dark theme', () {
        final iconTheme = buildIconTheme(darkColorScheme);

        expect(iconTheme, isNotNull);
        expect(iconTheme.color, equals(darkColorScheme.onSurfaceVariant));
      });
    });

    group('buildNavigationRailTheme', () {
      test('returns configured NavigationRailThemeData for light theme', () {
        final navRailTheme = buildNavigationRailTheme(
          lightTextTheme,
          lightPalette,
        );

        expect(navRailTheme, isNotNull);
        expect(navRailTheme.backgroundColor, equals(lightPalette.sidebar));
        expect(navRailTheme.indicatorColor, equals(lightPalette.sidebarRing));
      });

      test('has correct icon themes', () {
        final navRailTheme = buildNavigationRailTheme(
          lightTextTheme,
          lightPalette,
        );

        expect(navRailTheme.selectedIconTheme, isNotNull);
        expect(navRailTheme.unselectedIconTheme, isNotNull);
        expect(
          navRailTheme.selectedIconTheme!.color,
          equals(lightPalette.sidebarPrimary),
        );
        expect(
          navRailTheme.unselectedIconTheme!.color,
          equals(lightPalette.onSidebarAccent),
        );
      });

      test('has correct label text styles', () {
        final navRailTheme = buildNavigationRailTheme(
          lightTextTheme,
          lightPalette,
        );

        expect(navRailTheme.selectedLabelTextStyle, isNotNull);
        expect(navRailTheme.unselectedLabelTextStyle, isNotNull);
        expect(
          navRailTheme.selectedLabelTextStyle!.color,
          equals(lightPalette.sidebarPrimary),
        );
        expect(
          navRailTheme.unselectedLabelTextStyle!.color,
          equals(lightPalette.onSidebarAccent),
        );
      });
    });

    group('buildSwitchTheme', () {
      test('returns configured SwitchThemeData for light theme', () {
        final switchTheme = buildSwitchTheme(lightColorScheme, lightPalette);

        expect(switchTheme, isNotNull);
        expect(switchTheme.trackColor, isNotNull);
        expect(switchTheme.thumbColor, isNotNull);
      });

      test('track color is correct when selected', () {
        final switchTheme = buildSwitchTheme(lightColorScheme, lightPalette);
        final trackColor = switchTheme.trackColor!.resolve({
          WidgetState.selected,
        });

        expect(trackColor, equals(lightColorScheme.primary));
      });

      test('track color is correct when not selected', () {
        final switchTheme = buildSwitchTheme(lightColorScheme, lightPalette);
        final trackColor = switchTheme.trackColor!.resolve({});

        expect(trackColor, equals(lightPalette.switchBackground));
      });

      test('thumb color is correct when selected', () {
        final switchTheme = buildSwitchTheme(lightColorScheme, lightPalette);
        final thumbColor = switchTheme.thumbColor!.resolve({
          WidgetState.selected,
        });

        expect(thumbColor, equals(lightColorScheme.onPrimary));
      });

      test('thumb color is correct when not selected', () {
        final switchTheme = buildSwitchTheme(lightColorScheme, lightPalette);
        final thumbColor = switchTheme.thumbColor!.resolve({});

        expect(thumbColor, equals(lightColorScheme.surface));
      });
    });

    group('theme builder consistency', () {
      test('all builders return non-null values', () {
        expect(buildCardThemeData(lightColorScheme, lightPalette), isNotNull);
        expect(buildAppBarTheme(lightColorScheme, lightTextTheme), isNotNull);
        expect(
          buildElevatedButtonTheme(lightColorScheme, lightTextTheme),
          isNotNull,
        );
        expect(
          buildOutlinedButtonTheme(
            lightColorScheme,
            lightTextTheme,
            lightPalette,
          ),
          isNotNull,
        );
        expect(
          buildInputDecorationTheme(
            lightColorScheme,
            lightTextTheme,
            lightPalette,
          ),
          isNotNull,
        );
        expect(
          buildChipTheme(lightColorScheme, lightTextTheme, lightPalette),
          isNotNull,
        );
        expect(buildDividerTheme(lightPalette), isNotNull);
        expect(buildIconTheme(lightColorScheme), isNotNull);
        expect(
          buildNavigationRailTheme(lightTextTheme, lightPalette),
          isNotNull,
        );
        expect(buildSwitchTheme(lightColorScheme, lightPalette), isNotNull);
      });

      test('all builders work with dark theme', () {
        expect(buildCardThemeData(darkColorScheme, darkPalette), isNotNull);
        expect(buildAppBarTheme(darkColorScheme, darkTextTheme), isNotNull);
        expect(
          buildElevatedButtonTheme(darkColorScheme, darkTextTheme),
          isNotNull,
        );
        expect(
          buildOutlinedButtonTheme(darkColorScheme, darkTextTheme, darkPalette),
          isNotNull,
        );
        expect(
          buildInputDecorationTheme(
            darkColorScheme,
            darkTextTheme,
            darkPalette,
          ),
          isNotNull,
        );
        expect(
          buildChipTheme(darkColorScheme, darkTextTheme, darkPalette),
          isNotNull,
        );
        expect(buildDividerTheme(darkPalette), isNotNull);
        expect(buildIconTheme(darkColorScheme), isNotNull);
        expect(buildNavigationRailTheme(darkTextTheme, darkPalette), isNotNull);
        expect(buildSwitchTheme(darkColorScheme, darkPalette), isNotNull);
      });

      test('all components use consistent border radius', () {
        final cardTheme = buildCardThemeData(lightColorScheme, lightPalette);
        final elevatedButtonTheme = buildElevatedButtonTheme(
          lightColorScheme,
          lightTextTheme,
        );
        final outlinedButtonTheme = buildOutlinedButtonTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );
        final chipTheme = buildChipTheme(
          lightColorScheme,
          lightTextTheme,
          lightPalette,
        );

        const expectedRadius = BorderRadius.all(Radius.circular(12));

        final cardShape = cardTheme.shape;
        expect(cardShape, isA<RoundedRectangleBorder>());
        expect(
          (cardShape! as RoundedRectangleBorder).borderRadius,
          equals(expectedRadius),
        );

        final elevatedShape = elevatedButtonTheme.style?.shape?.resolve({});
        expect(elevatedShape, isA<RoundedRectangleBorder>());
        expect(
          (elevatedShape! as RoundedRectangleBorder).borderRadius,
          equals(expectedRadius),
        );

        final outlinedShape = outlinedButtonTheme.style?.shape?.resolve({});
        expect(outlinedShape, isA<RoundedRectangleBorder>());
        expect(
          (outlinedShape! as RoundedRectangleBorder).borderRadius,
          equals(expectedRadius),
        );

        final chipShape = chipTheme.shape;
        expect(chipShape, isA<RoundedRectangleBorder>());
        expect(
          (chipShape! as RoundedRectangleBorder).borderRadius,
          equals(expectedRadius),
        );
      });
    });
  });
}
