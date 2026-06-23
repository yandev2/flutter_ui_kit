import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';

class AppCardStyle4 extends StatelessWidget {
  final String? imageUrl;
  final String? category;
  final String? title;
  final String? location;
  final double? rating;
  final String? reviewText;
  final VoidCallback? onTap;
  final double? width;
  final bool isMax;
  final bool isLoading;

  const AppCardStyle4({
    super.key,
    this.imageUrl,
    this.category,
    this.title,
    this.location,
    this.rating,
    this.reviewText,
    this.onTap,
    this.width,
    this.isMax = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(320));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final iconColor = isDark ? AppColors.neutral400 : AppColors.neutral400;

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: cardWidth,
          padding: EdgeInsets.all(AppScale.w(12)),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppScale.r(24)),
            border: isDark
                ? Border.all(color: AppColors.border, width: 1)
                : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null) Skeleton.leaf(
                child: AppImage(
                  imageUrl: imageUrl!,
                  width: AppScale.w(100),
                  height: AppScale.w(120),
                  borderRadius: BorderRadius.circular(AppScale.r(16)),
                  fit: BoxFit.cover,
                ),
              ),
              if (imageUrl != null) SizedBox(width: AppScale.w(16)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppScale.h(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (category != null) Text(
                            category!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppScale.sp(12),
                              fontWeight: FontWeight.w600,
                              color: subtitleColor,
                            ),
                          ),
                          if (category != null) SizedBox(height: AppScale.h(4)),
                          if (title != null) Text(
                            title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppScale.sp(16),
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          if (title != null && location != null) SizedBox(height: AppScale.h(8)),
                          if (location != null) Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Skeleton.replace(
                                replace: isLoading,
                                replacement: Bone.icon(size: AppScale.w(14)),
                                child: HeroIcon(
                                  HeroIcons.mapPin,
                                  style: HeroIconStyle.solid,
                                  size: AppScale.w(14),
                                  color: iconColor,
                                ),
                              ),
                              SizedBox(width: AppScale.w(4)),
                              Expanded(
                                child: Text(
                                  location!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(12),
                                    color: subtitleColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (rating != null || reviewText != null) ...[
                        SizedBox(height: AppScale.h(16)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (rating != null) ...[
                              Skeleton.replace(
                                replace: isLoading,
                                replacement: Bone.icon(size: AppScale.w(14)),
                                child: HeroIcon(
                                  HeroIcons.star,
                                  style: HeroIconStyle.solid,
                                  size: AppScale.w(14),
                                  color: AppColors.warning,
                                ),
                              ),
                              SizedBox(width: AppScale.w(4)),
                              Text(
                                rating.toString(),
                                style: TextStyle(
                                  fontSize: AppScale.sp(12),
                                  fontWeight: FontWeight.bold,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                            if (rating != null && reviewText != null) SizedBox(width: AppScale.w(4)),
                            if (reviewText != null) Expanded(
                              child: Text(
                                '($reviewText)',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: AppScale.sp(12),
                                  color: subtitleColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
