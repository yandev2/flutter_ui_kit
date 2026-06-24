import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppCardStyle14 extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback? onButtonTap;
  final String? imageAsset;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showDots;
  final int totalDots;
  final int activeDotIndex;
  final double? width;
  final double? height;
  final bool isLoading;

  const AppCardStyle14({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    this.onButtonTap,
    this.imageAsset,
    this.backgroundColor,
    this.textColor,
    this.showDots = false,
    this.totalDots = 3,
    this.activeDotIndex = 0,
    this.width,
    this.height,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? double.infinity;
    final cardHeight = height ?? AppScale.h(180);
    
    final effectiveBgColor = backgroundColor ?? AppColors.primary;
    final effectiveTextColor = textColor ?? AppColors.white;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        clipBehavior: Clip.none,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
              // Background Container
              Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(
                  color: effectiveBgColor,
                  borderRadius: BorderRadius.circular(AppScale.r(24)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    // Texture Pattern: Top Right Circle
                    Positioned(
                      top: -AppScale.w(40),
                      right: AppScale.w(60),
                      child: Container(
                        width: AppScale.w(160),
                        height: AppScale.w(160),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: effectiveTextColor.withValues(alpha: 0.06),
                        ),
                      ),
                    ),
                    // Texture Pattern: Bottom Left Circle
                    Positioned(
                      bottom: -AppScale.w(80),
                      left: -AppScale.w(40),
                      child: Container(
                        width: AppScale.w(200),
                        height: AppScale.w(200),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: effectiveTextColor.withValues(alpha: 0.06),
                        ),
                      ),
                    ),
                    // Content Column
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppScale.w(24),
                        top: AppScale.h(24),
                        bottom: AppScale.h(24),
                        right: AppScale.w(120), // Space for image
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton.replace(
                    replace: isLoading,
                    replacement: Bone.text(words: 2),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppScale.sp(20),
                        fontWeight: FontWeight.bold,
                        color: effectiveTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: AppScale.h(8)),
                  Expanded(
                    child: Skeleton.replace(
                      replace: isLoading,
                      replacement: Bone.text(words: 5),
                      child: Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppScale.sp(13),
                          color: effectiveTextColor.withValues(alpha: 0.9),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppScale.h(12)),
                  Skeleton.replace(
                    replace: isLoading,
                    replacement: Bone.button(width: AppScale.w(100), height: AppScale.h(36)),
                    child: GestureDetector(
                      onTap: onButtonTap ?? () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppScale.w(16),
                          vertical: AppScale.h(8),
                        ),
                        decoration: BoxDecoration(
                          color: effectiveTextColor, // Usually white
                          borderRadius: BorderRadius.circular(AppScale.r(20)),
                        ),
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            color: effectiveBgColor, // Text inherits the card background color
                            fontWeight: FontWeight.bold,
                            fontSize: AppScale.sp(13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
            
            // The Image on the right
            if (imageAsset != null)
              Positioned(
                right: AppScale.w(8),
                bottom: 0,
                child: Skeleton.replace(
                  replace: isLoading,
                  replacement: Bone.square(
                    size: AppScale.w(120),
                    borderRadius: BorderRadius.circular(AppScale.r(16)),
                  ),
                  child: Image.asset(
                    imageAsset!,
                    height: cardHeight * 1.1, // Slightly taller to overlap the top
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ),
              
            // Dots Indicator
            if (showDots)
              Positioned(
                bottom: AppScale.h(16),
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    totalDots,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: AppScale.w(3)),
                      width: index == activeDotIndex ? AppScale.w(16) : AppScale.w(6),
                      height: AppScale.h(6),
                      decoration: BoxDecoration(
                        color: index == activeDotIndex
                            ? effectiveTextColor
                            : effectiveTextColor.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(AppScale.r(4)),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
