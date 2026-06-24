import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:heroicons/heroicons.dart';

class AppCardStyle12 extends StatelessWidget {
  final String? idText;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeTextColor;
  
  final String? imageUrl;
  final String? title;
  final String? location;
  
  final String? checkInLabel;
  final String? checkInValue;
  final String? checkOutLabel;
  final String? checkOutValue;
  
  final String? buttonText;
  final VoidCallback? onButtonTap;
  
  final double? width;
  final bool isLoading;

  const AppCardStyle12({
    super.key,
    this.idText,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
    this.imageUrl,
    this.title,
    this.location,
    this.checkInLabel,
    this.checkInValue,
    this.checkOutLabel,
    this.checkOutValue,
    this.buttonText,
    this.onButtonTap,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? double.infinity;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final dividerColor = isDark ? AppColors.border : AppColors.neutral200;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(AppScale.w(16)),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppScale.r(24)),
          border: isDark ? Border.all(color: dividerColor, width: 1) : null,
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Section: ID and Badge
            if (idText != null || badgeText != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (idText != null)
                    Expanded(
                      child: Skeleton.replace(
                        replace: isLoading,
                        replacement: Bone.text(words: 2),
                        child: Text(
                          idText!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppScale.sp(14),
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  if (badgeText != null)
                    Skeleton.replace(
                      replace: isLoading,
                      replacement: Bone.text(words: 1),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppScale.w(12),
                          vertical: AppScale.h(6),
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor?.withValues(alpha: 0.1) ?? AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppScale.r(20)),
                          border: Border.all(
                            color: badgeColor ?? AppColors.error,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          badgeText!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppScale.sp(12),
                            fontWeight: FontWeight.w600,
                            color: badgeTextColor ?? badgeColor ?? AppColors.error,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: AppScale.h(12)),
              Divider(color: dividerColor, thickness: 1, height: 1),
              SizedBox(height: AppScale.h(16)),
            ],

            // Middle Section: Image and Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null) ...[
                  Skeleton.leaf(
                    child: AppImage(
                      imageUrl: imageUrl!,
                      width: AppScale.w(80),
                      height: AppScale.w(80),
                      borderRadius: BorderRadius.circular(AppScale.r(12)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: AppScale.w(16)),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.text(words: 2),
                          child: Text(
                            title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppScale.sp(16),
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      if (location != null) ...[
                        SizedBox(height: AppScale.h(4)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            HeroIcon(
                              HeroIcons.mapPin,
                              size: AppScale.w(14),
                              color: subtitleColor,
                              style: HeroIconStyle.outline,
                            ),
                            SizedBox(width: AppScale.w(4)),
                            Expanded(
                              child: Skeleton.replace(
                                replace: isLoading,
                                replacement: Bone.text(words: 2),
                                child: Text(
                                  location!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(13),
                                    color: subtitleColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (checkInLabel != null || checkOutLabel != null) ...[
                        SizedBox(height: AppScale.h(12)),
                        Row(
                          children: [
                            if (checkInLabel != null)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      checkInLabel!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: AppScale.sp(12),
                                        color: subtitleColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: AppScale.h(2)),
                                    Skeleton.replace(
                                      replace: isLoading,
                                      replacement: Bone.text(words: 2),
                                      child: Text(
                                        checkInValue ?? '-',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: AppScale.sp(13),
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (checkOutLabel != null)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      checkOutLabel!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: AppScale.sp(12),
                                        color: subtitleColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: AppScale.h(2)),
                                    Skeleton.replace(
                                      replace: isLoading,
                                      replacement: Bone.text(words: 2),
                                      child: Text(
                                        checkOutValue ?? '-',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: AppScale.sp(13),
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            // Bottom Section: Button
            if (buttonText != null) ...[
              SizedBox(height: AppScale.h(16)),
              Divider(color: dividerColor, thickness: 1, height: 1),
              SizedBox(height: AppScale.h(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    text: buttonText!,
                    onPressed: onButtonTap ?? () {},
                    size: AppButtonSize.medium,
                    variant: AppButtonVariant.solid,
                    shape: AppButtonShape.rounded,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
