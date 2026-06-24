import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:flutter_ui_kit/ui/data_display/app_avatar_stack.dart';
import 'package:flutter_ui_kit/ui/status/app_progress_bar.dart';

class AppCardStyle9 extends StatelessWidget {
  final String imageUrl;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final double? badgeTextSize;
  
  final String? title;
  final double? titleSize;
  
  final double progress;
  final Color? progressColor;
  final Color? progressBgColor;
  
  final List<String>? authorImageUrls;
  final String? authorName;
  final double? authorNameSize;
  final String? authorRole;
  final double? authorRoleSize;
  
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTap;
  
  final double? width;
  final bool isMax;
  final bool isLoading;

  const AppCardStyle9({
    super.key,
    required this.imageUrl,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
    this.badgeTextSize,
    this.title,
    this.titleSize,
    this.progress = 0.0,
    this.progressColor,
    this.progressBgColor,
    this.authorImageUrls,
    this.authorName,
    this.authorNameSize,
    this.authorRole,
    this.authorRoleSize,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onTap,
    this.width,
    this.isMax = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(340));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    
    final defaultBadgeBg = AppColors.primary.withValues(alpha: 0.15);
    final defaultBadgeText = AppColors.primary;

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppScale.r(24)),
            border: isDark ? Border.all(color: AppColors.border, width: 1) : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Skeleton.leaf(
                    child: AppImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: AppScale.h(180),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppScale.r(24)),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: AppScale.h(16),
                    right: AppScale.w(16),
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: Container(
                        padding: EdgeInsets.all(AppScale.w(8)),
                        decoration: BoxDecoration(
                          color: AppColors.black.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.icon(size: AppScale.w(20)),
                          child: HeroIcon(
                            isFavorite ? HeroIcons.heart : HeroIcons.heart,
                            style: isFavorite
                                ? HeroIconStyle.solid
                                : HeroIconStyle.outline,
                            color: isFavorite ? AppColors.white : AppColors.white,
                            size: AppScale.w(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(AppScale.w(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (badgeText != null) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppScale.w(12),
                          vertical: AppScale.h(6),
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor ?? defaultBadgeBg,
                          borderRadius: BorderRadius.circular(AppScale.r(16)),
                        ),
                        child: Text(
                          badgeText!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: badgeTextSize ?? AppScale.sp(10),
                            fontWeight: FontWeight.bold,
                            color: badgeTextColor ?? defaultBadgeText,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: AppScale.h(12)),
                    ],
                    if (title != null) ...[
                      Text(
                        title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: titleSize ?? AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                    ],
                    AppProgressBar(
                      progress: progress,
                      height: AppScale.h(6),
                      color: progressColor ?? AppColors.primary,
                      backgroundColor: progressBgColor,
                    ),
                    if (authorName != null || authorRole != null || (authorImageUrls != null && authorImageUrls!.isNotEmpty)) ...[
                      SizedBox(height: AppScale.h(20)),
                      Row(
                        children: [
                          if (authorImageUrls != null && authorImageUrls!.isNotEmpty) ...[
                            AppAvatarStack(
                              imageUrls: authorImageUrls!,
                              size: AppScale.w(40),
                            ),
                            SizedBox(width: AppScale.w(12)),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (authorName != null)
                                  Text(
                                    authorName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: authorNameSize ?? AppScale.sp(14),
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                if (authorName != null && authorRole != null)
                                  SizedBox(height: AppScale.h(2)),
                                if (authorRole != null)
                                  Text(
                                    authorRole!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: authorRoleSize ?? AppScale.sp(12),
                                      color: subtitleColor,
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
        ),
      ),
    );
  }
}
