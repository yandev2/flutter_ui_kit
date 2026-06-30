import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AppSelectionPill extends StatelessWidget {
  final String text;
  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final Widget control;
  final Color? activeColor;
  final double? textSize;

  const AppSelectionPill({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onChanged,
    required this.control,
    this.activeColor,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;

    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: size(16),
          vertical: sizeHeight(12),
        ),
        decoration: BoxDecoration(
          color: uiTheme.surface,
          borderRadius: BorderRadius.circular(size(100)),
          border: Border.all(color: uiTheme.borderColor, width: size(1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IgnorePointer(child: control), // Let the pill handle the tap
            SizedBox(width: size(8)),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: textSize ?? size(14),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: uiTheme.onBackground,
              ),
            ),
            SizedBox(width: size(8)), // extra padding for balance
          ],
        ),
      ),
    );
  }
}
