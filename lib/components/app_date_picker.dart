import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../theme/theme.dart';

/// Komponen Date Picker dengan desain modern dan interaktif.
///
/// Komponen ini memunculkan popup kalender untuk memilih tanggal.
/// Sudah dilengkapi dengan dukungan judul, hint, dan status loading.
///
/// Example:
/// ```dart
/// AppDatePicker(
///   title: 'Tanggal Lahir',
///   hint: 'Pilih tanggal',
///   value: _selectedDate,
///   onChanged: (val) => setState(() => _selectedDate = val),
/// )
/// ```
class AppDatePicker extends StatefulWidget {
  final String? title;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String? hint;
  final HeroIcons? prefixIcon;
  final bool isLoading;

  final double? titleSize;
  final double? textSize;
  final double? hintSize;

  final Color? fillColor;
  final String Function(DateTime)? formatResult;

  static const List<String> monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  const AppDatePicker({
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
    this.formatResult,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final displayValue = widget.value != null
        ? (widget.formatResult != null
              ? widget.formatResult!(widget.value!)
              : '${widget.value!.day.toString().padLeft(2, '0')} ${AppDatePicker.monthNames[widget.value!.month - 1]} ${widget.value!.year}')
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: widget.titleSize ?? size(14),
              color: uiTheme.onBackground,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: sizeHeight(8)),
        ],
        PopupMenuButton<DateTime>(
          onOpened: () => setState(() => _isOpen = true),
          onCanceled: () => setState(() => _isOpen = false),
          onSelected: widget.isLoading
              ? null
              : (val) {
                  setState(() => _isOpen = false);
                  widget.onChanged(val);
                },
          position: PopupMenuPosition.under,
          offset: Offset(0, sizeHeight(8)),
          color: uiTheme.surface,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size(16)),
            side: BorderSide(color: uiTheme.borderColor, width: size(1)),
          ),
          constraints: BoxConstraints(minWidth: size(320), maxWidth: size(360)),
          itemBuilder: (context) => [
            PopupMenuItem<DateTime>(
              enabled: false,
              padding: EdgeInsets.zero,
              child: _CalendarPopup(initialDate: widget.value),
            ),
          ],
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size(16),
              vertical: sizeHeight(12),
            ),
            decoration: BoxDecoration(
              color: widget.fillColor ?? uiTheme.background,
              borderRadius: BorderRadius.circular(size(8)),
              border: Border.all(
                color: _isOpen ? uiTheme.primary : uiTheme.borderColor,
                width: size(1),
              ),
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  HeroIcon(
                    widget.prefixIcon!,
                    color: _isOpen ? uiTheme.primary : uiTheme.hintColor,
                    size: size(20),
                  ),
                  SizedBox(width: size(12)),
                ],
                Expanded(
                  child: Text(
                    displayValue ?? widget.hint ?? '',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: widget.textSize ?? size(14),
                      color: displayValue == null
                          ? uiTheme.hintColor
                          : uiTheme.onBackground,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.isLoading)
                  SizedBox(
                    width: size(16),
                    height: size(16),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: uiTheme.primary,
                    ),
                  )
                else
                  HeroIcon(
                    HeroIcons.calendar,
                    color: _isOpen ? uiTheme.primary : uiTheme.hintColor,
                    size: size(20),
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
    final uiTheme = context.uiTheme;
    final textTheme = Theme.of(context).textTheme;

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
          icon: HeroIcon(
            HeroIcons.chevronLeft,
            size: size(15),
            color: uiTheme.onSurface,
          ),
          onPressed: _prevMonth,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size(8)),
              side: BorderSide(color: uiTheme.borderColor),
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${AppDatePicker.monthNames[currentMonth.month - 1]} ${currentMonth.year}',
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(color: uiTheme.onSurface),
          ),
        ),
        IconButton(
          icon: HeroIcon(
            HeroIcons.chevronRight,
            size: size(15),
            color: uiTheme.onSurface,
          ),
          onPressed: _nextMonth,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size(8)),
              side: BorderSide(color: uiTheme.borderColor),
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
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: uiTheme.onSurface,
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
            width: size(36),
            height: size(36),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: textTheme.bodyMedium?.copyWith(
                color: uiTheme.hintColor.withValues(alpha: 0.5),
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size(36),
              height: size(36),
              decoration: BoxDecoration(
                color: isSelected ? uiTheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(size(8)),
              ),
              alignment: Alignment.center,
              child: Text(
                day.toString(),
                style: textTheme.bodyMedium?.copyWith(
                  color: isSelected ? uiTheme.onPrimary : uiTheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
            width: size(36),
            height: size(36),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: textTheme.bodyMedium?.copyWith(
                color: uiTheme.hintColor.withValues(alpha: 0.5),
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
          rowChildren.add(SizedBox(width: size(36)));
        }
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: rowChildren,
        ),
      );
      if (r < totalRows - 1) {
        rows.add(SizedBox(height: sizeHeight(8)));
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
              padding: EdgeInsets.symmetric(vertical: sizeHeight(12)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size(8)),
              ),
              side: BorderSide(color: uiTheme.borderColor),
            ),
            child: Text(
              'Batal',
              style: textTheme.bodyMedium?.copyWith(
                color: uiTheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: size(12)),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, selectedDate);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: uiTheme.primary,
              padding: EdgeInsets.symmetric(vertical: sizeHeight(12)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size(8)),
              ),
            ),
            child: Text(
              'Pilih',
              style: textTheme.bodyMedium?.copyWith(
                color: uiTheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.all(size(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          header,
          SizedBox(height: sizeHeight(16)),
          weekdaysRow,
          SizedBox(height: sizeHeight(8)),
          grid,
          SizedBox(height: sizeHeight(16)),
          Divider(color: uiTheme.borderColor, height: 1),
          SizedBox(height: sizeHeight(16)),
          buttons,
        ],
      ),
    );
  }
}
