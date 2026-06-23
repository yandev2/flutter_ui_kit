import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppSelectionPill extends StatelessWidget {
  final String text;
  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final Widget control;
  final Color? activeColor;

  const AppSelectionPill({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onChanged,
    required this.control,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AppScale.w(16),
          vertical: AppScale.h(12),
        ),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(AppScale.r(100)),
          border: Border.all(
            color: AppColors
                .border, // Selalu gunakan AppColors.border (soft gray/dark gray)
            width: AppScale.w(1.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IgnorePointer(child: control), // Let the pill handle the tap
            SizedBox(width: AppScale.w(8)),
            Text(
              text,
              style: TextStyle(
                fontSize: AppScale.sp(14),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(width: AppScale.w(8)), // extra padding for balance
          ],
        ),
      ),
    );
  }
}
