import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppStatsGlassyStyle extends StatelessWidget {
  final List<Color>? gradientColors;
  final String? title;
  final HeroIcons? icon;
  final String? label;
  final String? value;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool isMax;
  final bool isLoading;
  final Widget? child;
  final Color? backgroundColor;

  const AppStatsGlassyStyle({
    super.key,
    this.gradientColors,
    this.title,
    this.icon,
    this.label,
    this.value,
    this.onTap,
    this.width,
    this.height,
    this.isMax = false,
    this.isLoading = false,
    this.child,
    this.backgroundColor,
  });

  static const List<Color> defaultGradientColors = [
    Color(0xFFE843AD),
    Color(0xFF7C4DFF),
    Color(0xFFFF6B4A),
  ];

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(360));
    final cardHeight = height ?? AppScale.h(180);
    final colors = gradientColors ?? defaultGradientColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasBottom = value != null || label != null;
    final hasTop = title != null || icon != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppScale.r(24)),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? AppColors.black.withValues(alpha: 0.35)
                  : colors.first.withValues(alpha: 0.28),
              blurRadius: isDark ? 24 : 20,
              offset: Offset(0, isDark ? 12 : 8),
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
                    color: backgroundColor ?? (isDark
                        ? AppColors.surface
                        : AppColors.white),
                  ),
                ),
              ),
              ..._buildGlowBlobs(colors, isDark: isDark),
              _buildGlassLayer(isDark: isDark),
              Positioned.fill(
                child: CustomPaint(
                  painter: _NoiseTexturePainter(
                    opacity: isDark ? 0.04 : 0.03,
                    dotColor: AppColors.white,
                  ),
                ),
              ),
              if (child != null)
                Positioned.fill(
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: Padding(
                      padding: EdgeInsets.all(AppScale.w(24)),
                      child: child!,
                    ),
                  ),
                )
              else if (hasTop || hasBottom)
                Positioned.fill(
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: Padding(
                      padding: EdgeInsets.all(AppScale.w(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (hasTop)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (title != null)
                                  Expanded(
                                    child: Text(
                                      title!.toUpperCase(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: AppScale.sp(12),
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                        letterSpacing: 1.6,
                                      ),
                                    ),
                                  ),
                                if (title == null && icon != null)
                                  const Spacer(),
                                if (icon != null)
                                  _buildIconBadge(icon!, isLoading),
                              ],
                            ),
                          const Spacer(),
                          if (value != null)
                            Text(
                              value!.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: AppScale.sp(22),
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 0.5,
                                height: 1.2,
                              ),
                            ),
                          if (value != null && label != null)
                            SizedBox(height: AppScale.h(6)),
                          if (label != null)
                            Text(
                              label!.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: AppScale.sp(11),
                                fontWeight: FontWeight.w500,
                                color: AppColors.white.withValues(alpha: 0.55),
                                letterSpacing: 1.2,
                              ),
                            ),
                        ],
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

  Widget _buildGlassLayer({required bool isDark}) {
    final frostColor = isDark
        ? AppColors.white.withValues(alpha: 0.06)
        : AppColors.white.withValues(alpha: 0.1);
    final borderColor = AppColors.white.withValues(alpha: isDark ? 0.18 : 0.22);

    if (isDark) {
      return Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: frostColor,
              border: Border.all(color: borderColor, width: 1),
            ),
          ),
        ),
      );
    }

    // Light mode: hindari BackdropFilter memburamkan scaffold putih ke dalam card.
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.white.withValues(alpha: 0.14),
              AppColors.black.withValues(alpha: 0.08),
            ],
          ),
          border: Border.all(color: borderColor, width: 1),
        ),
      ),
    );
  }

  Widget _buildIconBadge(HeroIcons iconData, bool isLoading) {
    return Skeleton.replace(
      replace: isLoading,
      replacement: Bone.circle(size: AppScale.w(40)),
      child: Container(
        width: AppScale.w(40),
        height: AppScale.w(40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.35),
            width: 1.5,
          ),
          color: AppColors.white.withValues(alpha: 0.08),
        ),
        child: Center(
          child: HeroIcon(
            iconData,
            style: HeroIconStyle.outline,
            color: AppColors.white,
            size: AppScale.w(20),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGlowBlobs(List<Color> colors, {required bool isDark}) {
    final pink = colors.isNotEmpty ? colors[0] : defaultGradientColors[0];
    final purple = colors.length > 1 ? colors[1] : defaultGradientColors[1];
    final orange = colors.length > 2 ? colors[2] : defaultGradientColors[2];
    final opacityScale = isDark ? 1.0 : 1.15;

    Widget glowBlob({
      required double size,
      required Color color,
      double opacity = 0.75,
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
            stops: const [0.2, 1.0],
          ),
        ),
      );
    }

    return [
      Positioned(
        left: AppScale.w(-40),
        bottom: AppScale.h(-50),
        child: glowBlob(
          size: AppScale.w(180),
          color: pink,
          opacity: 0.8 * opacityScale,
        ),
      ),
      Positioned(
        right: AppScale.w(-50),
        top: AppScale.h(-60),
        child: glowBlob(
          size: AppScale.w(200),
          color: purple,
          opacity: 0.75 * opacityScale,
        ),
      ),
      Positioned(
        left: AppScale.w(60),
        top: AppScale.h(-30),
        child: glowBlob(
          size: AppScale.w(90),
          color: orange,
          opacity: 0.55 * opacityScale,
        ),
      ),
      Positioned(
        right: AppScale.w(30),
        bottom: AppScale.h(-20),
        child: glowBlob(
          size: AppScale.w(100),
          color: purple.withValues(alpha: 0.8),
          opacity: 0.4 * opacityScale,
        ),
      ),
    ];
  }
}

class _NoiseTexturePainter extends CustomPainter {
  _NoiseTexturePainter({
    required this.opacity,
    required this.dotColor,
  });

  final double opacity;
  final Color dotColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = dotColor.withValues(alpha: opacity);
    const step = 4.0;

    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        if ((x.toInt() + y.toInt()) % 7 == 0) {
          canvas.drawCircle(Offset(x, y), 0.6, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _NoiseTexturePainter oldDelegate) {
    return oldDelegate.opacity != opacity ||
        oldDelegate.dotColor != dotColor;
  }
}
