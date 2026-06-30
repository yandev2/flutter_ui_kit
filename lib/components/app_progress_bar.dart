import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../ui_component_flutter.dart';

class AppProgressBar extends StatelessWidget {
  final double progress;
  final String? title;
  final String? subtitle;
  final HeroIcons? icon;
  final Color? color;
  final Color? backgroundColor;
  final double? width;
  final double height;
  final MainAxisSize mainAxisSize;
  final double iconSize;
  final bool isLoading;

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
    this.iconSize = 20.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final activeColor = color ?? uiTheme.primary;
    final defaultBgColor = uiTheme.borderColor;
    final safeProgress = progress.clamp(0.0, 1.0);
    final scaledHeight = sizeHeight(height);

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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: uiTheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              if (title != null && subtitle != null) SizedBox(width: size(8)),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: uiTheme.hintColor,
                      ),
                ),
            ],
          ),
          SizedBox(height: size(8)),
        ],
        Skeleton.leaf(
          child: Container(
            height: scaledHeight,
            width: width ??
                (mainAxisSize == MainAxisSize.min
                    ? size(150)
                    : double.infinity),
            decoration: BoxDecoration(
              color: backgroundColor ?? defaultBgColor,
              borderRadius: BorderRadius.circular(scaledHeight / 2),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: scaledHeight,
                      width: constraints.maxWidth * safeProgress,
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(scaledHeight / 2),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );

    return Skeletonizer(
      enabled: isLoading,
      child: Row(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Skeleton.leaf(
              child: Container(
                padding: EdgeInsets.all(size(10)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: activeColor, width: size(2)),
                  color: activeColor.withValues(alpha: 0.1),
                ),
                child: HeroIcon(
                  icon!,
                  color: activeColor,
                  size: size(iconSize),
                  style: HeroIconStyle.solid,
                ),
              ),
            ),
            SizedBox(width: size(16)),
          ],
          if (mainAxisSize == MainAxisSize.max && width == null)
            Expanded(child: barArea)
          else
            barArea,
        ],
      ),
    );
  }
}
