import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../theme/theme.dart';

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

bool _isDateInRange(DateTime date, DateTime? minDate, DateTime? maxDate) {
  final d = _dateOnly(date);
  if (minDate != null && d.isBefore(_dateOnly(minDate))) return false;
  if (maxDate != null && d.isAfter(_dateOnly(maxDate))) return false;
  return true;
}

bool _hasSelectableDayInMonth(
  DateTime month,
  DateTime? minDate,
  DateTime? maxDate,
) {
  final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
  for (var day = 1; day <= daysInMonth; day++) {
    if (_isDateInRange(DateTime(month.year, month.month, day), minDate, maxDate)) {
      return true;
    }
  }
  return false;
}

/// Komponen Date Picker dengan desain modern dan interaktif.
class AppDatePicker extends StatefulWidget {
  final String? title;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String? hint;
  final HeroIcons? prefixIcon;
  final bool isLoading;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool readOnly;
  final bool hideSuffixIcon;

  final double? titleSize;
  final double? textSize;
  final double? hintSize;

  final Color? fillColor;
  final String Function(DateTime)? formatResult;

  /// Warna teks tombol "Pilih" ketika tanggal sudah dipilih.
  /// Default: [Colors.white].
  final Color? confirmTextColor;

  /// Alias untuk [confirmTextColor].
  final Color? selectedConfirmTextColor;

  /// Warna teks tombol "Pilih" ketika tanggal belum dipilih.
  /// Default: [uiTheme.onSurface] (menyesuaikan mode tema: hitam pada light mode, putih pada dark mode).
  final Color? unselectedConfirmTextColor;

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
    this.minDate,
    this.maxDate,
    this.readOnly = false,
    this.hideSuffixIcon = false,
    this.titleSize,
    this.textSize,
    this.hintSize,
    this.fillColor,
    this.formatResult,
    this.confirmTextColor,
    this.selectedConfirmTextColor,
    this.unselectedConfirmTextColor,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  bool _isOpen = false;

  bool get _isInteractive => !widget.readOnly && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final displayValue = widget.value != null
        ? (widget.formatResult != null
              ? widget.formatResult!(widget.value!)
              : '${widget.value!.day.toString().padLeft(2, '0')} ${AppDatePicker.monthNames[widget.value!.month - 1]} ${widget.value!.year}')
        : null;

