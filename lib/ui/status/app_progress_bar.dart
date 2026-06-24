import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String? title;
  final String? subtitle;
  final HeroIcons? icon;
  final Color? color;
  final Color? backgroundColor;
  final double? width;
  final double height;
  final MainAxisSize mainAxisSize;
  final double iconSize;

  const AppProgressBar({
    super.key,
    required this.progress,
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.backgroundColor,
    this.width,
    this.height = 8.0,
    this.mainAxisSize = MainAxisSize.max,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? AppColors.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBgColor = isDark ? AppColors.neutral700 : AppColors.neutral200;
    
    // Validasi progress agar tetap dalam batas 0.0 - 1.0
    final safeProgress = progress.clamp(0.0, 1.0);

    Widget barArea = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null || subtitle != null) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: AppScale.sp(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              if (title != null && subtitle != null)
                SizedBox(width: AppScale.w(8)),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: AppScale.sp(12),
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          SizedBox(height: AppScale.h(8)),
        ],
        Container(
          height: height,
          width: width ?? (mainAxisSize == MainAxisSize.min ? AppScale.w(150) : double.infinity),
          decoration: BoxDecoration(
            color: backgroundColor ?? defaultBgColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: height,
                    width: constraints.maxWidth * safeProgress,
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(height / 2),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );

    return Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Container(
            padding: EdgeInsets.all(AppScale.w(10)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: activeColor,
                width: AppScale.w(2),
              ),
              color: activeColor.withValues(alpha: 0.1),
            ),
            child: HeroIcon(
              icon!,
              color: activeColor,
              size: iconSize,
              style: HeroIconStyle.solid,
            ),
          ),
          SizedBox(width: AppScale.w(16)),
        ],
        if (mainAxisSize == MainAxisSize.max && width == null)
          Expanded(child: barArea)
        else
          barArea,
      ],
    );
  }
}
