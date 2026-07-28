import 'package:flutter/material.dart';
import 'app_scale.dart';

class AppTypography {
  /// Text theme dengan ukuran desain tetap (aman sebelum [AppScaleInit]).
  static TextTheme get textTheme => _buildTextTheme();

  /// Text theme responsif — panggil setelah [AppScaleInit] / [ScreenUtilInit].
  static TextTheme textThemeFor(BuildContext context) =>
      _buildTextTheme(context);

  static TextTheme _buildTextTheme([BuildContext? context]) => TextTheme(
        displayLarge: _displayLarge(context),
        displayMedium: _displayMedium(context),
        displaySmall: _displaySmall(context),
        headlineLarge: _headlineLarge(context),
        headlineMedium: _headlineMedium(context),
        headlineSmall: _headlineSmall(context),
        titleLarge: _titleLarge(context),
        titleMedium: _titleMedium(context),
        titleSmall: _titleSmall(context),
        bodyLarge: _bodyLarge(context),
        bodyMedium: _bodyMedium(context),
        bodySmall: _bodySmall(context),
        labelLarge: _labelLarge(context),
        labelMedium: _labelMedium(context),
        labelSmall: _labelSmall(context),
      );

  static TextStyle _displayLarge([BuildContext? context]) => TextStyle(
        fontSize: size(57, context),
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      );

  static TextStyle _displayMedium([BuildContext? context]) => TextStyle(
        fontSize: size(45, context),
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle _displaySmall([BuildContext? context]) => TextStyle(
        fontSize: size(36, context),
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle _headlineLarge([BuildContext? context]) => TextStyle(
        fontSize: size(32, context),
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle _headlineMedium([BuildContext? context]) => TextStyle(
        fontSize: size(28, context),
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle _headlineSmall([BuildContext? context]) => TextStyle(
        fontSize: size(24, context),
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle _titleLarge([BuildContext? context]) => TextStyle(
        fontSize: size(22, context),
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      );

  static TextStyle _titleMedium([BuildContext? context]) => TextStyle(
        fontSize: size(16, context),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  static TextStyle _titleSmall([BuildContext? context]) => TextStyle(
        fontSize: size(14, context),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );

  static TextStyle _bodyLarge([BuildContext? context]) => TextStyle(
        fontSize: size(16, context),
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );

  static TextStyle _bodyMedium([BuildContext? context]) => TextStyle(
        fontSize: size(14, context),
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );

  static TextStyle _bodySmall([BuildContext? context]) => TextStyle(
        fontSize: size(12, context),
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      );

  static TextStyle _labelLarge([BuildContext? context]) => TextStyle(
        fontSize: size(14, context),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );

  static TextStyle _labelMedium([BuildContext? context]) => TextStyle(
        fontSize: size(12, context),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      );

  static TextStyle _labelSmall([BuildContext? context]) => TextStyle(
        fontSize: size(11, context),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      );

  // Backward-compatible aliases
  static TextStyle get displayLarge => _displayLarge();
  static TextStyle get displayMedium => _displayMedium();
  static TextStyle get displaySmall => _displaySmall();
  static TextStyle get headlineLarge => _headlineLarge();
  static TextStyle get headlineMedium => _headlineMedium();
  static TextStyle get headlineSmall => _headlineSmall();
  static TextStyle get titleLarge => _titleLarge();
  static TextStyle get titleMedium => _titleMedium();
  static TextStyle get titleSmall => _titleSmall();
  static TextStyle get bodyLarge => _bodyLarge();
  static TextStyle get bodyMedium => _bodyMedium();
  static TextStyle get bodySmall => _bodySmall();
  static TextStyle get labelLarge => _labelLarge();
  static TextStyle get labelMedium => _labelMedium();
  static TextStyle get labelSmall => _labelSmall();
}
