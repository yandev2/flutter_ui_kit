import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

enum AppSnackbarType { normal, success, error, warning }

class AppSnackbar {
  static void show({
    required String title,
    String? subtitle,
    Widget? icon,
    AppSnackbarType type = AppSnackbarType.normal,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color? iconColor;
    Widget? defaultIcon;

    // Define default icons and colors based on type
    switch (type) {
      case AppSnackbarType.success:
        iconColor = AppColors.success;
        defaultIcon = HeroIcon(
          HeroIcons.checkCircle,
          color: iconColor,
          style: HeroIconStyle.outline,
        );
        break;
      case AppSnackbarType.error:
        iconColor = AppColors.error;
        defaultIcon = HeroIcon(
          HeroIcons.exclamationCircle,
          color: iconColor,
          style: HeroIconStyle.outline,
        );
        break;
      case AppSnackbarType.warning:
        iconColor = AppColors.warning;
        defaultIcon = HeroIcon(
          HeroIcons.exclamationTriangle,
          color: iconColor,
          style: HeroIconStyle.outline,
        );
        break;
      case AppSnackbarType.normal:
        break;
    }

    final Widget finalIcon = icon ?? defaultIcon ?? const SizedBox.shrink();
    final bool hasIcon = finalIcon is! SizedBox;

    final Color bgColor = Get.isDarkMode
        ? const Color(0xFF2D303E)
        : AppColors.white;
    final Color textColor = Get.isDarkMode
        ? AppColors.white
        : AppColors.neutral900;
    final Color subtitleColor = Get.isDarkMode
        ? AppColors.neutral300
        : AppColors.neutral500;

    Get.rawSnackbar(
      messageText: Row(
        crossAxisAlignment: subtitle != null
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          if (hasIcon) ...[finalIcon, SizedBox(width: AppScale.w(12))],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: AppScale.sp(14),
                    fontWeight: subtitle != null
                        ? FontWeight.bold
                        : FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: AppScale.h(4)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: AppScale.sp(12),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null) ...[
            SizedBox(width: AppScale.w(12)),
            GestureDetector(
              onTap: () {
                Get.closeCurrentSnackbar();
                if (onAction != null) onAction();
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppScale.h(4)),
                child: Text(
                  actionLabel,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppScale.sp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      backgroundColor: bgColor,
      padding: EdgeInsets.symmetric(
        horizontal: AppScale.w(16),
        vertical: AppScale.h(16),
      ),
      margin: EdgeInsets.all(AppScale.w(16)),
      borderRadius: AppScale.r(12),
      snackPosition: SnackPosition.TOP,
      boxShadows: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      duration: duration,
      animationDuration: const Duration(milliseconds: 300),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
    );
  }

  // Helper methods for quick access
  static void success({
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.success,
      duration: duration,
    );
  }

  static void info({
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.normal,
      icon: HeroIcon(
        HeroIcons.informationCircle,
        color: AppColors.info,
        style: HeroIconStyle.outline,
      ),
      duration: duration,
    );
  }

  static void warning({
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.warning,
      duration: duration,
    );
  }

  static void error({
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.error,
      duration: duration,
    );
  }
}
