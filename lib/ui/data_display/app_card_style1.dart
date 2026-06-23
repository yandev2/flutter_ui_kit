import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';

enum AppCardStyle1Variant { solid, glassy }

class AppCardStyle1 extends StatelessWidget {
  final AppCardStyle1Variant variant;
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final bool isVerified;
  final HeroIcons? footerItem1Icon;
  final String? footerItem1Text;
  final HeroIcons? footerItem2Icon;
  final String? footerItem2Text;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final double? width;
  final bool isMax;
  final bool isLoading;

  const AppCardStyle1({
    super.key,
    this.variant = AppCardStyle1Variant.solid,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.isVerified = false,
    this.footerItem1Icon,
    this.footerItem1Text,
    this.footerItem2Icon,
    this.footerItem2Text,
    this.buttonText,
    this.onButtonTap,
    this.width,
    this.isMax = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(320));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (variant == AppCardStyle1Variant.solid) {
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
                if (imageUrl != null)
                  Skeleton.leaf(
                    child: AppImage(
                      imageUrl: imageUrl!,
                      width: double.infinity,
                      height: AppScale.h(240),
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
                if (imageUrl != null)
                  Skeleton.leaf(
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppScale.r(24)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              isDark
                                  ? AppColors.black.withValues(alpha: 0.3)
                                  : AppColors.white.withValues(alpha: 0.4),
                              isDark
                                  ? AppColors.black.withValues(alpha: 0.8)
                                  : AppColors.white.withValues(alpha: 0.9),
                            ],
                          ),
                          border: Border(
                            top: BorderSide(
                              color: AppColors.white.withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                        ),
                        child: _buildContent(context, true),
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
        ? (isDark ? AppColors.neutral200 : AppColors.neutral700)
        : AppColors.textSecondary;

    return Padding(
      padding: EdgeInsets.all(AppScale.w(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppScale.sp(18),
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              if (isVerified) ...[
                SizedBox(width: AppScale.w(8)),
                Skeleton.replace(
                  replace: isLoading,
                  replacement: Bone.icon(size: AppScale.w(18)),
                  child: HeroIcon(
                    HeroIcons.checkBadge,
                    style: HeroIconStyle.solid,
                    color: AppColors.primary,
                    size: AppScale.w(18),
                  ),
                ),
              ],
            ],
          ),
          if (subtitle != null) ...[
            SizedBox(height: AppScale.h(6)),
            Text(
              subtitle!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: AppScale.sp(14), color: subtitleColor),
            ),
          ],
          SizedBox(height: AppScale.h(16)),
          Row(
            children: [
              if (footerItem1Icon != null)
                Skeleton.replace(
                  replace: isLoading,
                  replacement: Bone.icon(size: AppScale.w(14)),
                  child: HeroIcon(
                    footerItem1Icon!,
                    style: HeroIconStyle.solid,
                    size: AppScale.w(14),
                    color: subtitleColor,
                  ),
                ),
              if (footerItem1Icon != null && footerItem1Text != null)
                SizedBox(width: AppScale.w(6)),
              if (footerItem1Text != null)
                Expanded(
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
                  replacement: Bone.icon(size: AppScale.w(14)),
                  child: HeroIcon(
                    footerItem2Icon!,
                    style: HeroIconStyle.solid,
                    size: AppScale.w(14),
                    color: subtitleColor,
                  ),
                ),
              ],
              if (footerItem2Icon != null && footerItem2Text != null)
                SizedBox(width: AppScale.w(6)),
              if (footerItem2Text != null)
                Expanded(
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
          if (buttonText != null) ...[
            SizedBox(height: AppScale.h(20)),
            AppButton(
              text: buttonText!,
              onPressed: onButtonTap ?? () {},
              size: AppButtonSize.medium,
              variant: AppButtonVariant.outline,
              isFullWidth: true,
            ),
          ],
        ],
      ),
    );
  }
}
