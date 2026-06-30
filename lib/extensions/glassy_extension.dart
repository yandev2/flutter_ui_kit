import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ui_component_flutter/theme/theme.dart';

/// Variasi gaya Glassmorphism.
enum AppGlassyVariant {
  /// Halus dan tipis (cocok untuk overlay transparan elegan).
  smooth,

  /// Efek kaca es / buram standar (seperti frost).
  frosted,

  /// Efek tebal dan sangat buram.
  heavy,

  /// Efek embun pagi (transparansi tinggi dengan sedikit kebiruan terang).
  dew,
}

/// Extension glassmorphism untuk membungkus widget dengan blur + gradient frost.
///
/// Efek paling terlihat jika ada konten berwarna/gradient di belakang widget.
extension GlassyExtension on Widget {
  /// Memberikan efek Glassmorphism di belakang widget ini.
  Widget glassy({
    AppGlassyVariant variant = AppGlassyVariant.frosted,
    double? customBlur,
    List<Color>? customGradientColors,
    BorderRadius? borderRadius,
    double? customOpacity,
    bool forceBlur = true,
    Border? customBorder,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final radius = borderRadius ?? BorderRadius.circular(AppRadius.md);

        // Setup parameter berdasarkan variant
        final blurValue = customBlur ?? _getBlurFromVariant(variant);
        final baseOpacity = customOpacity ?? _getOpacityFromVariant(variant);

        // Resolusi warna gradient frost
        final gradient = _resolveGradient(
          isDark: isDark,
          variant: variant,
          customGradient: customGradientColors,
          opacity: baseOpacity,
        );

        // Border bawaan glassy (sedikit terang untuk efek kaca/pantulan cahaya)
        final resolvedBorder =
            customBorder ??
            Border.all(
              color: Colors.white.withValues(alpha: isDark ? 0.15 : 0.2),
              width: 1.0,
            );

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

        return RepaintBoundary(
          child: ClipRRect(
            borderRadius: radius,
            child: forceBlur
                ? BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: blurValue,
                      sigmaY: blurValue,
                    ),
                    child: frostLayer,
                  )
                : frostLayer,
          ),
        );
      },
    );
  }
}

double _getBlurFromVariant(AppGlassyVariant variant) {
  switch (variant) {
    case AppGlassyVariant.smooth:
      return 10.0;
    case AppGlassyVariant.frosted:
      return 30.0;
    case AppGlassyVariant.heavy:
      return 50.0;
    case AppGlassyVariant.dew:
      return 25.0;
  }
}

double _getOpacityFromVariant(AppGlassyVariant variant) {
  switch (variant) {
    case AppGlassyVariant.smooth:
      return 0.5;
    case AppGlassyVariant.frosted:
      return 1.0;
    case AppGlassyVariant.heavy:
      return 1.5; // Menguatkan efek opacity di formula
    case AppGlassyVariant.dew:
      return 0.3; // Sangat tipis warnanya
  }
}

List<Color> _resolveGradient({
  required bool isDark,
  required AppGlassyVariant variant,
  List<Color>? customGradient,
  required double opacity,
}) {
  if (customGradient != null && customGradient.isNotEmpty) {
    return customGradient
        .map((c) => c.withValues(alpha: c.a * opacity))
        .toList();
  }

  // Jika Dew, sedikit beri hint warna biru keputihan
  if (variant == AppGlassyVariant.dew) {
    return [
      const Color(0xFFE0F7FA).withValues(alpha: 0.15 * opacity),
      const Color(0xFFB2EBF2).withValues(alpha: 0.05 * opacity),
    ];
  }

  if (isDark) {
    return [
      Colors.white.withValues(alpha: 0.10 * opacity),
      Colors.white.withValues(alpha: 0.03 * opacity),
    ];
  }

  return [
    Colors.white.withValues(alpha: 0.25 * opacity),
    Colors.black.withValues(alpha: 0.05 * opacity), // Sedikit gelap di bawah
  ];
}
