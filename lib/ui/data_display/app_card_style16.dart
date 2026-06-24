import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppCardStyle16Stat {
  final String label;
  final String value;

  const AppCardStyle16Stat({
    required this.label,
    required this.value,
  });
}

class AppCardStyle16 extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeBackgroundColor;
  final double progress;
  final Color? progressColor;
  final String amountRaisedText;
  final String percentageText;
  final List<AppCardStyle16Stat> stats;
  final VoidCallback? onTap;
  final double? width;
  final bool isLoading;

  const AppCardStyle16({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    this.badgeText,
    this.badgeColor,
    this.badgeBackgroundColor,
    required this.progress,
    this.progressColor,
    required this.amountRaisedText,
    required this.percentageText,
    required this.stats,
    this.onTap,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? double.infinity;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.neutral900 : AppColors.white;
    final borderColor = isDark ? AppColors.neutral800 : AppColors.neutral200;

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppScale.r(24)),
            border: Border.all(color: borderColor, width: 1),
          ),
          padding: EdgeInsets.all(AppScale.w(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section: Image + Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Skeleton.replace(
                    replace: isLoading,
                    replacement: Bone.square(
                      size: AppScale.w(100),
                      borderRadius: BorderRadius.circular(AppScale.r(16)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppScale.r(16)),
                      child: AppImage(
                        imageUrl: imageUrl,
                        width: AppScale.w(100),
                        height: AppScale.w(100),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: AppScale.w(16)),
                  // Info Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Badge
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Skeleton.replace(
                                replace: isLoading,
                                replacement: Bone.text(words: 3),
                                child: Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(16),
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.white : AppColors.neutral900,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            if (badgeText != null) ...[
                              SizedBox(width: AppScale.w(8)),
                              Skeleton.replace(
                                replace: isLoading,
                                replacement: Bone.button(width: AppScale.w(50), height: AppScale.h(20)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppScale.w(10),
                                    vertical: AppScale.h(4),
                                  ),
                                  decoration: BoxDecoration(
                                    color: badgeBackgroundColor ?? AppColors.success.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(AppScale.r(12)),
                                  ),
                                  child: Text(
                                    badgeText!,
                                    style: TextStyle(
                                      fontSize: AppScale.sp(11),
                                      fontWeight: FontWeight.bold,
                                      color: badgeColor ?? AppColors.success,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: AppScale.h(6)),
                        // Category
                        Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.text(words: 2),
                          child: Text(
                            category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppScale.sp(13),
                              color: isDark ? AppColors.neutral400 : AppColors.neutral500,
                            ),
                          ),
                        ),
                        SizedBox(height: AppScale.h(12)),
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
                        // Amount Raised & Percentage
                        Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.text(words: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  amountRaisedText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(12),
                                    color: isDark ? AppColors.neutral400 : AppColors.neutral500,
                                  ),
                                ),
                              ),
                              SizedBox(width: AppScale.w(8)),
                              Text(
                                percentageText,
                                style: TextStyle(
                                  fontSize: AppScale.sp(12),
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppColors.neutral200 : AppColors.neutral800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppScale.h(16)),
              // Bottom Section: Stats Wrap to prevent overflow
              Skeleton.replace(
                replace: isLoading,
                replacement: Wrap(
                  spacing: AppScale.w(8),
                  runSpacing: AppScale.h(8),
                  children: List.generate(
                    3,
                    (_) => Bone.button(width: AppScale.w(100), height: AppScale.h(32)),
                  ),
                ),
                child: Wrap(
                  spacing: AppScale.w(8),
                  runSpacing: AppScale.h(8),
                  children: stats.map((stat) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppScale.w(12),
                        vertical: AppScale.h(6),
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.neutral800 : AppColors.neutral100,
                        borderRadius: BorderRadius.circular(AppScale.r(16)),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: AppScale.sp(12),
                            color: isDark ? AppColors.neutral400 : AppColors.neutral500,
                            fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                          ),
                          children: [
                            TextSpan(text: '\${stat.label} '),
                            TextSpan(
                              text: stat.value,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.white : AppColors.neutral900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
