import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppDatePicker extends StatelessWidget {
  final String? title;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String? hint;
  final IconData? prefixIcon;
  final bool isLoading;

  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  const AppDatePicker({
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
    final displayValue = value != null
        ? '${value!.day.toString().padLeft(2, '0')} ${AppDatePicker.monthNames[value!.month - 1]} ${value!.year}'
        : null;

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
        PopupMenuButton<DateTime>(
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
            minWidth: AppScale.w(320),
            maxWidth: AppScale.w(360),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<DateTime>(
              enabled: false,
              padding: EdgeInsets.zero,
              child: _CalendarPopup(initialDate: value),
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
                    Icons.calendar_today,
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

class _CalendarPopup extends StatefulWidget {
  final DateTime? initialDate;

  const _CalendarPopup({this.initialDate});

  @override
  State<_CalendarPopup> createState() => _CalendarPopupState();
}

class _CalendarPopupState extends State<_CalendarPopup> {
  late DateTime currentMonth;
  DateTime? selectedDate;

  final List<String> weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    currentMonth = selectedDate != null
        ? DateTime(selectedDate!.year, selectedDate!.month)
        : DateTime(DateTime.now().year, DateTime.now().month);
  }

  void _prevMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Calculate days
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final daysInMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    ).day;
    final firstWeekday = firstDayOfMonth.weekday; // 1 = Mon, 7 = Sun
    final emptyStart = firstWeekday == 7 ? 0 : firstWeekday;

    final daysInPrevMonth = DateTime(
      currentMonth.year,
      currentMonth.month,
      0,
    ).day;

    List<Widget> dayWidgets = [];

    // Header
    Widget header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _prevMonth,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              side: BorderSide(color: AppColors.border),
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${AppDatePicker.monthNames[currentMonth.month - 1]} ${currentMonth.year}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppScale.sp(16),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: _nextMonth,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              side: BorderSide(color: AppColors.border),
            ),
          ),
        ),
      ],
    );

    // Weekdays
    Widget weekdaysRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontSize: AppScale.sp(14),
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );

    // Grid cells
    int totalCells = emptyStart + daysInMonth;
    int totalRows = (totalCells / 7).ceil();
    int cellCount = totalRows * 7;

    for (int i = 0; i < cellCount; i++) {
      if (i < emptyStart) {
        // Prev month days
        int day = daysInPrevMonth - emptyStart + i + 1;
        dayWidgets.add(
          Container(
            width: AppScale.w(36),
            height: AppScale.w(36),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                fontSize: AppScale.sp(14),
              ),
            ),
          ),
        );
      } else if (i >= emptyStart && i < emptyStart + daysInMonth) {
        // Current month days
        int day = i - emptyStart + 1;
        bool isSelected =
            selectedDate != null &&
            selectedDate!.year == currentMonth.year &&
            selectedDate!.month == currentMonth.month &&
            selectedDate!.day == day;

        dayWidgets.add(
          GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = DateTime(
                  currentMonth.year,
                  currentMonth.month,
                  day,
                );
              });
            },
            child: Container(
              width: AppScale.w(36),
              height: AppScale.w(36),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(AppScale.r(8)),
              ),
              alignment: Alignment.center,
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected
                      ? AppColors.white
                      : theme.textTheme.bodyLarge?.color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: AppScale.sp(14),
                ),
              ),
            ),
          ),
        );
      } else {
        // Next month days
        int day = i - (emptyStart + daysInMonth) + 1;
        dayWidgets.add(
          Container(
            width: AppScale.w(36),
            height: AppScale.w(36),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                fontSize: AppScale.sp(14),
              ),
            ),
          ),
        );
      }
    }

    List<Widget> rows = [];
    for (int r = 0; r < totalRows; r++) {
      List<Widget> rowChildren = [];
      for (int c = 0; c < 7; c++) {
        int index = r * 7 + c;
        if (index < dayWidgets.length) {
          rowChildren.add(dayWidgets[index]);
        } else {
          rowChildren.add(SizedBox(width: AppScale.w(36)));
        }
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: rowChildren,
        ),
      );
      if (r < totalRows - 1) {
        rows.add(SizedBox(height: AppScale.h(8)));
      }
    }

    Widget grid = Column(mainAxisSize: MainAxisSize.min, children: rows);

    // Bottom buttons
    Widget buttons = Row(
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
            child: Text(
              'Cancel',
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: AppScale.w(12)),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, selectedDate);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: AppScale.h(12)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppScale.r(8)),
              ),
            ),
            child: Text(
              'OK',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.all(AppScale.w(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          header,
          SizedBox(height: AppScale.h(16)),
          weekdaysRow,
          SizedBox(height: AppScale.h(8)),
          grid,
          SizedBox(height: AppScale.h(16)),
          Divider(color: AppColors.border),
          SizedBox(height: AppScale.h(16)),
          buttons,
        ],
      ),
    );
  }
}
