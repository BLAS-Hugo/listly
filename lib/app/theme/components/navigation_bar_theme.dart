import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';

NavigationBarThemeData buildNavigationBarTheme(
  TextTheme textTheme,
  ColorScheme colorScheme,
  AppPalette palette,
) {
  final baseLabelStyle =
      textTheme.labelSmall ?? const TextStyle(fontSize: 12, height: 1.2);

  TextStyle labelStyle(Set<WidgetState> states) {
    final isSelected = states.contains(WidgetState.selected);
    return baseLabelStyle.copyWith(
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      letterSpacing: 0.24,
      color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
    );
  }

  IconThemeData iconTheme(Set<WidgetState> states) {
    final isSelected = states.contains(WidgetState.selected);
    return IconThemeData(
      size: 24,
      color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
    );
  }

  return NavigationBarThemeData(
    height: 80,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shadowColor: Colors.transparent,
    indicatorColor: colorScheme.primaryContainer,
    indicatorShape: const StadiumBorder(),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    iconTheme: WidgetStateProperty.resolveWith(iconTheme),
    labelTextStyle: WidgetStateProperty.resolveWith(labelStyle),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return colorScheme.primary.withValues(alpha: 0.12);
      }
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.focused)) {
        return colorScheme.primary.withValues(alpha: 0.08);
      }
      return Colors.transparent;
    }),
  );
}
