import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  // Brand Colors
  static Color primary = const Color(0xFF4A3AFF);
  static Color primaryDark = const Color(0xFF3829E0);
  
  // Status Colors
  static Color success = const Color(0xFF22C55E);
  static Color error = const Color(0xFFEF4444);
  static Color warning = const Color(0xFFF59E0B);
  static Color info = const Color(0xFF3B82F6);

  // Neutral Colors
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color neutral100 = const Color(0xFFF3F4F6);
  static Color neutral200 = const Color(0xFFE5E7EB);
  static Color neutral300 = const Color(0xFFD1D5DB);
  static Color neutral400 = const Color(0xFF9CA3AF);
  static Color neutral500 = const Color(0xFF6B7280);
  static Color neutral600 = const Color(0xFF4B5563);
  static Color neutral700 = const Color(0xFF374151);
  static Color neutral800 = const Color(0xFF1F2937);
  static Color neutral900 = const Color(0xFF111827);

  static void overrideColors({
    Color? primary,
    Color? primaryDark,
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
  }) {
    if (primary != null) AppColors.primary = primary;
    if (primaryDark != null) AppColors.primaryDark = primaryDark;
    if (success != null) AppColors.success = success;
    if (error != null) AppColors.error = error;
    if (warning != null) AppColors.warning = warning;
    if (info != null) AppColors.info = info;
    if (white != null) AppColors.white = white;
    if (black != null) AppColors.black = black;
    if (neutral100 != null) AppColors.neutral100 = neutral100;
    if (neutral200 != null) AppColors.neutral200 = neutral200;
    if (neutral300 != null) AppColors.neutral300 = neutral300;
    if (neutral400 != null) AppColors.neutral400 = neutral400;
    if (neutral500 != null) AppColors.neutral500 = neutral500;
    if (neutral600 != null) AppColors.neutral600 = neutral600;
    if (neutral700 != null) AppColors.neutral700 = neutral700;
    if (neutral800 != null) AppColors.neutral800 = neutral800;
    if (neutral900 != null) AppColors.neutral900 = neutral900;
  }

  // === RESPONSIVE COLORS (GetX Getters) ===
  // Automatically switches based on current theme
  
  static Color get background => Get.isDarkMode ? const Color(0xFF111827) : const Color(0xFFF3F4F6);
  static Color get surface => Get.isDarkMode ? const Color(0xFF1F2937) : const Color(0xFFFFFFFF);
  
  static Color get textPrimary => Get.isDarkMode ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
  static Color get textSecondary => Get.isDarkMode ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
  
  static Color get border => Get.isDarkMode ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
  static Color get divider => Get.isDarkMode ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);
}
