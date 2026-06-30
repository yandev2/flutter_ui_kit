import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../theme/app_scale.dart';

/// Variant animasi untuk [AnimatedWidgetExtension].
enum AppAnimationVariant {
  /// Melayang atas-bawah.
  floatVertical,

  /// Melayang kiri-kanan.
  floatHorizontal,

  /// Goyang (rotasi halus).
  shake,

  /// Membesar dan mengecil secara halus.
  pulse,

  /// Muncul dan meredup.
  fade,
}

/// Extension animasi loop untuk widget apa pun.
extension AnimatedWidgetExtension on Widget {
  Widget animated({
    AppAnimationVariant variant = AppAnimationVariant.floatVertical,
    double intensity = 0.5,
    Duration? duration,
  }) {
    final clampedIntensity = intensity.clamp(0.0, 1.0);
    if (clampedIntensity <= 0) return this;

    return _AnimatedMotionWrapper(
      variant: variant,
      intensity: clampedIntensity,
      duration: duration,
      child: this,
    );
  }
}

class _AnimatedMotionWrapper extends StatefulWidget {
  final AppAnimationVariant variant;
  final double intensity;
  final Duration? duration;
  final Widget child;

  const _AnimatedMotionWrapper({
    required this.variant,
    required this.intensity,
    this.duration,
    required this.child,
  });

  @override
  State<_AnimatedMotionWrapper> createState() => _AnimatedMotionWrapperState();
}

class _AnimatedMotionWrapperState extends State<_AnimatedMotionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Duration get _defaultDuration {
    switch (widget.variant) {
      case AppAnimationVariant.floatVertical:
      case AppAnimationVariant.floatHorizontal:
        return const Duration(milliseconds: 2200);
      case AppAnimationVariant.shake:
        return const Duration(milliseconds: 600);
      case AppAnimationVariant.pulse:
      case AppAnimationVariant.fade:
        return const Duration(milliseconds: 1500);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? _defaultDuration,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(covariant _AnimatedMotionWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newDuration = widget.duration ?? _defaultDuration;
    final oldDuration = oldWidget.duration ?? _defaultDuration;
    if (newDuration != oldDuration) {
      _controller.duration = newDuration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _sinValue => math.sin(_animation.value * math.pi * 2);

  @override
  Widget build(BuildContext context) {
    final floatDistance = sizeHeight(14) * widget.intensity;
    final shakeAngle = 0.04 * widget.intensity;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        switch (widget.variant) {
          case AppAnimationVariant.floatVertical:
            return Transform.translate(
              offset: Offset(0, _sinValue * floatDistance),
              child: child,
            );
          case AppAnimationVariant.floatHorizontal:
            return Transform.translate(
              offset: Offset(_sinValue * floatDistance, 0),
              child: child,
            );
          case AppAnimationVariant.shake:
            return Transform.rotate(
              angle: _sinValue * shakeAngle,
              child: child,
            );
          case AppAnimationVariant.pulse:
            // _sinValue is between -1 and 1.
            // We want scale to go from 1.0 to 1.0 + intensity*something.
            final scaleDiff = 0.1 * widget.intensity;
            // map _sinValue (-1 to 1) to (0 to 1) for scale to just increase and decrease from base
            final normalizedSin = (_sinValue + 1) / 2;
            return Transform.scale(
              scale: 1.0 + (normalizedSin * scaleDiff),
              child: child,
            );
          case AppAnimationVariant.fade:
            final opacityDiff = 0.5 * widget.intensity;
            final normalizedSin = (_sinValue + 1) / 2;
            return Opacity(
              opacity: 1.0 - (normalizedSin * opacityDiff),
              child: child,
            );
        }
      },
      child: widget.child,
    );
  }
}
