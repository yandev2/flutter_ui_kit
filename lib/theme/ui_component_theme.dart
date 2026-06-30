import 'package:flutter/material.dart';

class UIComponentTheme extends ThemeExtension<UIComponentTheme> {
  // Base Colors
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color cardColor;
  final Color error;

  // Text Colors
  final Color onPrimary;
  final Color onSecondary;
  final Color onBackground;
  final Color onSurface;
  final Color onError;

  // Semantic Colors
  final Color success;
  final Color info;
  final Color warning;
  final Color danger;

  // Additional Component Colors
  final Color borderColor;
  final Color disabledColor;
  final Color hintColor;
  final Color shadowColor;

  // Spacing & Radius
  final double defaultPadding;
  final double defaultRadius;

  const UIComponentTheme({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.cardColor,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onBackground,
    required this.onSurface,
    required this.onError,
    required this.success,
    required this.info,
    required this.warning,
    required this.danger,
    required this.borderColor,
    required this.disabledColor,
    required this.hintColor,
    required this.shadowColor,
    required this.defaultPadding,
    required this.defaultRadius,
  });

  @override
  UIComponentTheme copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? cardColor,
    Color? error,
    Color? onPrimary,
    Color? onSecondary,
    Color? onBackground,
    Color? onSurface,
    Color? onError,
    Color? success,
    Color? info,
    Color? warning,
    Color? danger,
    Color? borderColor,
    Color? disabledColor,
    Color? hintColor,
    Color? shadowColor,
    double? defaultPadding,
    double? defaultRadius,
  }) {
    return UIComponentTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      cardColor: cardColor ?? this.cardColor,
      error: error ?? this.error,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
      onBackground: onBackground ?? this.onBackground,
      onSurface: onSurface ?? this.onSurface,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      borderColor: borderColor ?? this.borderColor,
      disabledColor: disabledColor ?? this.disabledColor,
      hintColor: hintColor ?? this.hintColor,
      shadowColor: shadowColor ?? this.shadowColor,
      defaultPadding: defaultPadding ?? this.defaultPadding,
      defaultRadius: defaultRadius ?? this.defaultRadius,
    );
  }

  @override
  UIComponentTheme lerp(ThemeExtension<UIComponentTheme>? other, double t) {
    if (other is! UIComponentTheme) {
      return this;
    }
    return UIComponentTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      error: Color.lerp(error, other.error, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      success: Color.lerp(success, other.success, t)!,
      info: Color.lerp(info, other.info, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      hintColor: Color.lerp(hintColor, other.hintColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      defaultPadding: lerpDouble(defaultPadding, other.defaultPadding, t)!,
      defaultRadius: lerpDouble(defaultRadius, other.defaultRadius, t)!,
    );
  }

  // helper function to interpolate double values safely
  double? lerpDouble(num? a, num? b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}
