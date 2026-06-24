import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

enum AppCheckboxVariant { solid, outline, checkOnly }

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final AppCheckboxVariant variant;
  final Color? activeColor;
  final Color? checkColor;
  final double? size;
  
  final Color? backgroundColor;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.variant = AppCheckboxVariant.solid,
    this.activeColor,
    this.checkColor,
    this.size,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = activeColor ?? AppColors.primary;
    final finalSize = size ?? AppScale.w(20);
    
    final bool isChecked = value;

    // Define colors based on variant and state
    Color backgroundColor = Colors.transparent;
    Color borderColor = AppColors.border;
    Color iconColor = Colors.transparent;

    switch (variant) {
      case AppCheckboxVariant.solid:
        if (isChecked) {
          backgroundColor = color;
          borderColor = color;
          iconColor = checkColor ?? Colors.white;
        } else {
          backgroundColor = this.backgroundColor ?? theme.cardColor;
          borderColor = AppColors.border;
        }
        break;
      case AppCheckboxVariant.outline:
        if (isChecked) {
          borderColor = color;
          iconColor = checkColor ?? color;
        } else {
          borderColor = AppColors.border;
        }
        break;
      case AppCheckboxVariant.checkOnly:
        borderColor = Colors.transparent;
        if (isChecked) {
          iconColor = checkColor ?? color;
        }
        break;
    }

    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!value);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: finalSize,
        height: finalSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppScale.r(4)),
          border: Border.all(
            color: borderColor,
            width: AppScale.w(1.0), // Made softer (thinner)
          ),
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: finalSize * 0.7,
                color: iconColor,
              )
            : null,
      ),
    );
  }
}
