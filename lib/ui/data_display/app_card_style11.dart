import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';

enum AppCardStyle11Variant { style1, style2 }

class AppCardStyle11Stat {
  final String value;
  final String label;
  final HeroIcons? icon;
  final Color? iconColor;

  const AppCardStyle11Stat({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
  });
}

class AppCardStyle11 extends StatelessWidget {
  final AppCardStyle11Variant variant;
  final String imageUrl;
  final String title;
  final bool isVerified;
  final String description;
  final List<AppCardStyle11Stat> stats;

  final String primaryButtonText;
  final HeroIcons? primaryButtonIcon;
  final VoidCallback? onPrimaryButtonTap;

  final HeroIcons? bookmarkIcon;
  final bool isBookmarked;
  final VoidCallback? onBookmarkTap;

  final double? width;
  final double? titleSize;
  final double? descriptionSize;
  final double? statValueSize;
  final double? statLabelSize;
  final double? buttonTextSize;

  final bool isLoading;

  const AppCardStyle11({
    super.key,
    this.variant = AppCardStyle11Variant.style1,
    required this.imageUrl,
    required this.title,
    this.isVerified = false,
    required this.description,
    this.stats = const [],
    required this.primaryButtonText,
    this.primaryButtonIcon,
    this.onPrimaryButtonTap,
    this.bookmarkIcon = HeroIcons.bookmark,
    this.isBookmarked = false,
    this.onBookmarkTap,
    this.width,
    this.titleSize,
    this.descriptionSize,
    this.statValueSize,
    this.statLabelSize,
    this.buttonTextSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = variant == AppCardStyle11Variant.style2;
    final cardWidth = width ?? AppScale.w(320);

    final bgColor = isDark ? Colors.black.withValues(alpha: 0.3) : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.white.withValues(alpha: 0.7) : AppColors.neutral500;
    final borderColor = isDark ? AppColors.white.withValues(alpha: 0.15) : Colors.transparent;

    Widget content = Container(
      width: cardWidth,
      padding: EdgeInsets.all(AppScale.w(16)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppScale.r(24)),
        border: Border.all(
          color: borderColor,
          width: isDark ? 1 : 0,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(isDark),
          SizedBox(height: AppScale.h(16)),
          _buildProfileInfo(textColor, subtitleColor, isDark),
          SizedBox(height: AppScale.h(16)),
          _buildStatsRow(textColor, subtitleColor, isDark),
          SizedBox(height: AppScale.h(24)),
          _buildBottomActions(isDark),
        ],
      ),
    );

    if (isDark) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(AppScale.r(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: content,
        ),
      );
    }

    return Skeletonizer(
      enabled: isLoading,
      child: content,
    );
  }

  Widget _buildImage(bool isDark) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppScale.r(16)),
            child: Skeleton.replace(
              replace: isLoading,
              replacement: Bone.square(size: double.infinity),
              child: AppImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (variant == AppCardStyle11Variant.style1 && bookmarkIcon != null)
            Positioned(
              top: AppScale.w(12),
              right: AppScale.w(12),
              child: GestureDetector(
                onTap: isLoading ? null : onBookmarkTap,
                child: Container(
                  padding: EdgeInsets.all(AppScale.w(8)),
                  decoration: BoxDecoration(
                    color: AppColors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: HeroIcon(
                    bookmarkIcon!,
                    style: isBookmarked ? HeroIconStyle.solid : HeroIconStyle.outline,
                    size: AppScale.w(20),
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(Color textColor, Color subtitleColor, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Skeleton.replace(
                replace: isLoading,
                replacement: Bone.text(words: 2),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleSize ?? AppScale.sp(20),
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
            if (isVerified) ...[
              SizedBox(width: AppScale.w(6)),
              HeroIcon(
                HeroIcons.checkBadge,
                style: HeroIconStyle.solid,
                color: AppColors.primary,
                size: AppScale.w(22),
              ),
            ],
          ],
        ),
        SizedBox(height: AppScale.h(8)),
        Skeleton.replace(
          replace: isLoading,
          replacement: Bone.text(words: 5),
          child: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: descriptionSize ?? AppScale.sp(14),
              color: subtitleColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(Color textColor, Color subtitleColor, bool isDark) {
    if (stats.isEmpty) return const SizedBox.shrink();

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < stats.length; i++) ...[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stats[i].value,
                        style: TextStyle(
                          fontSize: statValueSize ?? AppScale.sp(16),
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      if (stats[i].icon != null) ...[
                        SizedBox(width: AppScale.w(4)),
                        HeroIcon(
                          stats[i].icon!,
                          style: HeroIconStyle.solid,
                          size: AppScale.w(16),
                          color: stats[i].iconColor ?? AppColors.warning,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: AppScale.h(4)),
                  Text(
                    stats[i].label,
                    style: TextStyle(
                      fontSize: statLabelSize ?? AppScale.sp(12),
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            if (i < stats.length - 1)
              VerticalDivider(
                color: isDark ? AppColors.white.withValues(alpha: 0.2) : AppColors.neutral200,
                thickness: 1,
                width: AppScale.w(16),
                indent: AppScale.h(4),
                endIndent: AppScale.h(4),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomActions(bool isDark) {
    final primaryButton = Skeleton.replace(
      replace: isLoading,
      replacement: Bone.button(),
      child: AppButton(
        text: primaryButtonText,
        customIcon: primaryButtonIcon != null
            ? HeroIcon(
                primaryButtonIcon!,
                style: HeroIconStyle.outline,
                size: AppScale.w(18),
                color: isDark ? AppColors.black : AppColors.white,
              )
            : null,
        onPressed: isLoading ? null : onPrimaryButtonTap,
        color: isDark ? AppColors.white : AppColors.neutral900,
        textColor: isDark ? AppColors.black : AppColors.white,
        isFullWidth: variant == AppCardStyle11Variant.style1,
        textSize: buttonTextSize ?? AppScale.sp(14),
      ),
    );

    if (variant == AppCardStyle11Variant.style1) {
      return primaryButton;
    } else {
      return Row(
        children: [
          Expanded(child: primaryButton),
          if (bookmarkIcon != null) ...[
            SizedBox(width: AppScale.w(12)),
            Skeleton.replace(
              replace: isLoading,
              replacement: Bone.button(),
              child: AppButton(
                customIcon: HeroIcon(
                  bookmarkIcon!,
                  style: isBookmarked ? HeroIconStyle.solid : HeroIconStyle.outline,
                  size: AppScale.w(20),
                  color: isDark ? AppColors.white : AppColors.neutral700,
                ),
                onPressed: isLoading ? null : onBookmarkTap,
                color: isDark ? AppColors.white.withValues(alpha: 0.1) : AppColors.neutral100,
                shape: AppButtonShape.square,
              ),
            ),
          ],
        ],
      );
    }
  }
}
