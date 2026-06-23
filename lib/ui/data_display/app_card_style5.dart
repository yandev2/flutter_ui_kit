import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';

class AppCardStyle5Stat {
  final String title;
  final String value;

  const AppCardStyle5Stat({required this.title, required this.value});
}

class AppCardStyle5 extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final String? description;
  final List<AppCardStyle5Stat>? stats;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryButtonTap;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonTap;
  final double? width;
  final bool isMax;
  final bool isLoading;

  const AppCardStyle5({
    super.key,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.description,
    this.stats,
    this.primaryButtonText,
    this.onPrimaryButtonTap,
    this.secondaryButtonText,
    this.onSecondaryButtonTap,
    this.width,
    this.isMax = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(360));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final statBgColor = isDark ? AppColors.white.withValues(alpha: 0.05) : AppColors.neutral100;
    
    final primaryBtnBg = isDark ? AppColors.white : AppColors.black;
    final primaryBtnText = isDark ? AppColors.black : AppColors.white;
    
    final secondaryBtnBg = isDark ? AppColors.neutral800 : AppColors.neutral600;
    final secondaryBtnText = AppColors.white;

    final hasTopSection = imageUrl != null || title != null || subtitle != null;
    final hasStats = stats != null && stats!.isNotEmpty;
    final hasButtons = primaryButtonText != null || secondaryButtonText != null;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(AppScale.w(24)),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppScale.r(24)),
          border: isDark
              ? Border.all(color: AppColors.border, width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.06),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasTopSection)
              Row(
                children: [
                  if (imageUrl != null) ...[
                    Skeleton.leaf(
                      child: AppImage(
                        imageUrl: imageUrl!,
                        width: AppScale.w(80),
                        height: AppScale.w(80),
                        borderRadius: BorderRadius.circular(AppScale.r(16)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: AppScale.w(16)),
                  ],
                  if (title != null || subtitle != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Text(
                              title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: AppScale.sp(22),
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
                                fontSize: AppScale.sp(14),
                                color: subtitleColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            
            if (hasTopSection && description != null) SizedBox(height: AppScale.h(20)),
            
            if (description != null)
              Text(
                description!,
                style: TextStyle(
                  fontSize: AppScale.sp(14),
                  color: subtitleColor,
                  height: 1.5,
                ),
              ),
              
            if ((hasTopSection || description != null) && hasStats) SizedBox(height: AppScale.h(20)),
            
            if (hasStats)
              Row(
                children: stats!.map((stat) {
                  final isLast = stat == stats!.last;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: isLast ? 0 : AppScale.w(8)),
                      padding: EdgeInsets.symmetric(vertical: AppScale.h(12), horizontal: AppScale.w(4)),
                      decoration: BoxDecoration(
                        color: statBgColor,
                        borderRadius: BorderRadius.circular(AppScale.r(12)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            stat.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppScale.sp(11),
                              color: subtitleColor,
                            ),
                          ),
                          SizedBox(height: AppScale.h(4)),
                          Text(
                            stat.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppScale.sp(18),
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              
            if ((hasTopSection || description != null || hasStats) && hasButtons) SizedBox(height: AppScale.h(24)),
            
            if (hasButtons)
              Row(
                children: [
                  if (primaryButtonText != null)
                    Expanded(
                      child: AppButton(
                        text: primaryButtonText!,
                        onPressed: onPrimaryButtonTap ?? () {},
                        size: AppButtonSize.medium,
                        variant: AppButtonVariant.solid,
                        color: primaryBtnBg,
                        textColor: primaryBtnText,
                        shape: AppButtonShape.rounded,
                      ),
                    ),
                  if (primaryButtonText != null && secondaryButtonText != null)
                    SizedBox(width: AppScale.w(12)),
                  if (secondaryButtonText != null)
                    Expanded(
                      child: AppButton(
                        text: secondaryButtonText!,
                        onPressed: onSecondaryButtonTap ?? () {},
                        size: AppButtonSize.medium,
                        variant: AppButtonVariant.solid,
                        color: secondaryBtnBg,
                        textColor: secondaryBtnText,
                        shape: AppButtonShape.rounded,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
