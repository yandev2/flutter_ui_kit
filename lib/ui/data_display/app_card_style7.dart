import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';

class AppCardStyle7 extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final String? badgeText;
  final Color? badgeColor;
  final VoidCallback? onTap;
  final double? width;
  final double? avatarSize;
  final bool isMax;
  final bool isLoading;
  
  final double? titleSize;
  final double? subtitleSize;
  final double? badgeTextSize;

  const AppCardStyle7({
    super.key,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.badgeText,
    this.badgeColor,
    this.onTap,
    this.width,
    this.avatarSize,
    this.isMax = false,
    this.isLoading = false,
    this.titleSize,
    this.subtitleSize,
    this.badgeTextSize,
  });

  static const Color _defaultBadgeColor = Color(0xFFF97316);

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(360));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final avatarDiameter = avatarSize ?? AppScale.w(56);

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final badgeBg = badgeColor ?? _defaultBadgeColor;

    final hasText = title != null || subtitle != null;
    final cardRadius = BorderRadius.circular(AppScale.r(20));

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: cardWidth,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: cardRadius,
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppScale.w(16),
              vertical: AppScale.h(14),
            ),
            child: Row(
              children: [
                if (imageUrl != null) ...[
                  Skeleton.replace(
                    replace: isLoading,
                    replacement: Bone.circle(size: avatarDiameter),
                    child: AppImage(
                      imageUrl: imageUrl!,
                      width: avatarDiameter,
                      height: avatarDiameter,
                      borderRadius:
                          BorderRadius.circular(avatarDiameter / 2),
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (hasText || badgeText != null)
                    SizedBox(width: AppScale.w(14)),
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
                            fontSize: titleSize ?? AppScale.sp(16),
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
                            fontSize: subtitleSize ?? AppScale.sp(13),
                            color: subtitleColor,
                          ),
                        ),
                    ],
                  ),
                ),
              if (badgeText != null) ...[
                if (hasText) SizedBox(width: AppScale.w(12)),
                _buildBadge(
                  text: badgeText!,
                  color: badgeBg,
                  isLoading: isLoading,
                  textSize: badgeTextSize,
                ),
              ],
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildBadge({
    required String text,
    required Color color,
    required bool isLoading,
    double? textSize,
  }) {
    final badgeRadius = BorderRadius.circular(AppScale.r(24));

    return Skeleton.leaf(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppScale.w(16),
          vertical: AppScale.h(10),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: badgeRadius,
          boxShadow: isLoading
              ? null
              : [
                  BoxShadow(
                    color: color.withValues(alpha: 0.45),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: textSize ?? AppScale.sp(11),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}
