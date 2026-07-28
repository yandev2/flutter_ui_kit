import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../ui_component_flutter.dart';

class AppProgressCircle extends StatefulWidget {
  final double progress;

  final String? label;
  final String? value;
  final String? title;
  final String? description;

  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  final double? labelSize;
  final double? valueSize;
  final double? titleSize;
  final double? descriptionSize;

  final Color? labelColor;
  final Color? valueColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final Color? labelBackgroundColor;

  final Color? color;
  final List<Color>? gradientColors;
  final Color? trackColor;

  final double? diameter;
  final double? strokeWidth;
  final bool showThumb;
  final double? thumbSize;
  final Color? thumbColor;
  final Color? thumbBorderColor;

  final bool animateOnAppear;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool isLoading;

  const AppProgressCircle({
    super.key,
    required this.progress,
    this.label,
    this.value,
    this.title,
    this.description,
    this.labelStyle,
    this.valueStyle,
    this.titleStyle,
    this.descriptionStyle,
    this.labelSize,
    this.valueSize,
    this.titleSize,
    this.descriptionSize,
    this.labelColor,
    this.valueColor,
    this.titleColor,
    this.descriptionColor,
    this.labelBackgroundColor,
    this.color,
    this.gradientColors,
    this.trackColor,
    this.diameter,
    this.strokeWidth,
    this.showThumb = true,
    this.thumbSize,
    this.thumbColor,
    this.thumbBorderColor,
    this.animateOnAppear = true,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.animationCurve = Curves.easeOutCubic,
    this.isLoading = false,
  });

  @override
  State<AppProgressCircle> createState() => _AppProgressCircleState();
}

