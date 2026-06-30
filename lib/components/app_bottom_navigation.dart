import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../ui_component_flutter.dart';
import '../theme/app_scale.dart' as scale;

class AppBottomNavItem {
  final String label;
  final HeroIcons icon;

  AppBottomNavItem({required this.label, required this.icon});
}

enum AppBottomNavigationVariant { indicator, pill, dot, shift }

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<AppBottomNavItem> items;

  // Customization Properties
  final AppBottomNavigationVariant variant;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color? shadowColor;
  final double? iconSize;
  final double? selectedFontSize;
  final double? unselectedFontSize;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? indicatorWidth;
  final double? indicatorHeight;
  final double? elevation;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.variant = AppBottomNavigationVariant.indicator,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.shadowColor,
    this.iconSize,
    this.selectedFontSize,
    this.unselectedFontSize,
    this.textStyle,
    this.padding,
    this.indicatorWidth,
    this.indicatorHeight,
    this.elevation,
  });

  Widget _buildIcon(
    AppBottomNavItem item,
    bool isSelected,
    double size,
    Color selectedColor,
    Color unselectedColor,
  ) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: HeroIcon(
        item.icon,
        key: ValueKey<bool>(isSelected),
        style: isSelected ? HeroIconStyle.solid : HeroIconStyle.outline,
        color: isSelected ? selectedColor : unselectedColor,
        size: size,
      ),
    );
  }

  Widget _buildLabel(
    BuildContext context,
    AppBottomNavItem item,
    bool isSelected,
    double selectedFontSize,
    double unselectedFontSize,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final theme = Theme.of(context);
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: (textStyle ?? theme.textTheme.labelMedium!).copyWith(
        color: isSelected ? selectedColor : unselectedColor,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        fontSize: isSelected ? selectedFontSize : unselectedFontSize,
      ),
      child: Text(item.label),
    );
  }

  Widget _buildItemContent(
    BuildContext context,
    AppBottomNavItem item,
    bool isSelected,
    double iconSize,
    double selectedFontSize,
    double unselectedFontSize,
    Color selectedColor,
    Color unselectedColor,
    double indWidth,
    double indHeight,
  ) {
    switch (variant) {
      case AppBottomNavigationVariant.pill:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: scale.size(16),
                vertical: scale.sizeHeight(4),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? selectedColor.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(scale.size(20)),
              ),
              child: _buildIcon(
                item,
                isSelected,
                iconSize,
                selectedColor,
                unselectedColor,
              ),
            ),
            SizedBox(height: scale.sizeHeight(4)),
            _buildLabel(
              context,
              item,
              isSelected,
              selectedFontSize,
              unselectedFontSize,
              selectedColor,
              unselectedColor,
            ),
          ],
        );

      case AppBottomNavigationVariant.dot:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(
              item,
              isSelected,
              iconSize,
              selectedColor,
              unselectedColor,
            ),
            SizedBox(height: scale.sizeHeight(4)),
            _buildLabel(
              context,
              item,
              isSelected,
              selectedFontSize,
              unselectedFontSize,
              selectedColor,
              unselectedColor,
            ),
            SizedBox(height: scale.sizeHeight(6)),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              height: scale.size(4),
              width: isSelected ? scale.size(4) : 0,
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        );

      case AppBottomNavigationVariant.shift:
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? scale.size(16) : scale.size(8),
            vertical: scale.sizeHeight(8),
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? selectedColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(scale.size(24)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(
                item,
                isSelected,
                iconSize,
                selectedColor,
                unselectedColor,
              ),
              if (isSelected) ...[
                SizedBox(width: scale.size(8)),
                _buildLabel(
                  context,
                  item,
                  isSelected,
                  selectedFontSize,
                  unselectedFontSize,
                  selectedColor,
                  unselectedColor,
                ),
              ],
            ],
          ),
        );

      case AppBottomNavigationVariant.indicator:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(
              item,
              isSelected,
              iconSize,
              selectedColor,
              unselectedColor,
            ),
            SizedBox(height: scale.sizeHeight(4)),
            _buildLabel(
              context,
              item,
              isSelected,
              selectedFontSize,
              unselectedFontSize,
              selectedColor,
              unselectedColor,
            ),
            SizedBox(height: scale.sizeHeight(6)),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              height: indHeight,
              width: isSelected ? indWidth : 0,
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : Colors.transparent,
                borderRadius: BorderRadius.circular(scale.size(2)),
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;

    final actualBackgroundColor = backgroundColor ?? theme.cardColor;
    final actualSelectedColor = selectedItemColor ?? theme.primaryColor;
    final actualUnselectedColor = unselectedItemColor ?? uiTheme.disabledColor;
    final actualShadowColor = shadowColor ?? uiTheme.shadowColor;
    final actualIconSize = iconSize ?? scale.size(24);
    final actualSelectedFontSize = selectedFontSize ?? scale.size(12);
    final actualUnselectedFontSize = unselectedFontSize ?? scale.size(12);
    final actualIndicatorWidth = indicatorWidth ?? scale.size(30);
    final actualIndicatorHeight = indicatorHeight ?? scale.sizeHeight(3);
    final actualElevation = elevation ?? scale.size(10);
    final actualPadding =
        padding ??
        EdgeInsets.symmetric(
          horizontal: scale.size(16),
          vertical: scale.sizeHeight(10),
        );

    return Container(
      padding: actualPadding,
      decoration: BoxDecoration(
        color: actualBackgroundColor,
        boxShadow: actualElevation > 0
            ? [
                BoxShadow(
                  color: actualShadowColor,
                  blurRadius: actualElevation,
                  offset: Offset(0, -scale.sizeHeight(2)),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: variant == AppBottomNavigationVariant.shift
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = currentIndex == index;

            Widget child = GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: _buildItemContent(
                context,
                item,
                isSelected,
                actualIconSize,
                actualSelectedFontSize,
                actualUnselectedFontSize,
                actualSelectedColor,
                actualUnselectedColor,
                actualIndicatorWidth,
                actualIndicatorHeight,
              ),
            );

            if (variant == AppBottomNavigationVariant.shift) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: scale.size(4)),
                child: child,
              );
            }

            return Expanded(child: child);
          }),
        ),
      ),
    );
  }
}
