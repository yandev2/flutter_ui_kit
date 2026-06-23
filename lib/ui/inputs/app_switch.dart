import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? textOn;
  final String? textOff;
  final Color? activeColor;
  final Color? inactiveColor;

  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.textOn = 'ON',
    this.textOff = 'OFF',
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorActive = activeColor ?? AppColors.primary;
    final colorInactive =
        inactiveColor ?? AppColors.border; // Responsive soft gray

    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: AppScale.w(72),
        height: AppScale.h(36),
        padding: EdgeInsets.all(AppScale.w(4)),
        decoration: BoxDecoration(
          color: value ? colorActive : colorInactive,
          borderRadius: BorderRadius.circular(AppScale.r(100)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Text
            Row(
              mainAxisAlignment: value
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppScale.w(6)),
                  child: Text(
                    value ? (textOn ?? '') : (textOff ?? ''),
                    style: TextStyle(
                      color: value
                          ? Colors.white
                          : (theme.brightness == Brightness.dark
                                ? Colors.white
                                : AppColors.textSecondary),
                      fontSize: AppScale.sp(12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Sliding Thumb
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: AppScale.h(28),
                height: AppScale.h(28),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
