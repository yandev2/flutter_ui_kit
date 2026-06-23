import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

enum AppRadioVariant { solid, outline, dotOnly }

class AppRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final AppRadioVariant variant;
  final Color? activeColor;
  final Color? dotColor;
  final double? size;

  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.variant = AppRadioVariant.outline,
    this.activeColor,
    this.dotColor,
    this.size,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = activeColor ?? AppColors.primary;
    final finalSize = size ?? AppScale.w(20);
    
    // Define colors based on variant and state
    Color backgroundColor = Colors.transparent;
    Color borderColor = AppColors.border;
    Color innerDotColor = Colors.transparent;

    switch (variant) {
      case AppRadioVariant.solid:
        if (isSelected) {
          backgroundColor = color;
          borderColor = color;
          innerDotColor = dotColor ?? Colors.white;
        } else {
          backgroundColor = theme.cardColor;
          borderColor = AppColors.border;
        }
        break;
      case AppRadioVariant.outline:
        if (isSelected) {
          borderColor = color;
          innerDotColor = dotColor ?? color;
        } else {
          borderColor = AppColors.border;
        }
        break;
      case AppRadioVariant.dotOnly:
        borderColor = Colors.transparent;
        if (isSelected) {
          innerDotColor = dotColor ?? color;
        }
        break;
    }

    return GestureDetector(
      onTap: () {
        if (onChanged != null && !isSelected) {
          onChanged!(value);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: finalSize,
        height: finalSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: AppScale.w(1.0), // Made softer (thinner)
          ),
        ),
        alignment: Alignment.center,
        child: isSelected
            ? AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: finalSize * 0.45,
                height: finalSize * 0.45,
                decoration: BoxDecoration(
                  color: innerDotColor,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }
}
