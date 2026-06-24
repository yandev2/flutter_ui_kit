import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:heroicons/heroicons.dart';

class AppCardStyle13 extends StatelessWidget {
  final String? imageUrl;
  final HeroIcons? floatingIcon;
  final Color? floatingIconColor;
  final Color? floatingIconBgColor;
  
  final String? title;
  final String? subtitle;
  final bool isVerified;
  
  final double? progress;
  final Color? progressColor;
  final String? targetText;
  final String? percentageText;
  
  final double? width;
  final bool isLoading;
  final VoidCallback? onTap;
  final VoidCallback? onFloatingIconTap;

  const AppCardStyle13({
    super.key,
    this.imageUrl,
    this.floatingIcon,
    this.floatingIconColor,
    this.floatingIconBgColor,
    this.title,
    this.subtitle,
    this.isVerified = false,
    this.progress,
    this.progressColor,
    this.targetText,
    this.percentageText,
    this.width,
    this.isLoading = false,
    this.onTap,
    this.onFloatingIconTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? AppScale.w(280);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final borderColor = isDark ? AppColors.border : AppColors.neutral200;
    final activeProgressColor = progressColor ?? AppColors.primary;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Skeletonizer(
        enabled: isLoading,
        child: Container(
          width: cardWidth,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppScale.r(16)),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: isDark
                ? []
                : [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Section
              Stack(
                children: [
                  if (imageUrl != null)
                    Skeleton.leaf(
                      child: AppImage(
                        imageUrl: imageUrl!,
                        width: double.infinity,
                        height: AppScale.h(160),
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Skeleton.leaf(
                      child: Container(
                        width: double.infinity,
                        height: AppScale.h(160),
                        color: AppColors.neutral200,
                      ),
                    ),
                    
                  if (floatingIcon != null)
                    Positioned(
                      top: AppScale.h(12),
                      right: AppScale.w(12),
                      child: GestureDetector(
                        onTap: isLoading ? null : onFloatingIconTap,
                        child: Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.icon(size: AppScale.w(40)),
                          child: Container(
                            width: AppScale.w(40),
                            height: AppScale.w(40),
                            decoration: BoxDecoration(
                              color: floatingIconBgColor ?? AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Center(
                              child: HeroIcon(
                                floatingIcon!,
                                style: HeroIconStyle.solid,
                                size: AppScale.w(20),
                                color: floatingIconColor ?? AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              
              // Content Section
              Padding(
                padding: EdgeInsets.all(AppScale.w(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Skeleton.replace(
                        replace: isLoading,
                        replacement: Bone.text(words: 3),
                        child: Text(
                          title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppScale.sp(16),
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1.3,
                          ),
                        ),
                      ),
                    if (subtitle != null || isVerified) ...[
                      SizedBox(height: AppScale.h(6)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (subtitle != null)
                            Expanded(
                              child: Skeleton.replace(
                                replace: isLoading,
                                replacement: Bone.text(words: 2),
                                child: Text(
                                  subtitle!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(13),
                                    color: subtitleColor,
                                  ),
                                ),
                              ),
                            ),
                          if (subtitle != null && isVerified)
                            SizedBox(width: AppScale.w(4)),
                          if (isVerified)
                            Skeleton.replace(
                              replace: isLoading,
                              replacement: Bone.icon(size: AppScale.w(14)),
                              child: Icon(
                                Icons.check_circle,
                                size: AppScale.w(14),
                                color: AppColors.warning,
                              ),
                            ),
                        ],
                      ),
                    ],
                    
                    if (progress != null || targetText != null || percentageText != null) ...[
                      SizedBox(height: AppScale.h(16)),
                      if (progress != null)
                        Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.text(words: 1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppScale.r(4)),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: activeProgressColor.withValues(alpha: 0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(activeProgressColor),
                              minHeight: AppScale.h(4),
                            ),
                          ),
                        ),
                      if (targetText != null || percentageText != null) ...[
                        SizedBox(height: AppScale.h(8)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (targetText != null)
                              Expanded(
                                child: Skeleton.replace(
                                  replace: isLoading,
                                  replacement: Bone.text(words: 2),
                                  child: Text(
                                    targetText!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: AppScale.sp(12),
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ),
                            if (percentageText != null)
                              Skeleton.replace(
                                replace: isLoading,
                                replacement: Bone.text(words: 1),
                                child: Text(
                                  percentageText!,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(12),
                                    fontWeight: FontWeight.bold,
                                    color: activeProgressColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
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
