import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

enum AppRadioVariant { solid, outline, dotOnly }

class AppRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final AppRadioVariant variant;
  final Color? activeColor;
  final Color? dotColor;
  final double? sized;

  final Color? backgroundColor;

  final String? title;
  final String? description;
  final double? titleSize;
  final double? descriptionSize;

  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.variant = AppRadioVariant.outline,
    this.activeColor,
    this.dotColor,
    this.sized,
    this.backgroundColor,
    this.title,
    this.description,
    this.titleSize,
    this.descriptionSize,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final color = activeColor ?? uiTheme.primary;
    final finalSize = sized ?? size(20);

    // Define colors based on variant and state
    Color finalBackgroundColor = Colors.transparent;
    Color borderColor = uiTheme.borderColor;
    Color innerDotColor = Colors.transparent;

    switch (variant) {
      case AppRadioVariant.solid:
        if (isSelected) {
          finalBackgroundColor = color;
          borderColor = color;
          innerDotColor = dotColor ?? uiTheme.onPrimary;
        } else {
          finalBackgroundColor = backgroundColor ?? uiTheme.surface;
          borderColor = uiTheme.borderColor;
        }
        break;
      case AppRadioVariant.outline:
        if (isSelected) {
          borderColor = color;
          innerDotColor = dotColor ?? color;
        } else {
          borderColor = uiTheme.borderColor;
        }
        break;
      case AppRadioVariant.dotOnly:
        borderColor = Colors.transparent;
        if (isSelected) {
          innerDotColor = dotColor ?? color;
        }
        break;
    }

    Widget radioWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: finalSize,
      height: finalSize,
      decoration: BoxDecoration(
        color: finalBackgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: size(1), // Made softer (thinner)
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
    );

    if (title != null) {
      return GestureDetector(
        onTap: () {
          if (onChanged != null && !isSelected) {
            onChanged?.call(value);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            radioWidget,
            SizedBox(width: size(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: titleSize ?? size(14),
                      fontWeight: FontWeight.bold,
                      color: uiTheme.onBackground,
                    ),
                  ),
                  if (description != null) ...[
                    SizedBox(height: sizeHeight(4)),
                    Text(
                      description!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: descriptionSize ?? size(12),
                        color: uiTheme.hintColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (onChanged != null && !isSelected) {
          onChanged?.call(value);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: radioWidget,
    );
  }
}
