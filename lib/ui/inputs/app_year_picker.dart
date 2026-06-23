import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppYearPicker extends StatelessWidget {
  final String? title;
  final int? value;
  final ValueChanged<int?> onChanged;
  final String? hint;
  final IconData? prefixIcon;
  final bool isLoading;

  const AppYearPicker({
    super.key,
    this.title,
    this.value,
    required this.onChanged,
    this.hint,
    this.prefixIcon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayValue = value?.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              fontSize: AppScale.sp(14),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: AppScale.h(8)),
        ],
        PopupMenuButton<int>(
          onSelected: isLoading ? null : onChanged,
          position: PopupMenuPosition.under,
          offset: const Offset(0, 8),
          color: theme.scaffoldBackgroundColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppScale.r(16)),
            side: BorderSide(color: AppColors.border, width: 1),
          ),
          constraints: BoxConstraints(
            minWidth: AppScale.w(200),
            maxWidth: AppScale.w(240),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              enabled: false,
              padding: EdgeInsets.zero,
              child: _YearPopup(initialYear: value),
            ),
          ],
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppScale.w(16),
              vertical: AppScale.h(12),
            ),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              border: Border.all(
                color: AppColors.border,
                width: AppScale.w(1.0),
              ),
            ),
            child: Row(
              children: [
                if (prefixIcon != null) ...[
                  Icon(
                    prefixIcon,
                    color: AppColors.textSecondary,
                    size: AppScale.w(20),
                  ),
                  SizedBox(width: AppScale.w(12)),
                ],
                Expanded(
                  child: Text(
                    displayValue ?? hint ?? '',
                    style: TextStyle(
                      color: displayValue != null
                          ? theme.textTheme.bodyLarge?.color
                          : AppColors.textSecondary,
                      fontSize: AppScale.sp(14),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isLoading)
                  SizedBox(
                    width: AppScale.w(16),
                    height: AppScale.w(16),
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Icon(
                    Icons.calendar_month,
                    color: AppColors.textSecondary,
                    size: AppScale.w(18),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _YearPopup extends StatefulWidget {
  final int? initialYear;

  const _YearPopup({this.initialYear});

  @override
  State<_YearPopup> createState() => _YearPopupState();
}

class _YearPopupState extends State<_YearPopup> {
  late FixedExtentScrollController _controller;
  late int selectedYear;
  final int startYear = 1900;
  final int endYear = 2100;
  late List<int> years;

  @override
  void initState() {
    super.initState();
    years = List.generate(endYear - startYear + 1, (index) => startYear + index);
    selectedYear = widget.initialYear ?? DateTime.now().year;
    
    int initialIndex = years.indexOf(selectedYear);
    if (initialIndex == -1) initialIndex = years.indexOf(DateTime.now().year);
    
    _controller = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppScale.w(16), vertical: AppScale.h(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Year',
            style: TextStyle(
              fontSize: AppScale.sp(18),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: AppScale.h(24)),
          SizedBox(
            height: AppScale.h(200),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Selection indicator
                Container(
                  height: AppScale.h(40),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: AppColors.border, width: 3),
                      right: BorderSide(color: AppColors.border, width: 3),
                    ),
                  ),
                ),
                ListWheelScrollView.useDelegate(
                  controller: _controller,
                  itemExtent: AppScale.h(40),
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedYear = years[index];
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: years.length,
                    builder: (context, index) {
                      final isSelected = years[index] == selectedYear;
                      return Center(
                        child: Text(
                          years[index].toString(),
                          style: TextStyle(
                            fontSize: isSelected ? AppScale.sp(20) : AppScale.sp(14),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? theme.textTheme.bodyLarge?.color : AppColors.textSecondary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppScale.h(24)),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: AppScale.h(12)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppScale.r(8)),
                    ),
                    side: BorderSide(color: AppColors.border),
                  ),
                  child: Text('Cancel', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                ),
              ),
              SizedBox(width: AppScale.w(8)),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, selectedYear),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: AppScale.h(12)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppScale.r(8)),
                    ),
                  ),
                  child: Text('OK', style: TextStyle(color: AppColors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