    final borderColor = widget.readOnly
        ? uiTheme.borderColor.withValues(alpha: 0.6)
        : (_isOpen ? uiTheme.primary : uiTheme.borderColor);
    final contentOpacity = widget.readOnly ? 0.5 : 1.0;

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
          enabled: _isInteractive,
          onOpened: _isInteractive ? () => setState(() => _isOpen = true) : null,
          onCanceled: () => setState(() => _isOpen = false),
          onSelected: _isInteractive
              ? (val) {
                  setState(() => _isOpen = false);
                  widget.onChanged(val);
                }
              : null,
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
              child: _CalendarPopup(
                initialDate: widget.value,
                minDate: widget.minDate,
                maxDate: widget.maxDate,
                confirmTextColor:
                    widget.selectedConfirmTextColor ?? widget.confirmTextColor,
                unselectedConfirmTextColor: widget.unselectedConfirmTextColor,
              ),
            ),
          ],
          child: Opacity(
            opacity: contentOpacity,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: appFieldMinHeight()),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: appFieldHorizontalPadding(),
                  vertical: appFieldVerticalPadding(),
                ),
                decoration: BoxDecoration(
                  color: widget.fillColor ?? uiTheme.background,
                  borderRadius: BorderRadius.circular(size(8)),
                  border: Border.all(color: borderColor, width: size(1)),
                ),
                child: Row(
                  children: [
                    if (widget.prefixIcon != null) ...[
                      HeroIcon(
                        widget.prefixIcon!,
                        color: _isOpen && _isInteractive
                            ? uiTheme.primary
                            : uiTheme.hintColor,
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
                    else if (!widget.hideSuffixIcon)
                      HeroIcon(
                        HeroIcons.calendar,
                        color: _isOpen && _isInteractive
                            ? uiTheme.primary
                            : uiTheme.hintColor,
                        size: size(20),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CalendarPopup extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Color? confirmTextColor;
  final Color? unselectedConfirmTextColor;

  const _CalendarPopup({
    this.initialDate,
    this.minDate,
    this.maxDate,
    this.confirmTextColor,
    this.unselectedConfirmTextColor,
  });

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

  bool get _canGoPrevMonth => _hasSelectableDayInMonth(
    DateTime(currentMonth.year, currentMonth.month - 1),
    widget.minDate,
    widget.maxDate,
  );

  bool get _canGoNextMonth => _hasSelectableDayInMonth(
    DateTime(currentMonth.year, currentMonth.month + 1),
    widget.minDate,
    widget.maxDate,
  );

  bool get _canConfirm =>
      selectedDate != null &&
      _isDateInRange(selectedDate!, widget.minDate, widget.maxDate);

  void _prevMonth() {
    if (!_canGoPrevMonth) return;
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    if (!_canGoNextMonth) return;
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final textTheme = Theme.of(context).textTheme;

    final daysInMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    ).day;
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final emptyStart = firstWeekday == 7 ? 0 : firstWeekday;

    final daysInPrevMonth = DateTime(
      currentMonth.year,
      currentMonth.month,
      0,
    ).day;

    final dayWidgets = <Widget>[];

    final header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
            size: size(15),
            color: _canGoPrevMonth
                ? uiTheme.onSurface
                : uiTheme.hintColor.withValues(alpha: 0.4),
          ),
          onPressed: _canGoPrevMonth ? _prevMonth : null,
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
            color: _canGoNextMonth
                ? uiTheme.onSurface
                : uiTheme.hintColor.withValues(alpha: 0.4),
          ),
          onPressed: _canGoNextMonth ? _nextMonth : null,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size(8)),
              side: BorderSide(color: uiTheme.borderColor),
            ),
          ),
        ),
      ],
    );

    final weekdaysRow = Row(
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

    final totalCells = emptyStart + daysInMonth;
    final totalRows = (totalCells / 7).ceil();
    final cellCount = totalRows * 7;

    for (var i = 0; i < cellCount; i++) {
      if (i < emptyStart) {
        final day = daysInPrevMonth - emptyStart + i + 1;
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
        final day = i - emptyStart + 1;
        final date = DateTime(currentMonth.year, currentMonth.month, day);
        final isSelectable = _isDateInRange(
          date,
          widget.minDate,
          widget.maxDate,
        );
        final isSelected =
            selectedDate != null &&
            selectedDate!.year == currentMonth.year &&
            selectedDate!.month == currentMonth.month &&
            selectedDate!.day == day;

        dayWidgets.add(
          GestureDetector(
            onTap: isSelectable
                ? () {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                : null,
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
                  color: !isSelectable
                      ? uiTheme.hintColor.withValues(alpha: 0.4)
                      : isSelected
                      ? uiTheme.onPrimary
                      : uiTheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      } else {
        final day = i - (emptyStart + daysInMonth) + 1;
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

    final rows = <Widget>[];
    for (var r = 0; r < totalRows; r++) {
      final rowChildren = <Widget>[];
      for (var c = 0; c < 7; c++) {
        final index = r * 7 + c;
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

    final grid = Column(mainAxisSize: MainAxisSize.min, children: rows);

    final buttons = Row(
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
            onPressed: _canConfirm
                ? () => Navigator.pop(context, selectedDate)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: uiTheme.primary,
              foregroundColor: widget.confirmTextColor ?? Colors.white,
              disabledBackgroundColor: uiTheme.borderColor,
              disabledForegroundColor:
                  widget.unselectedConfirmTextColor ?? uiTheme.onSurface,
              padding: EdgeInsets.symmetric(vertical: sizeHeight(12)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size(8)),
              ),
            ),
            child: Text(
              'Pilih',
              style: textTheme.bodyMedium?.copyWith(
                color: _canConfirm
                    ? (widget.confirmTextColor ?? Colors.white)
                    : (widget.unselectedConfirmTextColor ?? uiTheme.onSurface),
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