class _AppProgressCircleState extends State<AppProgressCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  double _targetProgress = 0;

  @override
  void initState() {
    super.initState();
    _targetProgress = widget.progress.clamp(0.0, 1.0);
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _progressAnimation = _buildProgressAnimation(
      begin: widget.animateOnAppear ? 0 : _targetProgress,
      end: _targetProgress,
    );
    if (widget.animateOnAppear) {
      _controller.forward();
    } else {
      _controller.value = 1;
    }
  }

  Animation<double> _buildProgressAnimation({
    required double begin,
    required double end,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _controller, curve: widget.animationCurve),
    );
  }

  void _animateTo(double target) {
    final clamped = target.clamp(0.0, 1.0);
    if (clamped == _targetProgress && _controller.isAnimating) return;

    _targetProgress = clamped;
    _progressAnimation = _buildProgressAnimation(
      begin: _progressAnimation.value,
      end: clamped,
    );
    _controller
      ..duration = widget.animationDuration
      ..forward(from: 0);
  }

  @override
  void didUpdateWidget(covariant AppProgressCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
    if (oldWidget.progress != widget.progress) {
      _animateTo(widget.progress);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _resolveArcEndColor(BuildContext context) {
    final uiTheme = context.uiTheme;
    if (widget.gradientColors != null && widget.gradientColors!.isNotEmpty) {
      return widget.gradientColors!.last;
    }
    return widget.color ?? uiTheme.primary;
  }

  TextStyle _resolveLabelStyle(BuildContext context) {
    final uiTheme = context.uiTheme;
    return widget.labelStyle ??
        Theme.of(context).textTheme.labelSmall?.copyWith(
              color: widget.labelColor ?? uiTheme.success,
              fontSize:
                  widget.labelSize != null ? size(widget.labelSize!) : size(11),
              fontWeight: FontWeight.w600,
            ) ??
        TextStyle(
          color: widget.labelColor ?? uiTheme.success,
          fontSize: widget.labelSize != null ? size(widget.labelSize!) : size(11),
          fontWeight: FontWeight.w600,
        );
  }

  TextStyle _resolveValueStyle(BuildContext context) {
    final uiTheme = context.uiTheme;
    return widget.valueStyle ??
        Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: widget.valueColor ?? uiTheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: widget.valueSize != null ? size(widget.valueSize!) : size(36),
            ) ??
        TextStyle(
          color: widget.valueColor ?? uiTheme.onBackground,
          fontWeight: FontWeight.bold,
          fontSize: widget.valueSize != null ? size(widget.valueSize!) : size(36),
        );
  }

  TextStyle _resolveTitleStyle(BuildContext context) {
    final uiTheme = context.uiTheme;
    return widget.titleStyle ??
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: widget.titleColor ?? uiTheme.onBackground,
              fontWeight: FontWeight.w600,
              fontSize: widget.titleSize != null ? size(widget.titleSize!) : size(14),
            ) ??
        TextStyle(
          color: widget.titleColor ?? uiTheme.onBackground,
          fontWeight: FontWeight.w600,
          fontSize: widget.titleSize != null ? size(widget.titleSize!) : size(14),
        );
  }

  TextStyle _resolveDescriptionStyle(BuildContext context) {
    final uiTheme = context.uiTheme;
    return widget.descriptionStyle ??
        Theme.of(context).textTheme.bodySmall?.copyWith(
              color: widget.descriptionColor ?? uiTheme.hintColor,
              fontSize: widget.descriptionSize != null
                  ? size(widget.descriptionSize!)
                  : size(11),
            ) ??
        TextStyle(
          color: widget.descriptionColor ?? uiTheme.hintColor,
          fontSize:
              widget.descriptionSize != null ? size(widget.descriptionSize!) : size(11),
        );
  }

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final scaledDiameter = size(widget.diameter ?? 160);
    final scaledStroke = size(widget.strokeWidth ?? 12);
    final scaledThumb = size(widget.thumbSize ?? 10);
    final activeColor = widget.color ?? uiTheme.primary;
    final track = widget.trackColor ?? uiTheme.borderColor.withValues(alpha: 0.35);
    final arcEndColor = _resolveArcEndColor(context);
    final displayValue =
        widget.value ?? '${(widget.progress.clamp(0.0, 1.0) * 100).round()}';

    return Skeletonizer(
      enabled: widget.isLoading,
      child: SizedBox(
        width: scaledDiameter,
        height: scaledDiameter,
        child: AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Skeleton.leaf(
                  child: CustomPaint(
                    size: Size(scaledDiameter, scaledDiameter),
                    painter: _CircleProgressPainter(
                      progress: _progressAnimation.value.clamp(0.0, 1.0),
                      strokeWidth: scaledStroke,
                      trackColor: track,
                      color: activeColor,
                      gradientColors: widget.gradientColors,
                      showThumb: widget.showThumb && !widget.isLoading,
                      thumbRadius: scaledThumb,
                      thumbColor: widget.thumbColor ?? arcEndColor,
                      thumbBorderColor: widget.thumbBorderColor ?? Colors.white,
                      hideProgressColors: widget.isLoading,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size(24)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.label != null) ...[
                        Skeleton.leaf(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size(10),
                              vertical: size(4),
                            ),
                            decoration: BoxDecoration(
                              color: widget.labelBackgroundColor ??
                                  uiTheme.success.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(size(999)),
                            ),
                            child: Text(
                              widget.label!,
                              style: _resolveLabelStyle(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: size(4)),
                      ],
                      Skeleton.leaf(
                        child: Text(
                          displayValue,
                          style: _resolveValueStyle(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.title != null) ...[
                        SizedBox(height: size(2)),
                        Skeleton.leaf(
                          child: Text(
                            widget.title!,
                            style: _resolveTitleStyle(context),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (widget.description != null) ...[
                        SizedBox(height: size(4)),
                        Skeleton.leaf(
                          child: Text(
                            widget.description!,
                            style: _resolveDescriptionStyle(context),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color trackColor;
  final Color color;
  final List<Color>? gradientColors;
  final bool showThumb;
  final double thumbRadius;
  final Color thumbColor;
  final Color thumbBorderColor;
  final bool hideProgressColors;

  static const double _startAngle = -math.pi / 2;

  const _CircleProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
    required this.color,
    this.gradientColors,
    required this.showThumb,
    required this.thumbRadius,
    required this.thumbColor,
    required this.thumbBorderColor,
    this.hideProgressColors = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * math.pi, false, trackPaint);

    if (hideProgressColors || progress <= 0) return;

    final sweep = 2 * math.pi * progress;
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (gradientColors != null && gradientColors!.length >= 2) {
      progressPaint.shader = SweepGradient(
        colors: gradientColors!,
        startAngle: _startAngle,
        endAngle: _startAngle + 2 * math.pi,
      ).createShader(rect);
    } else {
      progressPaint.color = color;
    }

    canvas.drawArc(rect, _startAngle, sweep, false, progressPaint);

    if (showThumb && progress > 0) {
      final angle = _startAngle + sweep;
      final thumbCenter = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final borderPaint = Paint()
        ..color = thumbBorderColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(thumbCenter, thumbRadius + strokeWidth * 0.15, borderPaint);

      final fillPaint = Paint()
        ..color = thumbColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(thumbCenter, thumbRadius, fillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.color != color ||
        oldDelegate.gradientColors != gradientColors ||
        oldDelegate.showThumb != showThumb ||
        oldDelegate.thumbRadius != thumbRadius ||
        oldDelegate.thumbColor != thumbColor ||
        oldDelegate.thumbBorderColor != thumbBorderColor ||
        oldDelegate.hideProgressColors != hideProgressColors;
  }
}
