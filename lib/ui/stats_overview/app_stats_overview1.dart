import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppStatsOverview1 extends StatelessWidget {
  final List<Color>? gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final String? title;
  final String? subtitle;
  final String? value;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool isMax;
  final bool isLoading;

  const AppStatsOverview1({
    super.key,
    this.gradientColors,
    this.gradientBegin = Alignment.centerLeft,
    this.gradientEnd = Alignment.centerRight,
    this.title,
    this.subtitle,
    this.value,
    this.onTap,
    this.width,
    this.height,
    this.isMax = false,
    this.isLoading = false,
  });

  static const List<Color> defaultGradientColors = [
    Color(0xFF4A2FC0),
    Color(0xFF6B4CE6),
    Color(0xFF7B5AE8),
  ];

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(360));
    final cardHeight = height ?? AppScale.h(160);
    final colors = gradientColors ?? defaultGradientColors;
    final hasText = title != null || subtitle != null || value != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppScale.r(24)),
          boxShadow: [
            BoxShadow(
              color: colors.first.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppScale.r(24)),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: gradientBegin,
                      end: gradientEnd,
                      colors: colors,
                    ),
                  ),
                ),
              ),
              ..._buildPatternCircles(colors),
              if (hasText)
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(AppScale.w(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              if (title != null && subtitle != null)
                                SizedBox(height: AppScale.h(6)),
                              if (subtitle != null)
                                Skeleton.replace(
                                  replace: isLoading,
                                  replacement: Bone.text(words: 3),
                                  child: Text(
                                    subtitle!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: AppScale.sp(13),
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white.withValues(
                                        alpha: 0.75,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (value != null)
                          Skeleton.replace(
                            replace: isLoading,
                            replacement: Bone.text(words: 1),
                            child: Text(
                              value!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: AppScale.sp(28),
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                height: 1.1,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPatternCircles(List<Color> colors) {
    final base = colors.length > 1 ? colors[1] : colors.first;
    final deep = colors.first;
    final accent = colors.length > 2 ? colors.last : const Color(0xFFE843AD);

    Widget softCircle({
      required double size,
      required Color color,
      double opacity = 0.55,
    }) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.35, 1.0],
          ),
        ),
      );
    }

    return [
      Positioned(
        right: AppScale.w(-30),
        top: AppScale.h(-20),
        child: softCircle(size: AppScale.w(140), color: deep, opacity: 0.5),
      ),
      Positioned(
        right: AppScale.w(40),
        bottom: AppScale.h(-50),
        child: softCircle(size: AppScale.w(160), color: base, opacity: 0.45),
      ),
      Positioned(
        right: AppScale.w(-20),
        bottom: AppScale.h(10),
        child: softCircle(
          size: AppScale.w(110),
          color: base.withValues(alpha: 1),
          opacity: 0.4,
        ),
      ),
      Positioned(
        right: AppScale.w(8),
        top: AppScale.h(30),
        child: softCircle(size: AppScale.w(70), color: accent, opacity: 0.65),
      ),
      Positioned(
        right: AppScale.w(90),
        top: AppScale.h(-10),
        child: softCircle(
          size: AppScale.w(55),
          color: AppColors.white,
          opacity: 0.12,
        ),
      ),
      Positioned(
        right: AppScale.w(55),
        bottom: AppScale.h(25),
        child: softCircle(size: AppScale.w(90), color: deep, opacity: 0.35),
      ),
    ];
  }
}
