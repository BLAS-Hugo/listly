import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.card,
    required this.onCard,
    required this.popover,
    required this.onPopover,
    required this.surfaceElevated,
    required this.muted,
    required this.onMuted,
    required this.accent,
    required this.onAccent,
    required this.success,
    required this.onSuccess,
    required this.destructive,
    required this.onDestructive,
    required this.border,
    required this.borderSubtle,
    required this.ring,
    required this.inputBackground,
    required this.switchBackground,
    required this.sidebar,
    required this.onSidebar,
    required this.sidebarPrimary,
    required this.onSidebarPrimary,
    required this.sidebarAccent,
    required this.onSidebarAccent,
    required this.sidebarBorder,
    required this.sidebarRing,
  });

  final Color card;
  final Color onCard;
  final Color popover;
  final Color onPopover;
  final Color surfaceElevated;
  final Color muted;
  final Color onMuted;
  final Color accent;
  final Color onAccent;
  final Color success;
  final Color onSuccess;
  final Color destructive;
  final Color onDestructive;
  final Color border;
  final Color borderSubtle;
  final Color ring;
  final Color inputBackground;
  final Color switchBackground;
  final Color sidebar;
  final Color onSidebar;
  final Color sidebarPrimary;
  final Color onSidebarPrimary;
  final Color sidebarAccent;
  final Color onSidebarAccent;
  final Color sidebarBorder;
  final Color sidebarRing;

  @override
  AppPalette copyWith({
    Color? card,
    Color? onCard,
    Color? popover,
    Color? onPopover,
    Color? surfaceElevated,
    Color? muted,
    Color? onMuted,
    Color? accent,
    Color? onAccent,
    Color? success,
    Color? onSuccess,
    Color? destructive,
    Color? onDestructive,
    Color? border,
    Color? borderSubtle,
    Color? ring,
    Color? inputBackground,
    Color? switchBackground,
    Color? sidebar,
    Color? onSidebar,
    Color? sidebarPrimary,
    Color? onSidebarPrimary,
    Color? sidebarAccent,
    Color? onSidebarAccent,
    Color? sidebarBorder,
    Color? sidebarRing,
  }) {
    return AppPalette(
      card: card ?? this.card,
      onCard: onCard ?? this.onCard,
      popover: popover ?? this.popover,
      onPopover: onPopover ?? this.onPopover,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      muted: muted ?? this.muted,
      onMuted: onMuted ?? this.onMuted,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      destructive: destructive ?? this.destructive,
      onDestructive: onDestructive ?? this.onDestructive,
      border: border ?? this.border,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      ring: ring ?? this.ring,
      inputBackground: inputBackground ?? this.inputBackground,
      switchBackground: switchBackground ?? this.switchBackground,
      sidebar: sidebar ?? this.sidebar,
      onSidebar: onSidebar ?? this.onSidebar,
      sidebarPrimary: sidebarPrimary ?? this.sidebarPrimary,
      onSidebarPrimary: onSidebarPrimary ?? this.onSidebarPrimary,
      sidebarAccent: sidebarAccent ?? this.sidebarAccent,
      onSidebarAccent: onSidebarAccent ?? this.onSidebarAccent,
      sidebarBorder: sidebarBorder ?? this.sidebarBorder,
      sidebarRing: sidebarRing ?? this.sidebarRing,
    );
  }

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      card: Color.lerp(card, other.card, t)!,
      onCard: Color.lerp(onCard, other.onCard, t)!,
      popover: Color.lerp(popover, other.popover, t)!,
      onPopover: Color.lerp(onPopover, other.onPopover, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      onMuted: Color.lerp(onMuted, other.onMuted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      onDestructive: Color.lerp(onDestructive, other.onDestructive, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      ring: Color.lerp(ring, other.ring, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      switchBackground: Color.lerp(
        switchBackground,
        other.switchBackground,
        t,
      )!,
      sidebar: Color.lerp(sidebar, other.sidebar, t)!,
      onSidebar: Color.lerp(onSidebar, other.onSidebar, t)!,
      sidebarPrimary: Color.lerp(sidebarPrimary, other.sidebarPrimary, t)!,
      onSidebarPrimary: Color.lerp(
        onSidebarPrimary,
        other.onSidebarPrimary,
        t,
      )!,
      sidebarAccent: Color.lerp(sidebarAccent, other.sidebarAccent, t)!,
      onSidebarAccent: Color.lerp(onSidebarAccent, other.onSidebarAccent, t)!,
      sidebarBorder: Color.lerp(sidebarBorder, other.sidebarBorder, t)!,
      sidebarRing: Color.lerp(sidebarRing, other.sidebarRing, t)!,
    );
  }

  static const AppPalette light = AppPalette(
    card: Color(0xFFFFFFFF),
    onCard: Color(0xFF1A1A1A),
    popover: Color(0xFFFFFFFF),
    onPopover: Color(0xFF1A1A1A),
    surfaceElevated: Color(0xFFFFFFFF),
    muted: Color(0xFFF5F5F5),
    onMuted: Color(0xFF616161),
    accent: Color(0xFFE0E0E0),
    onAccent: Color(0xFF1A1A1A),
    success: Color(0xFF2D7A3E),
    onSuccess: Color(0xFFFFFFFF),
    destructive: Color(0xFFD32F2F),
    onDestructive: Color(0xFFFFFFFF),
    border: Color(0xFFE0E0E0),
    borderSubtle: Color(0xFFEEEEEE),
    ring: Color(0xFF2D7A3E),
    inputBackground: Color(0xFFF5F5F5),
    switchBackground: Color(0xFFBDBDBD),
    sidebar: Color(0xFFFDFDFD),
    onSidebar: Color(0xFF242424),
    sidebarPrimary: Color(0xFF2D7A3E),
    onSidebarPrimary: Color(0xFFFFFFFF),
    sidebarAccent: Color(0xFFF5F5F5),
    onSidebarAccent: Color(0xFF343434),
    sidebarBorder: Color(0xFFE0E0E0),
    sidebarRing: Color(0xFF2D7A3E),
  );

  static const AppPalette dark = AppPalette(
    card: Color(0xFF1E1E1E),
    onCard: Color(0xFFE0E0E0),
    popover: Color(0xFF1E1E1E),
    onPopover: Color(0xFFE0E0E0),
    surfaceElevated: Color(0xFF252525),
    muted: Color(0xFF2C2C2C),
    onMuted: Color(0xFFB0B0B0),
    accent: Color(0xFF3D3D3D),
    onAccent: Color(0xFFE0E0E0),
    success: Color(0xFF4CAF50),
    onSuccess: Color(0xFFFFFFFF),
    destructive: Color(0xFFEF5350),
    onDestructive: Color(0xFFFFFFFF),
    border: Color(0xFF3D3D3D),
    borderSubtle: Color(0xFF2C2C2C),
    ring: Color(0xFF4CAF50),
    inputBackground: Color(0xFF2C2C2C),
    switchBackground: Color(0xFF616161),
    sidebar: Color(0xFF1E1E1E),
    onSidebar: Color(0xFFE0E0E0),
    sidebarPrimary: Color(0xFF4CAF50),
    onSidebarPrimary: Color(0xFFFFFFFF),
    sidebarAccent: Color(0xFF2C2C2C),
    onSidebarAccent: Color(0xFFE0E0E0),
    sidebarBorder: Color(0xFF3D3D3D),
    sidebarRing: Color(0xFF4CAF50),
  );
}

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF2D7A3E),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFE8F5E9),
  onPrimaryContainer: Color(0xFF1B5E20),
  secondary: Color(0xFFF57C00),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFE0B2),
  onSecondaryContainer: Color(0xFF4A2800),
  tertiary: Color(0xFF1976D2),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFD1E4FF),
  onTertiaryContainer: Color(0xFF001C3B),
  error: Color(0xFFD32F2F),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF1A1A1A),
  onSurfaceVariant: Color(0xFF616161),
  outline: Color(0xFFE0E0E0),
  outlineVariant: Color(0xFFEEEEEE),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF2C2C2C),
  onInverseSurface: Color(0xFFF0F0F0),
  inversePrimary: Color(0xFF4CAF50),
  surfaceTint: Color(0xFF2D7A3E),
  surfaceDim: Color(0xFFF0F0F0),
  surfaceBright: Color(0xFFFFFFFF),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF7F7F7),
  surfaceContainer: Color(0xFFF3F3F3),
  surfaceContainerHigh: Color(0xFFEEEEEE),
  surfaceContainerHighest: Color(0xFFE9E9E9),
);

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4CAF50),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF1B3A1F),
  onPrimaryContainer: Color(0xFFC8E6C9),
  secondary: Color(0xFFFF9800),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFB74D),
  onSecondaryContainer: Color(0xFF321600),
  tertiary: Color(0xFF42A5F5),
  onTertiary: Color(0xFF001F3B),
  tertiaryContainer: Color(0xFF0D2A45),
  onTertiaryContainer: Color(0xFFCFE4FF),
  error: Color(0xFFEF5350),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF1E1E1E),
  onSurface: Color(0xFFE0E0E0),
  onSurfaceVariant: Color(0xFFB0B0B0),
  outline: Color(0xFF3D3D3D),
  outlineVariant: Color(0xFF2C2C2C),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFE0E0E0),
  onInverseSurface: Color(0xFF1A1A1A),
  inversePrimary: Color(0xFF2D7A3E),
  surfaceTint: Color(0xFF4CAF50),
  surfaceDim: Color(0xFF121212),
  surfaceBright: Color(0xFF2A2A2A),
  surfaceContainerLowest: Color(0xFF0D0D0D),
  surfaceContainerLow: Color(0xFF1A1A1A),
  surfaceContainer: Color(0xFF202020),
  surfaceContainerHigh: Color(0xFF252525),
  surfaceContainerHighest: Color(0xFF2C2C2C),
);
