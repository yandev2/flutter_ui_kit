import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppQuickAction extends StatelessWidget {
  final HeroIcons? icon;
  final Widget? customIcon;
  final String label;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool isLoading;

  final double? size;
  final double? iconSize;
  final double? fontSize;
  final double? borderRadius;

  const AppQuickAction({
    super.key,
    this.icon,
    this.customIcon,
    required this.label,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.isLoading = false,
    this.size,
    this.iconSize,
    this.fontSize,
    this.borderRadius,
  }) : assert(icon != null || customIcon != null, 'Either icon or customIcon must be provided');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final defaultBgColor = isDark 
        ? AppColors.white.withValues(alpha: 0.1) 
        : AppColors.neutral100;
        
    final effectiveBgColor = backgroundColor ?? defaultBgColor;
    final effectiveIconColor = iconColor ?? (isDark ? AppColors.white : AppColors.neutral800);
    final effectiveTextColor = isDark ? AppColors.neutral200 : AppColors.neutral800;

    final containerSize = size ?? AppScale.w(64);
    final effectiveIconSize = iconSize ?? AppScale.w(28);
    final effectiveFontSize = fontSize ?? AppScale.sp(12);
    final effectiveBorderRadius = borderRadius ?? AppScale.r(20);

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Skeleton.replace(
            replace: isLoading,
            replacement: Bone.square(
              size: containerSize,
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
            child: Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                color: effectiveBgColor,
                borderRadius: BorderRadius.circular(effectiveBorderRadius),
              ),
              child: Center(
                child: customIcon ?? HeroIcon(
                  icon!,
                  style: HeroIconStyle.solid,
                  size: effectiveIconSize,
                  color: effectiveIconColor,
                ),
              ),
            ),
          ),
          SizedBox(height: AppScale.h(8)),
          Skeleton.replace(
            replace: isLoading,
            replacement: Bone.text(words: 1),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: effectiveFontSize,
                fontWeight: FontWeight.w600,
                color: effectiveTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
