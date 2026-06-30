import 'package:flutter/material.dart';
import 'app_scale.dart';

class AppTypography {
  static TextStyle get displayLarge => TextStyle(
    fontSize: size(57),
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static TextStyle get displayMedium => TextStyle(
    fontSize: size(45),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle get displaySmall => TextStyle(
    fontSize: size(36),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle get headlineLarge => TextStyle(
    fontSize: size(32),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontSize: size(28),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle get headlineSmall => TextStyle(
    fontSize: size(24),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle get titleLarge => TextStyle(
    fontSize: size(22),
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  static TextStyle get titleMedium => TextStyle(
    fontSize: size(16),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static TextStyle get titleSmall => TextStyle(
    fontSize: size(14),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontSize: size(16),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: size(14),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: size(12),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static TextStyle get labelLarge => TextStyle(
    fontSize: size(14),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: size(12),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: size(11),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
