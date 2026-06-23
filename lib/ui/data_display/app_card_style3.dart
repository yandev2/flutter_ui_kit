import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';

class AppCardStyle3 extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? price;
  final String? description;
  final double? rating;
  final List<String>? tags;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final bool isBookmarked;
  final VoidCallback? onBookmarkTap;
  final double? width;
  final bool isMax;
  final bool isLoading;

  const AppCardStyle3({
    super.key,
    this.imageUrl,
    this.title,
    this.price,
    this.description,
    this.rating,
    this.tags,
    this.buttonText,
    this.onButtonTap,
    this.isBookmarked = false,
    this.onBookmarkTap,
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
    final chipBgColor = isDark ? AppColors.white.withValues(alpha: 0.1) : AppColors.neutral100;
    final chipTextColor = isDark ? AppColors.white : AppColors.neutral700;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppScale.r(24)),
          border: isDark
              ? Border.all(color: AppColors.border, width: 1)
              : null,
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
                if (imageUrl != null) Skeleton.leaf(
                  child: AppImage(
                    imageUrl: imageUrl!,
                    width: double.infinity,
                    height: AppScale.h(220),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppScale.r(24)),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: AppScale.h(60),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          bgColor.withValues(alpha: 0.0),
                          bgColor,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppScale.h(16),
                  right: AppScale.w(16),
                  child: GestureDetector(
                    onTap: onBookmarkTap,
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
                          isBookmarked ? HeroIcons.bookmark : HeroIcons.bookmark,
                          style: isBookmarked
                              ? HeroIconStyle.solid
                              : HeroIconStyle.outline,
                          color: isBookmarked ? AppColors.white : AppColors.white,
                          size: AppScale.w(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(AppScale.w(20), 0, AppScale.w(20), AppScale.w(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) Expanded(
                        child: Text(
                          title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppScale.sp(20),
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1.2,
                          ),
                        ),
                      ),
                      if (price != null) ...[
                        SizedBox(width: AppScale.w(12)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: AppScale.w(12), vertical: AppScale.h(6)),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppScale.r(20)),
                          ),
                          child: Text(
                            price!,
                            style: TextStyle(
                              fontSize: AppScale.sp(13),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (description != null) ...[
                    SizedBox(height: AppScale.h(12)),
                    Text(
                      description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppScale.sp(14),
                        color: subtitleColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                  if (rating != null || (tags != null && tags!.isNotEmpty)) ...[
                    SizedBox(height: AppScale.h(16)),
                    Wrap(
                      spacing: AppScale.w(8),
                      runSpacing: AppScale.h(8),
                      children: [
                        if (rating != null) _buildChip(
                          context,
                          text: rating.toString(),
                          icon: HeroIcons.star,
                          bgColor: chipBgColor,
                          textColor: chipTextColor,
                          isLoading: isLoading,
                        ),
                        if (tags != null) ...tags!.map(
                          (tag) => _buildChip(
                            context,
                            text: tag,
                            bgColor: chipBgColor,
                            textColor: chipTextColor,
                            isLoading: isLoading,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (buttonText != null) ...[
                    SizedBox(height: AppScale.h(24)),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: buttonText!,
                        onPressed: onButtonTap ?? () {},
                        size: AppButtonSize.large,
                        variant: AppButtonVariant.solid,
                        shape: AppButtonShape.rounded,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, {required String text, HeroIcons? icon, required Color bgColor, required Color textColor, required bool isLoading}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppScale.w(10), vertical: AppScale.h(6)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppScale.r(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Skeleton.replace(
              replace: isLoading,
              replacement: Bone.icon(size: AppScale.w(14)),
              child: HeroIcon(
                icon,
                size: AppScale.w(14),
                style: HeroIconStyle.solid,
                color: textColor,
              ),
            ),
            SizedBox(width: AppScale.w(4)),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: AppScale.sp(12),
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
