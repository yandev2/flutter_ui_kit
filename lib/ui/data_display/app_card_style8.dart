import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';

class AppCardStyle8 extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final Color? subtitleColor;
  final String? description;
  final VoidCallback? onTap;
  final double? width;
  final double? logoSize;
  final bool isMax;
  final bool isLoading;

  const AppCardStyle8({
    super.key,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.subtitleColor,
    this.description,
    this.onTap,
    this.width,
    this.logoSize,
    this.isMax = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(320));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoSide = logoSize ?? AppScale.w(48);

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final mutedColor =
        subtitleColor ?? (isDark ? AppColors.neutral400 : AppColors.neutral500);
    final bodyColor = isDark ? AppColors.neutral300 : AppColors.neutral700;

    final hasText = title != null || subtitle != null || description != null;

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: cardWidth,
          padding: EdgeInsets.all(AppScale.w(20)),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppScale.r(16)),
            border: isDark
                ? Border.all(color: AppColors.border, width: 1)
                : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.06),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null) ...[
                Skeleton.leaf(
                  child: AppImage(
                    imageUrl: imageUrl!,
                    width: logoSide,
                    height: logoSide,
                    borderRadius: BorderRadius.circular(AppScale.r(12)),
                    fit: BoxFit.cover,
                  ),
                ),
                if (hasText) SizedBox(width: AppScale.w(16)),
              ],
              if (hasText)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppScale.sp(16),
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      if (title != null && subtitle != null)
                        SizedBox(height: AppScale.h(4)),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppScale.sp(13),
                            color: mutedColor,
                          ),
                        ),
                      if (subtitle != null && description != null)
                        SizedBox(height: AppScale.h(10)),
                      if (title != null &&
                          subtitle == null &&
                          description != null)
                        SizedBox(height: AppScale.h(8)),
                      if (description != null)
                        Text(
                          description!,
                          style: TextStyle(
                            fontSize: AppScale.sp(14),
                            color: bodyColor,
                            height: 1.5,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
