import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF4A3AFF);
  static const Color primaryDark = Color(0xFF3829E0);
  
  // Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  // === RESPONSIVE COLORS (GetX Getters) ===
  // Automatically switches based on current theme
  
  static Color get background => Get.isDarkMode ? const Color(0xFF111827) : const Color(0xFFFFFFFF);
  static Color get surface => Get.isDarkMode ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);
  
  static Color get textPrimary => Get.isDarkMode ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
  static Color get textSecondary => Get.isDarkMode ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
  
  static Color get border => Get.isDarkMode ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
  static Color get divider => Get.isDarkMode ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);
}
