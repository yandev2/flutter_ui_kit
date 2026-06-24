import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:heroicons/heroicons.dart';

enum AppCardStyle10Variant { solid, blurred }

class AppCardStyle10 extends StatelessWidget {
  final AppCardStyle10Variant variant;
  final String imageUrl;
  final String name;
  final bool isVerified;
  final String description;
  final HeroIcons? stat1Icon;
  final String? stat1Value;
  final HeroIcons? stat2Icon;
  final String? stat2Value;
  final String buttonText;
  final VoidCallback? onButtonTap;

  final double? width;
  final double? nameSize;
  final double? descriptionSize;
  final double? statSize;
  final double? buttonTextSize;
  
  final bool isLoading;

  const AppCardStyle10({
    super.key,
    this.variant = AppCardStyle10Variant.solid,
    required this.imageUrl,
    required this.name,
    this.isVerified = false,
    required this.description,
    this.stat1Icon,
    this.stat1Value,
    this.stat2Icon,
    this.stat2Value,
    this.buttonText = 'Follow +',
    this.onButtonTap,
    this.width,
    this.nameSize,
    this.descriptionSize,
    this.statSize,
    this.buttonTextSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardWidth = width ?? AppScale.w(260);

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: variant == AppCardStyle10Variant.solid
              ? (isDark ? AppColors.surface : AppColors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppScale.r(24)),
          boxShadow: variant == AppCardStyle10Variant.solid
              ? [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
          border: variant == AppCardStyle10Variant.solid && isDark
              ? Border.all(color: AppColors.border, width: 1)
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: variant == AppCardStyle10Variant.solid
            ? _buildSolidVariant(context, isDark)
            : _buildBlurredVariant(context, isDark),
      ),
    );
  }

  Widget _buildSolidVariant(BuildContext context, bool isDark) {
    return Padding(
      padding: EdgeInsets.all(AppScale.w(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppScale.r(16)),
              child: AppImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          SizedBox(height: AppScale.h(16)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppScale.w(8)),
            child: _buildContent(context, isDark, isSolid: true),
          ),
          SizedBox(height: AppScale.h(8)),
        ],
      ),
    );
  }

  Widget _buildBlurredVariant(BuildContext context, bool isDark) {
    return AspectRatio(
      aspectRatio: 0.65, // Taller for the background image
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    AppScale.w(20),
                    AppScale.h(20),
                    AppScale.w(20),
                    AppScale.h(20),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        isDark
                            ? Colors.black.withValues(alpha: 0.1)
                            : Colors.white.withValues(alpha: 0.1),
                        isDark
                            ? Colors.black.withValues(alpha: 0.7)
                            : Colors.white.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: _buildContent(context, isDark, isSolid: false),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark, {required bool isSolid}) {
    final titleColor = isSolid
        ? AppColors.textPrimary
        : (isDark ? Colors.white : AppColors.textPrimary);
        
    final descColor = isSolid
        ? AppColors.textSecondary
        : (isDark ? Colors.white70 : AppColors.textSecondary);
        
    final statColor = isSolid
        ? AppColors.textSecondary
        : (isDark ? Colors.white70 : AppColors.textSecondary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: Skeleton.replace(
                replace: isLoading,
                replacement: Bone.text(words: 2),
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: nameSize ?? AppScale.sp(18),
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ),
            ),
            if (isVerified) ...[
              SizedBox(width: AppScale.w(6)),
              HeroIcon(
                HeroIcons.checkBadge,
                style: HeroIconStyle.solid,
                color: isSolid ? AppColors.success : (isDark ? Colors.white : AppColors.success),
                size: AppScale.w(20),
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
              fontSize: descriptionSize ?? AppScale.sp(13),
              color: descColor,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: AppScale.h(20)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (stat1Icon != null && stat1Value != null) ...[
              HeroIcon(stat1Icon!, size: AppScale.w(14), color: statColor),
              SizedBox(width: AppScale.w(4)),
              Text(
                stat1Value!,
                style: TextStyle(
                  fontSize: statSize ?? AppScale.sp(12),
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              SizedBox(width: AppScale.w(12)),
            ],
            if (stat2Icon != null && stat2Value != null) ...[
              HeroIcon(stat2Icon!, size: AppScale.w(14), color: statColor),
              SizedBox(width: AppScale.w(4)),
              Text(
                stat2Value!,
                style: TextStyle(
                  fontSize: statSize ?? AppScale.sp(12),
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ],
            const Spacer(),
            GestureDetector(
              onTap: isLoading ? null : onButtonTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppScale.w(12),
                  vertical: AppScale.h(8),
                ),
                decoration: BoxDecoration(
                  color: isSolid
                      ? (isDark ? AppColors.neutral800 : AppColors.neutral100)
                      : (isDark ? AppColors.white.withValues(alpha: 0.9) : AppColors.white.withValues(alpha: 0.8)),
                  borderRadius: BorderRadius.circular(AppScale.r(20)),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: buttonTextSize ?? AppScale.sp(12),
                    fontWeight: FontWeight.bold,
                    color: isSolid
                        ? (isDark ? Colors.white : AppColors.textPrimary)
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
