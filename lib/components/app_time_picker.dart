import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../theme/theme.dart';

// Using a custom class to store Time with seconds, since TimeOfDay only has hour/min
class AppTimeData {
  final int hour;
  final int minute;
  final int second;
  final bool isAm;

  AppTimeData({
    required this.hour,
    required this.minute,
    required this.second,
    required this.isAm,
  });

  String get formatted {
    final formattedHour = hour == 0 ? 12 : hour;
    return '${formattedHour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';
  }
}

/// Komponen pemilih waktu (Jam, Menit, Detik) interaktif.
///
/// Example:
/// ```dart
/// AppTimePicker(
///   title: 'Waktu Absen',
///   hint: 'Pilih Waktu',
///   value: _selectedTime,
///   onChanged: (val) => setState(() => _selectedTime = val),
/// )
/// ```
class AppTimePicker extends StatefulWidget {
  final String? title;
  final AppTimeData? value;
  final ValueChanged<AppTimeData?> onChanged;
  final String? hint;
  final HeroIcons? prefixIcon;
  final bool isLoading;

  final double? titleSize;
  final double? textSize;
  final double? hintSize;

  final Color? fillColor;

  const AppTimePicker({
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
  State<AppTimePicker> createState() => _AppTimePickerState();
}

class _AppTimePickerState extends State<AppTimePicker> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final displayValue = widget.value?.formatted;

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
        PopupMenuButton<AppTimeData>(
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
          constraints: BoxConstraints(minWidth: size(300), maxWidth: size(340)),
          itemBuilder: (context) => [
            PopupMenuItem<AppTimeData>(
              enabled: false,
              padding: EdgeInsets.zero,
              child: _TimePopup(initialTime: widget.value),
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
                    HeroIcons.clock,
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

class _TimePopup extends StatefulWidget {
  final AppTimeData? initialTime;

  const _TimePopup({this.initialTime});

  @override
  State<_TimePopup> createState() => _TimePopupState();
}

class _TimePopupState extends State<_TimePopup> {
  late int hour;
  late int minute;
  late int second;
  late bool isAm;

  @override
  void initState() {
    super.initState();
    if (widget.initialTime != null) {
      hour = widget.initialTime!.hour;
      minute = widget.initialTime!.minute;
      second = widget.initialTime!.second;
      isAm = widget.initialTime!.isAm;
    } else {
      final now = DateTime.now();
      int h = now.hour;
      isAm = h < 12;
      if (h == 0) h = 12;
      if (h > 12) h -= 12;
      hour = h;
      minute = now.minute;
      second = now.second;
    }
  }

  void _incHour() => setState(() => hour = hour < 12 ? hour + 1 : 1);
  void _decHour() => setState(() => hour = hour > 1 ? hour - 1 : 12);
  void _incMin() => setState(() => minute = minute < 59 ? minute + 1 : 0);
  void _decMin() => setState(() => minute = minute > 0 ? minute - 1 : 59);
  void _incSec() => setState(() => second = second < 59 ? second + 1 : 0);
  void _decSec() => setState(() => second = second > 0 ? second - 1 : 59);

  Widget _buildColumn(
    String value,
    String label,
    VoidCallback onUp,
    VoidCallback onDown,
  ) {
    final uiTheme = context.uiTheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        IconButton(
          icon: HeroIcon(
            HeroIcons.chevronUp,
            size: size(18),
            color: uiTheme.onSurface,
          ),
          onPressed: onUp,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size(8)),
              side: BorderSide(color: uiTheme.borderColor),
            ),
          ),
        ),
        SizedBox(height: sizeHeight(12)),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: size(24),
            fontWeight: FontWeight.bold,
            color: uiTheme.onSurface,
          ),
        ),
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: size(12),
            color: uiTheme.hintColor,
          ),
        ),
        SizedBox(height: sizeHeight(12)),
        IconButton(
          icon: HeroIcon(
            HeroIcons.chevronDown,
            size: size(18),
            color: uiTheme.onSurface,
          ),
          onPressed: onDown,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size(8)),
              side: BorderSide(color: uiTheme.borderColor),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final formattedPreview =
        '${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';

    return Container(
      padding: EdgeInsets.all(size(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Pilih Waktu',
            style: textTheme.bodyMedium?.copyWith(
              fontSize: size(18),
              fontWeight: FontWeight.bold,
              color: uiTheme.onSurface,
            ),
          ),
          SizedBox(height: sizeHeight(24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColumn(hour.toString(), 'jam', _incHour, _decHour),
              _buildColumn(
                minute.toString().padLeft(2, '0'),
                'mnt',
                _incMin,
                _decMin,
              ),
              _buildColumn(
                second.toString().padLeft(2, '0'),
                'dtk',
                _incSec,
                _decSec,
              ),
            ],
          ),
          SizedBox(height: sizeHeight(24)),
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? uiTheme.borderColor.withValues(alpha: 0.2)
                  : uiTheme.background.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(size(8)),
            ),
            padding: EdgeInsets.all(size(4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => setState(() => isAm = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size(16),
                      vertical: sizeHeight(8),
                    ),
                    decoration: BoxDecoration(
                      color: isAm ? uiTheme.surface : Colors.transparent,
                      borderRadius: BorderRadius.circular(size(6)),
                      boxShadow: isAm
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      'AM',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: isAm ? FontWeight.bold : FontWeight.normal,
                        color: uiTheme.onSurface,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => isAm = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size(16),
                      vertical: sizeHeight(8),
                    ),
                    decoration: BoxDecoration(
                      color: !isAm ? uiTheme.surface : Colors.transparent,
                      borderRadius: BorderRadius.circular(size(6)),
                      boxShadow: !isAm
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      'PM',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: !isAm ? FontWeight.bold : FontWeight.normal,
                        color: uiTheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sizeHeight(24)),
          Text(
            formattedPreview,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: size(14),
              fontWeight: FontWeight.w600,
              color: uiTheme.onSurface,
            ),
          ),
          SizedBox(height: sizeHeight(24)),
          Divider(color: uiTheme.borderColor),
          SizedBox(height: sizeHeight(16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    AppTimeData(
                      hour: hour,
                      minute: minute,
                      second: second,
                      isAm: isAm,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: uiTheme.primary,
                  padding: EdgeInsets.symmetric(vertical: sizeHeight(14)),
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
              SizedBox(height: sizeHeight(12)),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: sizeHeight(14)),
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
            ],
          ),
        ],
      ),
    );
  }
}
