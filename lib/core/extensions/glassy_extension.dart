import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

/// Extension glassmorphism untuk membungkus widget dengan blur + gradient frost.
///
/// Efek paling terlihat jika ada konten berwarna/gradient di belakang widget.
extension GlassyExtension on Widget {
  Widget glassy({
    double blurred = 30,
    List<Color>? gradientColors,
    BorderRadius? borderRadius,
    double opacity = 1.0,
    bool forceBlur = false,
    Border? border,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final radius =
            borderRadius ?? BorderRadius.circular(AppScale.r(16));
        final resolvedBorder = border ??
            Border.all(
              color: AppColors.white.withValues(alpha: isDark ? 0.18 : 0.22),
            );
        final gradient = _resolveGradient(
          isDark: isDark,
          gradientColors: gradientColors,
          opacity: opacity,
        );
        final useBlur = isDark || forceBlur;

        final frostLayer = DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient,
            ),
            borderRadius: radius,
            border: resolvedBorder,
          ),
          child: this,
        );

        return ClipRRect(
          borderRadius: radius,
          child: useBlur
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: blurred,
                    sigmaY: blurred,
                  ),
                  child: frostLayer,
                )
              : frostLayer,
        );
      },
    );
  }
}

List<Color> _resolveGradient({
  required bool isDark,
  List<Color>? gradientColors,
  required double opacity,
}) {
  if (gradientColors != null && gradientColors.isNotEmpty) {
    return gradientColors
        .map((c) => c.withValues(alpha: c.a * opacity))
        .toList();
  }

  if (isDark) {
    return [
      AppColors.white.withValues(alpha: 0.08 * opacity),
      AppColors.white.withValues(alpha: 0.04 * opacity),
    ];
  }

  return [
    AppColors.white.withValues(alpha: 0.14 * opacity),
    AppColors.black.withValues(alpha: 0.08 * opacity),
  ];
}
