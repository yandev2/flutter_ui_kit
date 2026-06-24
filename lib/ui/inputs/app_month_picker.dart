import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppMonthPicker extends StatelessWidget {
  final String? title;
  final int? value;
  final ValueChanged<int?> onChanged;
  final String? hint;
  final IconData? prefixIcon;
  final bool isLoading;
  
  final double? titleSize;
  final double? textSize;
  final double? hintSize;
  
  final Color? fillColor;

  static const List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June', 
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  const AppMonthPicker({
    super.key,
    this.title,
    this.value,
    required this.onChanged,
    this.hint,
    this.prefixIcon,
    this.isLoading = false,
    this.titleSize,
    this.textSize,
    this.hintSize,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayValue = value != null && value! >= 1 && value! <= 12 ? monthNames[value! - 1] : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              fontSize: titleSize ?? AppScale.sp(14),
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
              child: _MonthPopup(initialMonth: value),
            ),
          ],
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppScale.w(16),
              vertical: AppScale.h(12),
            ),
            decoration: BoxDecoration(
              color: fillColor ?? theme.scaffoldBackgroundColor,
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
                      fontSize: (displayValue != null ? textSize : hintSize) ?? AppScale.sp(14),
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

class _MonthPopup extends StatefulWidget {
  final int? initialMonth;

  const _MonthPopup({this.initialMonth});

  @override
  State<_MonthPopup> createState() => _MonthPopupState();
}

class _MonthPopupState extends State<_MonthPopup> {
  late FixedExtentScrollController _controller;
  late int selectedMonth;
  final int startMonth = 1;
  final int endMonth = 12;
  late List<int> months;

  @override
  void initState() {
    super.initState();
    months = List.generate(endMonth - startMonth + 1, (index) => startMonth + index);
    selectedMonth = widget.initialMonth ?? DateTime.now().month;
    
    int initialIndex = months.indexOf(selectedMonth);
    if (initialIndex == -1) initialIndex = months.indexOf(DateTime.now().month);
    
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
            'Month',
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
                      selectedMonth = months[index];
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: months.length,
                    builder: (context, index) {
                      final isSelected = months[index] == selectedMonth;
                      return Center(
                        child: Text(
                          AppMonthPicker.monthNames[months[index] - 1],
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
                  onPressed: () => Navigator.pop(context, selectedMonth),
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
