import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppCardStyle15 extends StatelessWidget {
  final String imageUrl;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeBackgroundColor;
  final String avatarUrl;
  final String authorName;
  final bool isVerified;
  final String title;
  final double progress;
  final Color? progressColor;
  final String amountRaisedLabel;
  final String amountRaisedValue;
  final String buttonText;
  final Color? buttonColor;
  final VoidCallback? onButtonTap;
  final double? width;
  final bool isLoading;

  const AppCardStyle15({
    super.key,
    required this.imageUrl,
    this.badgeText,
    this.badgeColor,
    this.badgeBackgroundColor,
    required this.avatarUrl,
    required this.authorName,
    this.isVerified = false,
    required this.title,
    required this.progress,
    this.progressColor,
    this.amountRaisedLabel = 'Amount Raised',
    required this.amountRaisedValue,
    required this.buttonText,
    this.buttonColor,
    this.onButtonTap,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? AppScale.w(280);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.neutral800 : AppColors.neutral200;
    final bgColor = isDark ? AppColors.neutral900 : AppColors.white;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppScale.r(24)),
          border: Border.all(color: borderColor, width: 1),
        ),
        padding: EdgeInsets.all(AppScale.w(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image with Badge
            Stack(
              children: [
                Skeleton.replace(
                  replace: isLoading,
                  replacement: Bone.square(
                    size: AppScale.h(160),
                    borderRadius: BorderRadius.circular(AppScale.r(16)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppScale.r(16)),
                    child: AppImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: AppScale.h(160),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (badgeText != null)
                  Positioned(
                    top: AppScale.h(12),
                    right: AppScale.w(12),
                    child: Skeleton.replace(
                      replace: isLoading,
                      replacement: Bone.button(width: AppScale.w(80), height: AppScale.h(24)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppScale.w(12),
                          vertical: AppScale.h(4),
                        ),
                        decoration: BoxDecoration(
                          color: badgeBackgroundColor ?? (isDark ? AppColors.neutral800 : AppColors.white),
                          borderRadius: BorderRadius.circular(AppScale.r(12)),
                        ),
                        child: Text(
                          badgeText!,
                          style: TextStyle(
                            fontSize: AppScale.sp(11),
                            fontWeight: FontWeight.bold,
                            color: badgeColor ?? AppColors.error,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: AppScale.h(16)),
            
            // Author / Organization
            Row(
              children: [
                Skeleton.replace(
                  replace: isLoading,
                  replacement: Bone.circle(size: AppScale.w(24)),
                  child: ClipOval(
                    child: AppImage(
                      imageUrl: avatarUrl,
                      width: AppScale.w(24),
                      height: AppScale.w(24),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: AppScale.w(8)),
                Expanded(
                  child: Skeleton.replace(
                    replace: isLoading,
                    replacement: Bone.text(words: 2),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            authorName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppScale.sp(13),
                              fontWeight: FontWeight.w500,
                              color: isDark ? AppColors.neutral300 : AppColors.neutral700,
                            ),
                          ),
                        ),
                        if (isVerified) ...[
                          SizedBox(width: AppScale.w(4)),
                          HeroIcon(
                            HeroIcons.checkBadge,
                            style: HeroIconStyle.solid,
                            size: AppScale.w(16),
                            color: AppColors.primary,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppScale.h(12)),
            
            // Title
            Skeleton.replace(
              replace: isLoading,
              replacement: Bone.text(words: 4),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppScale.sp(15),
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.white : AppColors.neutral900,
                  height: 1.3,
                ),
              ),
            ),
            SizedBox(height: AppScale.h(16)),
            
            // Progress Bar
            Skeleton.replace(
              replace: isLoading,
              replacement: Bone.button(width: double.infinity, height: AppScale.h(6)),
              child: Stack(
                children: [
                  Container(
                    height: AppScale.h(6),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.neutral800 : AppColors.neutral200,
                      borderRadius: BorderRadius.circular(AppScale.r(3)),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      height: AppScale.h(6),
                      decoration: BoxDecoration(
                        color: progressColor ?? AppColors.success,
                        borderRadius: BorderRadius.circular(AppScale.r(3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppScale.h(8)),
            
            // Amount Raised
            Skeleton.replace(
              replace: isLoading,
              replacement: Bone.text(words: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    amountRaisedLabel,
                    style: TextStyle(
                      fontSize: AppScale.sp(12),
                      color: isDark ? AppColors.neutral400 : AppColors.neutral500,
                    ),
                  ),
                  Text(
                    amountRaisedValue,
                    style: TextStyle(
                      fontSize: AppScale.sp(12),
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.neutral300 : AppColors.neutral600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppScale.h(16)),
            
            // Button
            Skeleton.replace(
              replace: isLoading,
              replacement: Bone.button(width: double.infinity, height: AppScale.h(48)),
              child: GestureDetector(
                onTap: onButtonTap ?? () {},
                child: Container(
                  width: double.infinity,
                  height: AppScale.h(48),
                  decoration: BoxDecoration(
                    color: buttonColor ?? AppColors.primary,
                    borderRadius: BorderRadius.circular(AppScale.r(24)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: AppScale.sp(14),
                      fontWeight: FontWeight.bold,
                      // Automatically use dark text if the button is yellow or light colored
                      color: (buttonColor?.computeLuminance() ?? 0) > 0.5 ? AppColors.neutral900 : AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
