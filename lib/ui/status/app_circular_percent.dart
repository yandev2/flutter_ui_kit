import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppCircularPercent extends StatelessWidget {
  final double progress;
  final List<Color>? gradientColors;
  final String? label;
  final Color? labelColor;
  final String? value;
  final bool showPercentSign;
  final String? title;
  final String? subtitle;
  final double? size;
  final double? strokeWidth;
  final Color? trackColor;
  final bool isLoading;
  final VoidCallback? onTap;

  const AppCircularPercent({
    super.key,
    required this.progress,
    this.gradientColors,
    this.label,
    this.labelColor,
    this.value,
    this.showPercentSign = false,
    this.title,
    this.subtitle,
    this.size,
    this.strokeWidth,
    this.trackColor,
    this.isLoading = false,
    this.onTap,
  });

  static const List<Color> defaultGradientColors = [
    Color(0xFF4A3AFF),
    Color(0xFF7C5CFF),
    Color(0xFFB06CFF),
  ];

  static const List<Color> blueGradient = [
    Color(0xFF2563EB),
    Color(0xFF60A5FA),
  ];

  static const List<Color> greenPurpleGradient = [
    Color(0xFF22C55E),
    Color(0xFF7C3AED),
  ];

  static const List<Color> purplePinkGradient = [
    Color(0xFF7C3AED),
    Color(0xFFEC4899),
  ];

  double get _safeProgress => progress.clamp(0.0, 1.0);

  String get _displayValue {
    if (value != null) return value!;
    final percent = (_safeProgress * 100).round();
    return showPercentSign ? '$percent%' : '$percent';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final widgetSize = size ?? AppScale.w(168);
    final ringWidth = strokeWidth ?? AppScale.w(10);
    final colors = gradientColors ?? defaultGradientColors;
    final badgeColor = labelColor ?? AppColors.success;
    final ringTrackColor = trackColor ??
        (isDark ? AppColors.neutral700 : AppColors.neutral200);

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: widgetSize,
          height: widgetSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: widgetSize,
                height: widgetSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? AppColors.surface : AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(
                        alpha: isDark ? 0.28 : 0.04,
                      ),
                      blurRadius: isDark ? 18 : 12,
                      offset: Offset(0, isDark ? 8 : 4),
                    ),
                  ],
                  border: isDark
                      ? Border.all(color: AppColors.border, width: 1)
                      : null,
                ),
              ),
              CustomPaint(
                size: Size(widgetSize, widgetSize),
                painter: _CircularPercentPainter(
                  progress: _safeProgress,
                  gradientColors: colors,
                  trackColor: ringTrackColor,
                  strokeWidth: ringWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(ringWidth + AppScale.w(10)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (label != null) ...[
                        Skeleton.leaf(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppScale.w(10),
                              vertical: AppScale.h(4),
                            ),
                            decoration: BoxDecoration(
                              color: badgeColor.withValues(alpha: 0.15),
                              borderRadius:
                                  BorderRadius.circular(AppScale.r(100)),
                            ),
                            child: Text(
                              label!,
                              style: TextStyle(
                                fontSize: AppScale.sp(10),
                                fontWeight: FontWeight.w600,
                                color: badgeColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppScale.h(6)),
                      ],
                      Skeleton.replace(
                        replace: isLoading,
                        replacement: Bone.text(words: 1),
                        child: Text(
                          _displayValue,
                          style: TextStyle(
                            fontSize: AppScale.sp(28),
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            height: 1,
                          ),
                        ),
                      ),
                      if (title != null) ...[
                        SizedBox(height: AppScale.h(4)),
                        Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.text(words: 2),
                          child: Text(
                            title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppScale.sp(12),
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                      if (subtitle != null) ...[
                        SizedBox(height: AppScale.h(6)),
                        Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.text(words: 4),
                          child: Text(
                            subtitle!,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppScale.sp(10),
                              color: AppColors.textSecondary,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircularPercentPainter extends CustomPainter {
  final double progress;
  final List<Color> gradientColors;
  final Color trackColor;
  final double strokeWidth;

  static const double _startAngle = -math.pi / 2;

  const _CircularPercentPainter({
    required this.progress,
    required this.gradientColors,
    required this.trackColor,
    required this.strokeWidth,
  });

  Color _colorAtProgress(double value) {
    if (gradientColors.isEmpty) return AppColors.primary;
    if (gradientColors.length == 1) return gradientColors.first;
    final scaled = value.clamp(0.0, 1.0) * (gradientColors.length - 1);
    final index = scaled.floor().clamp(0, gradientColors.length - 2);
    final t = scaled - index;
    return Color.lerp(
      gradientColors[index],
      gradientColors[index + 1],
      t,
    )!;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, math.pi * 2, false, trackPaint);

    if (progress <= 0) return;

    final sweep = math.pi * 2 * progress;
    final stops = gradientColors.length == 1
        ? const <double>[0.0]
        : List.generate(
            gradientColors.length,
            (index) => index / (gradientColors.length - 1),
          );
    final gradient = SweepGradient(
      startAngle: _startAngle,
      endAngle: _startAngle + sweep,
      colors: gradientColors,
      stops: stops,
    );

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    canvas.drawArc(rect, _startAngle, sweep, false, progressPaint);

    final knobAngle = _startAngle + sweep;
    final knobCenter = Offset(
      center.dx + radius * math.cos(knobAngle),
      center.dy + radius * math.sin(knobAngle),
    );
    final knobRadius = strokeWidth * 0.55;
    final knobColor = _colorAtProgress(progress);

    canvas.drawCircle(
      knobCenter,
      knobRadius + AppScale.w(2),
      Paint()..color = AppColors.white,
    );
    canvas.drawCircle(
      knobCenter,
      knobRadius,
      Paint()..color = knobColor,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularPercentPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.gradientColors != gradientColors;
  }
}
