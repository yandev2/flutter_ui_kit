import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

enum AppButtonVariant { solid, outline, dashed, smooth, gradient, raised, text }

enum AppButtonShape { rounded, pill, circle, square }

enum AppButtonSize { small, medium, large }

enum IconPosition { left, right, top }

class AppButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Widget? customIcon;
  final VoidCallback? onPressed;

  final AppButtonVariant variant;
  final AppButtonShape shape;
  final AppButtonSize size;
  final IconPosition iconPosition;

  final Color? color;
  final Color? textColor;
  final List<Color>? gradientColors;
  final bool isFullWidth;
  final bool isLoading;

  const AppButton({
    super.key,
    this.text,
    this.icon,
    this.customIcon,
    required this.onPressed,
    this.variant = AppButtonVariant.solid,
    this.shape = AppButtonShape.rounded,
    this.size = AppButtonSize.medium,
    this.iconPosition = IconPosition.left,
    this.color,
    this.textColor,
    this.gradientColors,
    this.isFullWidth = false,
    this.isLoading = false,
  }) : assert(
         text != null || icon != null || customIcon != null,
         'Tombol harus memiliki teks atau ikon',
       );

  // Helper constructors
  const AppButton.icon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppButtonVariant.solid,
    this.shape = AppButtonShape.circle,
    this.size = AppButtonSize.medium,
    this.color,
    this.textColor,
    this.gradientColors,
    this.isLoading = false,
  }) : text = null,
       customIcon = null,
       isFullWidth = false,
       iconPosition = IconPosition.left;

  const AppButton.text({
    super.key,
    required this.text,
    this.icon,
    this.customIcon,
    required this.onPressed,
    this.shape = AppButtonShape.rounded,
    this.size = AppButtonSize.medium,
    this.iconPosition = IconPosition.left,
    this.color,
    this.textColor,
    this.gradientColors,
    this.isFullWidth = false,
    this.isLoading = false,
  }) : variant = AppButtonVariant.text;

  // Resolving Dimensions
  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return AppScale.h(32);
      case AppButtonSize.large:
        return AppScale.h(56);
      case AppButtonSize.medium:
        return AppScale.h(48);
    }
  }

  EdgeInsetsGeometry get _padding {
    // Jika bentuknya lingkaran atau kotak, padding disamakan agar presisi
    if (shape == AppButtonShape.circle ||
        shape == AppButtonShape.square ||
        (text == null)) {
      return EdgeInsets.zero;
    }

    switch (size) {
      case AppButtonSize.small:
        return EdgeInsets.symmetric(horizontal: AppScale.w(16));
      case AppButtonSize.large:
        return EdgeInsets.symmetric(horizontal: AppScale.w(32));
      case AppButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: AppScale.w(24));
    }
  }

  double get _fontSize {
    switch (size) {
      case AppButtonSize.small:
        return AppScale.sp(12);
      case AppButtonSize.large:
        return AppScale.sp(16);
      case AppButtonSize.medium:
        return AppScale.sp(14);
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.small:
        return AppScale.r(16);
      case AppButtonSize.large:
        return AppScale.r(24);
      case AppButtonSize.medium:
        return AppScale.r(20);
    }
  }

  double get _borderRadius {
    switch (shape) {
      case AppButtonShape.pill:
        return AppScale.r(100);
      case AppButtonShape.circle:
        return AppScale.r(100);
      case AppButtonShape.square:
        return AppScale.r(12); // Slightly rounded square
      case AppButtonShape.rounded:
        return AppScale.r(8); // Standard rounding
    }
  }

  // Resolving Colors
  Color get _baseColor => color ?? AppColors.primary;

  Color get _textColor {
    if (textColor != null) return textColor!;
    if (variant == AppButtonVariant.solid ||
        variant == AppButtonVariant.gradient ||
        variant == AppButtonVariant.raised) {
      return AppColors.white;
    }
    return _baseColor;
  }

  Color get _backgroundColor {
    switch (variant) {
      case AppButtonVariant.solid:
      case AppButtonVariant.raised:
        return _baseColor;
      case AppButtonVariant.smooth:
        return _baseColor.withValues(alpha: 0.1);
      case AppButtonVariant.gradient:
      case AppButtonVariant.outline:
      case AppButtonVariant.dashed:
      case AppButtonVariant.text:
        return Colors.transparent;
    }
  }

  // Build Layout (Row for Left/Right, Column for Top)
  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: CircularProgressIndicator(color: _textColor, strokeWidth: 2),
      );
    }

    Widget? iconWidget;
    if (customIcon != null) {
      iconWidget = customIcon;
    } else if (icon != null) {
      iconWidget = Icon(icon, size: _iconSize, color: _textColor);
    }

    if (text == null && iconWidget != null) return iconWidget;
    if (iconWidget == null && text != null) {
      return Text(
        text!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _textColor,
          fontSize: _fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    // Both text and icon
    final textWidget = Text(
      text!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: _textColor,
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
      ),
    );

    if (iconPosition == IconPosition.top) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget!,
            SizedBox(height: AppScale.h(4)),
            textWidget,
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconPosition == IconPosition.left) ...[
          iconWidget!,
          SizedBox(width: AppScale.w(8)),
        ],
        Flexible(child: textWidget),
        if (iconPosition == IconPosition.right) ...[
          SizedBox(width: AppScale.w(8)),
          iconWidget!,
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget innerContent = Container(
      width: isFullWidth
          ? double.infinity
          : ((shape == AppButtonShape.circle || shape == AppButtonShape.square)
                ? _height
                : null),
      height: _height,
      padding: _padding,
      alignment: Alignment.center,
      child: _buildContent(),
    );

    Widget buttonContent = Ink(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        gradient: variant == AppButtonVariant.gradient
            ? LinearGradient(
                colors: gradientColors != null && gradientColors!.length >= 2
                    ? gradientColors!
                    : [_baseColor.withValues(alpha: 0.7), _baseColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        boxShadow: variant == AppButtonVariant.raised
            ? [
                BoxShadow(
                  color: _baseColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
        border: variant == AppButtonVariant.outline
            ? Border.all(color: _baseColor, width: 1.5)
            : null,
      ),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(_borderRadius),
        splashColor: _textColor.withValues(alpha: 0.1),
        highlightColor: _textColor.withValues(alpha: 0.05),
        child: innerContent,
      ),
    );

    if (variant == AppButtonVariant.dashed) {
      buttonContent = DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: _baseColor,
          strokeWidth: 1.5,
          dashPattern: const [6, 4],
          radius: Radius.circular(_borderRadius),
          padding: EdgeInsets.zero,
        ),
        child: buttonContent,
      );
    }

    return Material(
      color: Colors.transparent,
      child: isFullWidth
          ? SizedBox(width: double.infinity, child: buttonContent)
          : Row(mainAxisSize: MainAxisSize.min, children: [Flexible(child: buttonContent)]),
    );
  }
}
