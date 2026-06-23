import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppSelectionTile extends StatelessWidget {
  final Widget control; // AppCheckbox or AppRadio
  final String title;
  final String? description;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const AppSelectionTile({
    super.key,
    required this.control,
    required this.title,
    this.description,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IgnorePointer(child: control),
          SizedBox(width: AppScale.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppScale.sp(14),
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                if (description != null) ...[
                  SizedBox(height: AppScale.h(4)),
                  Text(
                    description!,
                    style: TextStyle(
                      fontSize: AppScale.sp(12),
                      color: AppColors.textSecondary,
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
}
