import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

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

class AppTimePicker extends StatelessWidget {
  final String? title;
  final AppTimeData? value;
  final ValueChanged<AppTimeData?> onChanged;
  final String? hint;
  final IconData? prefixIcon;
  final bool isLoading;

  const AppTimePicker({
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
    final displayValue = value?.formatted;

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
        PopupMenuButton<AppTimeData>(
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
            minWidth: AppScale.w(300),
            maxWidth: AppScale.w(340),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<AppTimeData>(
              enabled: false,
              padding: EdgeInsets.zero,
              child: _TimePopup(initialTime: value),
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
                    Icons.access_time,
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

  Widget _buildColumn(String value, String label, VoidCallback onUp, VoidCallback onDown) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_up),
          onPressed: onUp,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              side: BorderSide(color: AppColors.border),
            ),
          ),
        ),
        SizedBox(height: AppScale.h(12)),
        Text(
          value,
          style: TextStyle(
            fontSize: AppScale.sp(24),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: AppScale.sp(12),
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: AppScale.h(12)),
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: onDown,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              side: BorderSide(color: AppColors.border),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final formattedPreview = '${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';

    return Container(
      padding: EdgeInsets.all(AppScale.w(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Time',
            style: TextStyle(
              fontSize: AppScale.sp(18),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: AppScale.h(24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColumn(hour.toString(), 'hour', _incHour, _decHour),
              _buildColumn(minute.toString().padLeft(2, '0'), 'min', _incMin, _decMin),
              _buildColumn(second.toString().padLeft(2, '0'), 'sec', _incSec, _decSec),
            ],
          ),
          SizedBox(height: AppScale.h(24)),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.neutral800 : AppColors.neutral100,
              borderRadius: BorderRadius.circular(AppScale.r(8)),
            ),
            padding: EdgeInsets.all(AppScale.w(4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => setState(() => isAm = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppScale.w(16), vertical: AppScale.h(8)),
                    decoration: BoxDecoration(
                      color: isAm ? theme.scaffoldBackgroundColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppScale.r(6)),
                      boxShadow: isAm ? [BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: 4)] : [],
                    ),
                    child: Text('AM', style: TextStyle(fontWeight: isAm ? FontWeight.bold : FontWeight.normal)),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => isAm = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppScale.w(16), vertical: AppScale.h(8)),
                    decoration: BoxDecoration(
                      color: !isAm ? theme.scaffoldBackgroundColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppScale.r(6)),
                      boxShadow: !isAm ? [BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: 4)] : [],
                    ),
                    child: Text('PM', style: TextStyle(fontWeight: !isAm ? FontWeight.bold : FontWeight.normal)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppScale.h(24)),
          Text(
            formattedPreview,
            style: TextStyle(
              fontSize: AppScale.sp(14),
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: AppScale.h(24)),
          Divider(color: AppColors.border),
          SizedBox(height: AppScale.h(16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, AppTimeData(hour: hour, minute: minute, second: second, isAm: isAm));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: AppScale.h(14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppScale.r(8)),
                  ),
                ),
                child: Text('OK', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: AppScale.h(12)),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: AppScale.h(14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppScale.r(8)),
                  ),
                  side: BorderSide(color: AppColors.border),
                ),
                child: Text('Cancel', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
