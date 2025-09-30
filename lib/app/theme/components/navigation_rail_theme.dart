import 'package:flutter/material.dart';
import 'package:listly/app/theme/colors.dart';

NavigationRailThemeData buildNavigationRailTheme(
  TextTheme textTheme,
  AppPalette palette,
) {
  return NavigationRailThemeData(
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
  );
}
