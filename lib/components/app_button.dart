import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../ui_component_flutter.dart';
import '../theme/app_scale.dart' as scale;

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
  final bool isMax;
  final bool isLoading;

  final double? iconSize;
  final double? textSize;

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
    this.isMax = false,
    this.isLoading = false,
    this.iconSize,
    this.textSize,
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
    this.iconSize,
    this.textSize,
  }) : text = null,
       customIcon = null,
       isMax = false,
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
    this.isMax = false,
    this.isLoading = false,
    this.iconSize,
    this.textSize,
  }) : variant = AppButtonVariant.text;

  // Resolving Dimensions
  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return scale.sizeHeight(32);
      case AppButtonSize.large:
        return scale.sizeHeight(56);
      case AppButtonSize.medium:
        return scale.sizeHeight(48);
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
        return EdgeInsets.symmetric(horizontal: scale.size(16));
      case AppButtonSize.large:
        return EdgeInsets.symmetric(horizontal: scale.size(32));
      case AppButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: scale.size(24));
    }
  }

  double get _fontSize {
    if (textSize != null) return textSize!;
    switch (size) {
      case AppButtonSize.small:
        return scale.size(12);
      case AppButtonSize.large:
        return scale.size(16);
      case AppButtonSize.medium:
        return scale.size(14);
    }
  }

  double get _iconSize {
    if (iconSize != null) return iconSize!;
    switch (size) {
      case AppButtonSize.small:
        return scale.size(16);
      case AppButtonSize.large:
        return scale.size(24);
      case AppButtonSize.medium:
        return scale.size(20);
    }
  }

  double get _borderRadius {
    switch (shape) {
      case AppButtonShape.pill:
        return scale.size(100);
      case AppButtonShape.circle:
        return scale.size(100);
      case AppButtonShape.square:
        return scale.size(12); // Slightly rounded square
      case AppButtonShape.rounded:
        return scale.size(8); // Standard rounding
    }
  }

  // Resolving Colors dynamically using context theme
  Color _baseColor(BuildContext context) => color ?? context.uiTheme.primary;

  Color _textColor(BuildContext context) {
    if (textColor != null) return textColor!;
    if (variant == AppButtonVariant.solid ||
        variant == AppButtonVariant.gradient ||
        variant == AppButtonVariant.raised) {
      return context.uiTheme.onPrimary;
    }
    return _baseColor(context);
  }

  Color _backgroundColor(BuildContext context) {
    switch (variant) {
      case AppButtonVariant.solid:
      case AppButtonVariant.raised:
        return _baseColor(context);
      case AppButtonVariant.smooth:
        return _baseColor(context).withValues(alpha: 0.1);
      case AppButtonVariant.gradient:
      case AppButtonVariant.outline:
      case AppButtonVariant.dashed:
      case AppButtonVariant.text:
        return Colors.transparent;
    }
  }

  // Build Layout (Row for Left/Right, Column for Top)
  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: CircularProgressIndicator(
          color: _textColor(context),
          strokeWidth: 2,
        ),
      );
    }

    Widget? iconWidget;
    if (customIcon != null) {
      iconWidget = customIcon;
    } else if (icon != null) {
      iconWidget = Icon(icon, size: _iconSize, color: _textColor(context));
    }

    if (text == null && iconWidget != null) return iconWidget;
    if (iconWidget == null && text != null) {
      return Text(
        text!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _textColor(context),
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
        color: _textColor(context),
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
            SizedBox(height: scale.sizeHeight(4)),
            textWidget,
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isUnbounded = constraints.maxWidth == double.infinity;

        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPosition == IconPosition.left) ...[
              iconWidget!,
              SizedBox(width: scale.size(8)),
            ],
            // Jika constraints unbounded (misal di scroll horizontal), tidak boleh pakai Flexible
            isUnbounded ? textWidget : Flexible(child: textWidget),
            if (iconPosition == IconPosition.right) ...[
              SizedBox(width: scale.size(8)),
              iconWidget!,
            ],
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget innerContent = Container(
      width: isMax
          ? double.infinity
          : ((shape == AppButtonShape.circle || shape == AppButtonShape.square)
                ? _height
                : null),
      height: _height,
      padding: _padding,
      alignment: Alignment.center,
      child: _buildContent(context),
    );

    Widget buttonContent = Ink(
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(_borderRadius),
        gradient: variant == AppButtonVariant.gradient
            ? LinearGradient(
                colors: gradientColors != null && gradientColors!.length >= 2
                    ? gradientColors!
                    : [
                        _baseColor(context).withValues(alpha: 0.7),
                        _baseColor(context),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        boxShadow: variant == AppButtonVariant.raised
            ? [
                BoxShadow(
                  color: _baseColor(context).withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
        border: variant == AppButtonVariant.outline
            ? Border.all(color: _baseColor(context), width: 1.5)
            : null,
      ),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(_borderRadius),
        splashColor: _textColor(context).withValues(alpha: 0.1),
        highlightColor: _textColor(context).withValues(alpha: 0.05),
        child: innerContent,
      ),
    );

    if (variant == AppButtonVariant.dashed) {
      buttonContent = DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: _baseColor(context),
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
      child: isMax
          ? SizedBox(width: double.infinity, child: buttonContent)
          : buttonContent, // Langsung return tanpa outer Row+Flexible agar kompatibel dengan LayoutBuilder
    );
  }
}
