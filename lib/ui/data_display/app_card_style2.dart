import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';
import 'package:flutter_ui_kit/ui/status/app_progress_bar.dart';

enum AppCardStyle2Variant { solid, glassy }

class AppCardStyle2 extends StatelessWidget {
  final AppCardStyle2Variant variant;
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final HeroIcons? footerItem1Icon;
  final String? footerItem1Text;
  final HeroIcons? footerItem2Icon;
  final String? footerItem2Text;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final double? width;
  final double? imageHeight;
  final double? progress;
  final bool isMax;
  final bool isLoading;

  const AppCardStyle2({
    super.key,
    this.variant = AppCardStyle2Variant.solid,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.footerItem1Icon,
    this.footerItem1Text,
    this.footerItem2Icon,
    this.footerItem2Text,
    this.buttonText,
    this.onButtonTap,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.width,
    this.imageHeight,
    this.progress,
    this.isMax = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(320));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (variant == AppCardStyle2Variant.solid) {
      return Skeletonizer(
        enabled: isLoading,
        child: Padding(
          padding: EdgeInsets.only(bottom: AppScale.h(24)),
          child: Container(
            width: cardWidth,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surface : AppColors.white,
              borderRadius: BorderRadius.circular(AppScale.r(24)),
              border: isDark
                  ? Border.all(color: AppColors.border, width: 1)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (imageUrl != null) Skeleton.leaf(
                  child: AppImage(
                    imageUrl: imageUrl!,
                    width: double.infinity,
                    height: imageHeight ?? AppScale.h(240),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppScale.r(24)),
                    ),
                  ),
                ),
                _buildContent(context, false),
              ],
            ),
          ),
        ),
      );
    } else {
      return Skeletonizer(
        enabled: isLoading,
        child: Padding(
          padding: EdgeInsets.only(bottom: AppScale.h(24)),
          child: Container(
            width: cardWidth,
            height: AppScale.h(420),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppScale.r(24)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                if (imageUrl != null) Skeleton.leaf(
                  child: AppImage(
                    imageUrl: imageUrl!,
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: BorderRadius.circular(AppScale.r(24)),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(AppScale.r(24)),
                          ),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.white,
                                  Colors.transparent,
                                ],
                                stops: [0.5, 1.0],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.dstIn,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                color: isDark
                                    ? AppColors.black.withValues(alpha: 0.5)
                                    : AppColors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _buildContent(context, true),
                    ],
                  ),
                ),
                Positioned(
                  top: AppScale.h(16),
                  right: AppScale.w(16),
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppScale.r(20)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: EdgeInsets.all(AppScale.w(8)),
                          decoration: BoxDecoration(
                            color: AppColors.black.withValues(alpha: 0.2),
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
                              color: isFavorite ? AppColors.error : AppColors.white,
                              size: AppScale.w(20),
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildContent(BuildContext context, bool isGlassy) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isGlassy
        ? (isDark ? AppColors.white : AppColors.neutral900)
        : AppColors.textPrimary;

    final subtitleColor = isGlassy
        ? (isDark ? AppColors.neutral300 : AppColors.neutral500)
        : AppColors.textSecondary;

    return Padding(
      padding: EdgeInsets.only(
        top: isGlassy ? AppScale.h(80) : AppScale.w(20),
        bottom: AppScale.w(20),
        left: AppScale.w(20),
        right: AppScale.w(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppScale.sp(18),
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: AppScale.h(4)),
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
                  ],
                ),
              ),
              if (!isGlassy)
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: Container(
                    padding: EdgeInsets.all(AppScale.w(8)),
                    decoration: BoxDecoration(
                      color: isFavorite
                          ? AppColors.error.withValues(alpha: 0.1)
                          : AppColors.neutral100,
                      shape: BoxShape.circle,
                    ),
                    child: Skeleton.replace(
                      replace: isLoading,
                      replacement: Bone.icon(size: AppScale.w(24)),
                      child: HeroIcon(
                        isFavorite ? HeroIcons.heart : HeroIcons.heart,
                        style:
                            isFavorite ? HeroIconStyle.solid : HeroIconStyle.outline,
                        color: isFavorite
                            ? AppColors.error
                            : AppColors.neutral400,
                        size: AppScale.w(24),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: AppScale.h(20)),
          Row(
            children: [
              if (footerItem1Icon != null) Skeleton.replace(
                replace: isLoading,
                replacement: Bone.icon(size: AppScale.w(18)),
                child: HeroIcon(
                  footerItem1Icon!,
                  size: AppScale.w(18),
                  color: subtitleColor,
                  style: HeroIconStyle.outline,
                ),
              ),
              if (footerItem1Icon != null && footerItem1Text != null) SizedBox(width: AppScale.w(6)),
              if (footerItem1Text != null) Expanded(
                child: Text(
                  footerItem1Text!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppScale.sp(14),
                    fontWeight: FontWeight.w500,
                    color: subtitleColor,
                  ),
                ),
              ),
              if (footerItem2Icon != null) ...[
                SizedBox(width: AppScale.w(16)),
                Skeleton.replace(
                  replace: isLoading,
                  replacement: Bone.icon(size: AppScale.w(18)),
                  child: HeroIcon(
                    footerItem2Icon!,
                    size: AppScale.w(18),
                    color: subtitleColor,
                    style: HeroIconStyle.outline,
                  ),
                ),
              ],
              if (footerItem2Icon != null && footerItem2Text != null) SizedBox(width: AppScale.w(6)),
              if (footerItem2Text != null) Expanded(
                child: Text(
                  footerItem2Text!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppScale.sp(14),
                    fontWeight: FontWeight.w500,
                    color: subtitleColor,
                  ),
                ),
              ),
            ],
          ),
          if (progress != null) ...[
            SizedBox(height: AppScale.h(16)),
            AppProgressBar(
              progress: progress!,
              height: AppScale.h(6),
              color: isGlassy
                  ? (isDark ? AppColors.white : AppColors.neutral900)
                  : AppColors.primary,
            ),
          ],
          if (buttonText != null) ...[
            SizedBox(height: progress != null ? AppScale.h(12) : AppScale.h(24)),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: buttonText!,
                onPressed: onButtonTap ?? () {},
                size: AppButtonSize.medium,
                variant: AppButtonVariant.solid,
                color: isGlassy && !isDark
                    ? AppColors.white
                    : AppColors.neutral900,
                textColor: isGlassy && !isDark
                    ? AppColors.black
                    : AppColors.white,
                shape: AppButtonShape.pill,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
