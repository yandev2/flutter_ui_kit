import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../theme/theme.dart';

/// Komponen pemilih tahun dengan UI _scroll wheel_ (ListWheelScrollView).
///
/// Example:
/// ```dart
/// AppYearPicker(
///   title: 'Tahun Kendaraan',
///   hint: 'Pilih tahun',
///   value: _selectedYear,
///   onChanged: (val) => setState(() => _selectedYear = val),
/// )
/// ```
class AppYearPicker extends StatefulWidget {
  final String? title;
  final int? value;
  final ValueChanged<int?> onChanged;
  final String? hint;
  final HeroIcons? prefixIcon;
  final bool isLoading;

  final double? titleSize;
  final double? textSize;
  final double? hintSize;

  final Color? fillColor;

  const AppYearPicker({
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
  State<AppYearPicker> createState() => _AppYearPickerState();
}

class _AppYearPickerState extends State<AppYearPicker> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final displayValue = widget.value?.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: widget.titleSize ?? size(14),
              fontWeight: FontWeight.bold,
              color: uiTheme.onBackground,
            ),
          ),
          SizedBox(height: sizeHeight(8)),
        ],
        PopupMenuButton<int>(
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
          constraints: BoxConstraints(minWidth: size(200), maxWidth: size(240)),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              enabled: false,
              padding: EdgeInsets.zero,
              child: _YearPopup(initialYear: widget.value),
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
                      color: displayValue != null
                          ? uiTheme.onBackground
                          : uiTheme.hintColor,
                      fontSize:
                          (displayValue != null
                              ? widget.textSize
                              : widget.hintSize) ??
                          size(14),
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
                    HeroIcons.calendarDays,
                    color: _isOpen ? uiTheme.primary : uiTheme.hintColor,
                    size: size(18),
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
    years = List.generate(
      endYear - startYear + 1,
      (index) => startYear + index,
    );
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
    final uiTheme = context.uiTheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size(16),
        vertical: sizeHeight(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Pilih Tahun',
            style: textTheme.bodyMedium?.copyWith(
              fontSize: size(18),
              fontWeight: FontWeight.bold,
              color: uiTheme.onSurface,
            ),
          ),
          SizedBox(height: sizeHeight(24)),
          SizedBox(
            height: sizeHeight(200),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Selection indicator
                Container(
                  height: sizeHeight(40),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: uiTheme.borderColor,
                        width: sizeHeight(1.5),
                      ),
                      bottom: BorderSide(
                        color: uiTheme.borderColor,
                        width: sizeHeight(1.5),
                      ),
                    ),
                  ),
                ),
                ListWheelScrollView.useDelegate(
                  controller: _controller,
                  itemExtent: sizeHeight(40),
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
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: isSelected ? size(20) : size(16),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? uiTheme.onSurface
                                : uiTheme.hintColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sizeHeight(24)),
          Row(
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
              SizedBox(width: size(8)),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, selectedYear),
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
          ),
        ],
      ),
    );
  }
}
