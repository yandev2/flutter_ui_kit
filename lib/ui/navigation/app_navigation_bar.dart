import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

enum AppNavigationBarVariant {
  textOnSelected,
  textAlways,
  topIndicator,
  circleBackground,
  pillBackground,
}

class AppNavigationBarItem {
  final HeroIcons icon;
  final HeroIcons? activeIcon;
  final String label;

  const AppNavigationBarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

class AppNavigationBar extends StatelessWidget {
  final List<AppNavigationBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final AppNavigationBarVariant variant;
  final int? prominentCenterIndex;
  final bool isCenterFloating;
  final Color? backgroundColor;

  const AppNavigationBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.variant = AppNavigationBarVariant.textOnSelected,
    this.prominentCenterIndex,
    this.isCenterFloating = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final navColor =
        backgroundColor ?? (isDark ? AppColors.surface : AppColors.white);

    // Ketinggian standar nav bar
    final double barHeight = AppScale.h(70);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Base Bar
        Container(
          height: barHeight,
          decoration: BoxDecoration(
            color: navColor,
            borderRadius: BorderRadius.circular(AppScale.r(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (index) {
              final isSelected = selectedIndex == index;
              final item = items[index];
              final isProminent = prominentCenterIndex == index;

              // Jika prominent dan floating, beri ruang kosong di base bar
              if (isProminent && isCenterFloating) {
                return SizedBox(width: AppScale.w(60));
              }

              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  behavior: HitTestBehavior.opaque,
                  child: _buildNavItem(item, isSelected, isProminent, theme),
                ),
              );
            }),
          ),
        ),

        // Floating Prominent Button
        if (prominentCenterIndex != null && isCenterFloating)
          Positioned(
            top: -AppScale.h(20),
            child: GestureDetector(
              onTap: () => onChanged(prominentCenterIndex!),
              child: Container(
                width: AppScale.w(60),
                height: AppScale.w(60),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: HeroIcon(
                    items[prominentCenterIndex!].activeIcon ??
                        items[prominentCenterIndex!].icon,
                    style: HeroIconStyle.solid,
                    color: Colors.white,
                    size: AppScale.w(28),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNavItem(
    AppNavigationBarItem item,
    bool isSelected,
    bool isProminent,
    ThemeData theme,
  ) {
    final isDark = theme.brightness == Brightness.dark;

    if (isProminent && !isCenterFloating) {
      // Inline Prominent Button (Ungu di dalam bar)
      return Center(
        child: Container(
          width: AppScale.w(48),
          height: AppScale.w(48),
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: HeroIcon(
              item.activeIcon ?? item.icon,
              style: HeroIconStyle.solid,
              color: Colors.white,
              size: AppScale.w(24),
            ),
          ),
        ),
      );
    }

    final activeColor = isDark ? Colors.white : AppColors.primary;
    final inactiveColor = isDark ? AppColors.neutral400 : AppColors.neutral500;

    final color = isSelected ? activeColor : inactiveColor;
    final iconStyle = isSelected ? HeroIconStyle.solid : HeroIconStyle.outline;
    final iconToUse = isSelected && item.activeIcon != null
        ? item.activeIcon!
        : item.icon;

    // Helper untuk animasi warna icon
    Widget animatedIcon() {
      return TweenAnimationBuilder<Color?>(
        duration: const Duration(milliseconds: 250),
        tween: ColorTween(begin: color, end: color),
        builder: (context, animatedColor, child) {
          return HeroIcon(
            iconToUse,
            color: animatedColor ?? color,
            size: variant == AppNavigationBarVariant.pillBackground && isSelected ? AppScale.w(20) : AppScale.w(24),
            style: iconStyle,
          );
        },
      );
    }

    // Helper untuk animasi teks
    Widget animatedText({bool isBold = false}) {
      return AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 250),
        style: TextStyle(
          color: color,
          fontSize: AppScale.sp(variant == AppNavigationBarVariant.pillBackground ? 14 : 12),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
        child: Text(item.label, maxLines: 1, overflow: TextOverflow.clip),
      );
    }

    Widget navContent;
    switch (variant) {
      case AppNavigationBarVariant.textOnSelected:
        navContent = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animatedIcon(),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: SizedBox(
                height: isSelected ? null : 0,
                child: isSelected ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: AppScale.h(4)),
                    animatedText(isBold: true),
                  ],
                ) : const SizedBox.shrink(),
              ),
            ),
          ],
        );
        break;

      case AppNavigationBarVariant.textAlways:
        navContent = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animatedIcon(),
            SizedBox(height: AppScale.h(4)),
            animatedText(isBold: isSelected),
          ],
        );
        break;

      case AppNavigationBarVariant.topIndicator:
        navContent = Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isSelected ? 1.0 : 0.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutBack,
                  width: isSelected ? AppScale.w(40) : AppScale.w(10),
                  height: AppScale.h(3),
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppScale.r(4)),
                      bottomRight: Radius.circular(AppScale.r(4)),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppScale.h(8)), // Space between indicator and icon
                animatedIcon(),
                SizedBox(height: AppScale.h(4)),
                animatedText(isBold: isSelected),
              ],
            ),
          ],
        );
        break;

      case AppNavigationBarVariant.circleBackground:
        navContent = Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: AppScale.w(48),
            height: AppScale.w(48),
            decoration: BoxDecoration(
              color: isSelected
                  ? activeColor.withValues(alpha: 0.1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: animatedIcon(),
            ),
          ),
        );
        break;

      case AppNavigationBarVariant.pillBackground:
        navContent = Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: isSelected ? AppScale.w(16) : AppScale.w(12),
              vertical: AppScale.h(8),
            ),
            decoration: BoxDecoration(
              color: isSelected ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(AppScale.r(100)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                animatedIcon(),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: SizedBox(
                    width: isSelected ? null : 0,
                    child: isSelected ? Padding(
                      padding: EdgeInsets.only(left: AppScale.w(6)),
                      child: animatedText(isBold: true),
                    ) : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppScale.w(4)),
        child: navContent,
      ),
    );
  }
}
