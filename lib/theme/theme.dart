import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color success;
  final Color error;
  final Color warning;
  final Color info;
  final Color white;
  final Color black;
  final Color neutral100;
  final Color neutral200;
  final Color neutral300;
  final Color neutral400;
  final Color neutral500;
  final Color neutral600;
  final Color neutral700;
  final Color neutral800;
  final Color neutral900;
  final Color divider;

  const AppColorsExtension({
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.white,
    required this.black,
    required this.neutral100,
    required this.neutral200,
    required this.neutral300,
    required this.neutral400,
    required this.neutral500,
    required this.neutral600,
    required this.neutral700,
    required this.neutral800,
    required this.neutral900,
    required this.divider,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
    Color? white,
    Color? black,
    Color? neutral100,
    Color? neutral200,
    Color? neutral300,
    Color? neutral400,
    Color? neutral500,
    Color? neutral600,
    Color? neutral700,
    Color? neutral800,
    Color? neutral900,
    Color? divider,
  }) {
    return AppColorsExtension(
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      white: white ?? this.white,
      black: black ?? this.black,
      neutral100: neutral100 ?? this.neutral100,
      neutral200: neutral200 ?? this.neutral200,
      neutral300: neutral300 ?? this.neutral300,
      neutral400: neutral400 ?? this.neutral400,
      neutral500: neutral500 ?? this.neutral500,
      neutral600: neutral600 ?? this.neutral600,
      neutral700: neutral700 ?? this.neutral700,
      neutral800: neutral800 ?? this.neutral800,
      neutral900: neutral900 ?? this.neutral900,
      divider: divider ?? this.divider,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      neutral100: Color.lerp(neutral100, other.neutral100, t)!,
      neutral200: Color.lerp(neutral200, other.neutral200, t)!,
      neutral300: Color.lerp(neutral300, other.neutral300, t)!,
      neutral400: Color.lerp(neutral400, other.neutral400, t)!,
      neutral500: Color.lerp(neutral500, other.neutral500, t)!,
      neutral600: Color.lerp(neutral600, other.neutral600, t)!,
      neutral700: Color.lerp(neutral700, other.neutral700, t)!,
      neutral800: Color.lerp(neutral800, other.neutral800, t)!,
      neutral900: Color.lerp(neutral900, other.neutral900, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}

class AppColors {
  static Color get primary => Get.theme.colorScheme.primary;
  static Color get primaryDark => Get.theme.colorScheme.secondary;
  
  static Color get success => Get.theme.extension<AppColorsExtension>()!.success;
  static Color get error => Get.theme.colorScheme.error;
  static Color get warning => Get.theme.extension<AppColorsExtension>()!.warning;
  static Color get info => Get.theme.extension<AppColorsExtension>()!.info;

  static Color get white => Get.theme.extension<AppColorsExtension>()!.white;
  static Color get black => Get.theme.extension<AppColorsExtension>()!.black;
  static Color get neutral100 => Get.theme.extension<AppColorsExtension>()!.neutral100;
  static Color get neutral200 => Get.theme.extension<AppColorsExtension>()!.neutral200;
  static Color get neutral300 => Get.theme.extension<AppColorsExtension>()!.neutral300;
  static Color get neutral400 => Get.theme.extension<AppColorsExtension>()!.neutral400;
  static Color get neutral500 => Get.theme.extension<AppColorsExtension>()!.neutral500;
  static Color get neutral600 => Get.theme.extension<AppColorsExtension>()!.neutral600;
  static Color get neutral700 => Get.theme.extension<AppColorsExtension>()!.neutral700;
  static Color get neutral800 => Get.theme.extension<AppColorsExtension>()!.neutral800;
  static Color get neutral900 => Get.theme.extension<AppColorsExtension>()!.neutral900;

  static Color get background => Get.theme.scaffoldBackgroundColor;
  static Color get surface => Get.theme.colorScheme.surface;
  
  static Color get textPrimary => Get.theme.colorScheme.onSurface;
  static Color get textSecondary => Get.theme.colorScheme.onSurfaceVariant;
  
  static Color get border => Get.theme.colorScheme.outline;
  static Color get divider => Get.theme.extension<AppColorsExtension>()!.divider;
}

class AppTheme {
  // Constants used for generating themes
  static const Color _primary = Color(0xFF4A3AFF);
  static const Color _primaryDark = Color(0xFF3829E0);
  static const Color _success = Color(0xFF22C55E);
  static const Color _error = Color(0xFFEF4444);
  static const Color _warning = Color(0xFFF59E0B);
  static const Color _info = Color(0xFF3B82F6);

  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF000000);
  static const Color _neutral100 = Color(0xFFF3F4F6);
  static const Color _neutral200 = Color(0xFFE5E7EB);
  static const Color _neutral300 = Color(0xFFD1D5DB);
  static const Color _neutral400 = Color(0xFF9CA3AF);
  static const Color _neutral500 = Color(0xFF6B7280);
  static const Color _neutral600 = Color(0xFF4B5563);
  static const Color _neutral700 = Color(0xFF374151);
  static const Color _neutral800 = Color(0xFF1F2937);
  static const Color _neutral900 = Color(0xFF111827);

  static final AppColorsExtension _lightAppColors = AppColorsExtension(
    success: _success,
    error: _error,
    warning: _warning,
    info: _info,
    white: _white,
    black: _black,
    neutral100: _neutral100,
    neutral200: _neutral200,
    neutral300: _neutral300,
    neutral400: _neutral400,
    neutral500: _neutral500,
    neutral600: _neutral600,
    neutral700: _neutral700,
    neutral800: _neutral800,
    neutral900: _neutral900,
    divider: const Color(0xFFF3F4F6),
  );

  static final AppColorsExtension _darkAppColors = AppColorsExtension(
    success: _success,
    error: _error,
    warning: _warning,
    info: _info,
    white: _white,
    black: _black,
    neutral100: _neutral100,
    neutral200: _neutral200,
    neutral300: _neutral300,
    neutral400: _neutral400,
    neutral500: _neutral500,
    neutral600: _neutral600,
    neutral700: _neutral700,
    neutral800: _neutral800,
    neutral900: _neutral900,
    divider: const Color(0xFF1F2937),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _primary,
      scaffoldBackgroundColor: const Color(0xFFF3F4F6),
      colorScheme: const ColorScheme.light(
        primary: _primary,
        secondary: _primaryDark,
        surface: Color(0xFFFFFFFF),
        error: _error,
        onSurface: Color(0xFF111827),
        onSurfaceVariant: Color(0xFF6B7280),
        outline: Color(0xFFE5E7EB),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        foregroundColor: Color(0xFF111827),
        elevation: 0,
      ),
      fontFamily: 'Inter',
      useMaterial3: true,
      extensions: <ThemeExtension<dynamic>>[
        _lightAppColors,
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _primary,
      scaffoldBackgroundColor: const Color(0xFF111827),
      colorScheme: const ColorScheme.dark(
        primary: _primary,
        secondary: _primaryDark,
        surface: Color(0xFF1F2937),
        error: _error,
        onSurface: Color(0xFFF9FAFB),
        onSurfaceVariant: Color(0xFF9CA3AF),
        outline: Color(0xFF374151),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF111827),
        foregroundColor: Color(0xFFF9FAFB),
        elevation: 0,
      ),
      fontFamily: 'Inter',
      useMaterial3: true,
      extensions: <ThemeExtension<dynamic>>[
        _darkAppColors,
      ],
    );
  }
}
