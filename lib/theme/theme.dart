import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';
import 'ui_component_theme.dart';

export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_typography.dart';
export 'ui_component_theme.dart';
export 'app_scale.dart';

class AppTheme {
  // Light Theme Instance
  static final UIComponentTheme defaultUIComponentThemeLight = UIComponentTheme(
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    cardColor: AppColors.cardLight,
    error: AppColors.errorLight,
    onPrimary: AppColors.onPrimaryLight,
    onSecondary: AppColors.onSecondaryLight,
    onBackground: AppColors.onBackgroundLight,
    onSurface: AppColors.onSurfaceLight,
    onError: AppColors.onErrorLight,
    success: AppColors.successLight,
    info: AppColors.infoLight,
    warning: AppColors.warningLight,
    danger: AppColors.dangerLight,
    borderColor: AppColors.borderLight,
    disabledColor: AppColors.disabledLight,
    hintColor: AppColors.hintLight,
    shadowColor: AppColors.shadowLight,
    defaultPadding: AppSpacing.md,
    defaultRadius: AppRadius.md,
  );

  // Dark Theme Instance
  static final UIComponentTheme defaultUIComponentThemeDark = UIComponentTheme(
    primary: AppColors.primaryDark,
    secondary: AppColors.secondaryDark,
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    cardColor: AppColors.cardDark,
    error: AppColors.errorDark,
    onPrimary: AppColors.onPrimaryDark,
    onSecondary: AppColors.onSecondaryDark,
    onBackground: AppColors.onBackgroundDark,
    onSurface: AppColors.onSurfaceDark,
    onError: AppColors.onErrorDark,
    success: AppColors.successDark,
    info: AppColors.infoDark,
    warning: AppColors.warningDark,
    danger: AppColors.dangerDark,
    borderColor: AppColors.borderDark,
    disabledColor: AppColors.disabledDark,
    hintColor: AppColors.hintDark,
    shadowColor: AppColors.shadowDark,
    defaultPadding: AppSpacing.md,
    defaultRadius: AppRadius.md,
  );

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primaryLight,
    onPrimary: AppColors.onPrimaryLight,
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.onSecondaryLight,
    error: AppColors.errorLight,
    onError: AppColors.onErrorLight,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onSurfaceLight,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryDark,
    onPrimary: AppColors.onPrimaryDark,
    secondary: AppColors.secondaryDark,
    onSecondary: AppColors.onSecondaryDark,
    error: AppColors.errorDark,
    onError: AppColors.onErrorDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
  );

  // Main Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.onBackgroundLight,
        displayColor: AppColors.onBackgroundLight,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.onPrimaryLight,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.onPrimaryLight),
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.onPrimaryLight,
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.onPrimaryLight,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.onSurfaceLight,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[defaultUIComponentThemeLight],
    );
  }

  // Main Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: _darkColorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.onBackgroundDark,
        displayColor: AppColors.onBackgroundDark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.onPrimaryDark,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.onPrimaryDark),
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.onPrimaryDark,
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.onPrimaryDark,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.onSurfaceDark,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[defaultUIComponentThemeDark],
    );
  }
}

// Extension on BuildContext for easier access
extension UIComponentThemeExtension on BuildContext {
  UIComponentTheme get uiTheme {
    final extension = Theme.of(this).extension<UIComponentTheme>();
    if (extension != null) return extension;
    return Theme.of(this).brightness == Brightness.dark
        ? AppTheme.defaultUIComponentThemeDark
        : AppTheme.defaultUIComponentThemeLight;
  }
}
