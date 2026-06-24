import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

enum AppDialogVariant { success, error, info, warning }

class AppDialog extends StatelessWidget {
  final AppDialogVariant variant;
  final String title;
  final String description;
  final String? textLeft;
  final String? textRight;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;
  final Widget? content;
  final String? imageUrl;

  const AppDialog({
    super.key,
    this.variant = AppDialogVariant.info,
    required this.title,
    required this.description,
    this.textLeft,
    this.textRight,
    this.onLeft,
    this.onRight,
    this.content,
    this.imageUrl,
  });

  Color get _rightButtonColor {
    switch (variant) {
      case AppDialogVariant.success:
        return AppColors.success;
      case AppDialogVariant.error:
        return AppColors.error;
      case AppDialogVariant.warning:
        return AppColors.warning;
      case AppDialogVariant.info:
        return AppColors.primary;
    }
  }

  /// Helper untuk menampilkan dialog secara statis
  static void show({
    AppDialogVariant variant = AppDialogVariant.info,
    required String title,
    required String description,
    String? textLeft,
    String? textRight,
    VoidCallback? onLeft,
    VoidCallback? onRight,
    Widget? content,
    String? imageUrl,
    bool barrierDismissible = false,
  }) {
    Get.dialog(
      AppDialog(
        variant: variant,
        title: title,
        description: description,
        textLeft: textLeft,
        textRight: textRight,
        onLeft: onLeft,
        onRight: onRight,
        content: content,
        imageUrl: imageUrl,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic color for secondary button based on theme
    final Color secondaryBtnBg = Get.isDarkMode
        ? AppColors.neutral700
        : AppColors.neutral200;
    final Color secondaryBtnText = Get.isDarkMode
        ? AppColors.neutral300
        : AppColors.neutral700;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppScale.r(16)),
      ),
      backgroundColor: AppColors.surface,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: AppScale.w(24)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppScale.isDesktop ? 400 : double.infinity,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppScale.w(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null) ...[
                Center(
                  child: Image.network(
                    imageUrl!,
                    height: AppScale.h(140),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                ),
                SizedBox(height: AppScale.h(20)),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: AppScale.sp(20),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppScale.h(12)),
              Text(
                description,
                style: TextStyle(
                  fontSize: AppScale.sp(14),
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              if (content != null) ...[
                SizedBox(height: AppScale.h(20)),
                content!,
              ],
              SizedBox(height: AppScale.h(24)),
              Row(
                children: [
                  if (textLeft != null) ...[
                    Expanded(
                      child: TextButton(
                        onPressed: onLeft ?? () => Get.back(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AppScale.h(15),
                          ),
                          backgroundColor: secondaryBtnBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppScale.r(8)),
                          ),
                        ),
                        child: Text(
                          textLeft!,
                          style: TextStyle(
                            color: secondaryBtnText,
                            fontWeight: FontWeight.w600,
                            fontSize: AppScale.sp(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (textLeft != null && textRight != null)
                    SizedBox(width: AppScale.w(12)),
                  if (textRight != null) ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onRight,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AppScale.h(15),
                          ),
                          backgroundColor: _rightButtonColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppScale.r(8)),
                          ),
                        ),
                        child: Text(
                          textRight!,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: AppScale.sp(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
