import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AppSelectionTile extends StatelessWidget {
  final Widget control; // AppCheckbox or AppRadio
  final String title;
  final String? description;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  final double? titleSize;
  final double? descriptionSize;

  const AppSelectionTile({
    super.key,
    required this.control,
    required this.title,
    this.description,
    required this.isSelected,
    required this.onChanged,
    this.titleSize,
    this.descriptionSize,
  });

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;

    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IgnorePointer(child: control),
          SizedBox(width: size(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
}
