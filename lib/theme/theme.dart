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

  // Main Light Theme
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.cardLight,
      disabledColor: AppColors.disabledLight,
      hintColor: AppColors.hintLight,
      dividerColor: AppColors.borderLight,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.onBackgroundLight,
        displayColor: AppColors.onBackgroundLight,
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        error: AppColors.errorLight,
        surface: AppColors.surfaceLight,
      ),
      extensions: <ThemeExtension<dynamic>>[defaultUIComponentThemeLight],
    );
  }

  // Main Dark Theme
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardDark,
      disabledColor: AppColors.disabledDark,
      hintColor: AppColors.hintDark,
      dividerColor: AppColors.borderDark,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.onBackgroundDark,
        displayColor: AppColors.onBackgroundDark,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        error: AppColors.errorDark,
        surface: AppColors.surfaceDark,
      ),
      extensions: <ThemeExtension<dynamic>>[defaultUIComponentThemeDark],
    );
  }
}

// Extension on BuildContext for easier access
extension UIComponentThemeExtension on BuildContext {
  UIComponentTheme get uiTheme => Theme.of(this).extension<UIComponentTheme>()!;
}
