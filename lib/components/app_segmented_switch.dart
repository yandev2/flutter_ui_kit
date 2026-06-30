import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../ui_component_flutter.dart';
import '../theme/app_scale.dart' as scale;

class AppSegmentedSwitch<T> extends StatefulWidget {
  final Map<T, String> options;
  final Map<T, HeroIcons>? icons;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeTextColor;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final MainAxisSize mainAxisSize;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const AppSegmentedSwitch({
    super.key,
    required this.options,
    this.icons,
    required this.selectedValue,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.activeTextColor,
    this.backgroundColor,
    this.borderRadius,
    this.mainAxisSize = MainAxisSize.max,
    this.textSize,
    this.padding,
    this.isLoading = false,
  }) : assert(options.length > 1, 'Must provide at least 2 options');

  @override
  State<AppSegmentedSwitch<T>> createState() => _AppSegmentedSwitchState<T>();
}

class _AppSegmentedSwitchState<T> extends State<AppSegmentedSwitch<T>> {
  late List<GlobalKey> _keys;
  final GlobalKey _stackKey = GlobalKey();
  double _thumbLeft = 0;
  double _thumbWidth = 0;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _keys = List.generate(widget.options.length, (_) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateThumbPosition());
  }

  @override
  void didUpdateWidget(covariant AppSegmentedSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options.length != widget.options.length) {
      _keys = List.generate(widget.options.length, (_) => GlobalKey());
      _isInit = false;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateThumbPosition());
  }

  void _updateThumbPosition() {
    if (!mounted) return;

    final keysList = widget.options.keys.toList();
    final index = keysList.indexOf(widget.selectedValue);
    if (index < 0 || index >= _keys.length) return;

    final key = _keys[index];
    final currentContext = key.currentContext;
    final stackContext = _stackKey.currentContext;

    if (currentContext != null && stackContext != null) {
      final RenderBox renderBox =
          currentContext.findRenderObject() as RenderBox;
      final RenderBox stackBox = stackContext.findRenderObject() as RenderBox;

      final offset = renderBox.localToGlobal(Offset.zero, ancestor: stackBox);

      setState(() {
        _thumbLeft = offset.dx;
        _thumbWidth = renderBox.size.width;
        _isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
        widget.backgroundColor ??
        (isDark ? uiTheme.surface : uiTheme.borderColor);
    final activeCol = widget.activeColor ?? theme.primaryColor;
    final activeTextCol = widget.activeTextColor ?? Colors.white;
    final inactiveCol = widget.inactiveColor ?? uiTheme.hintColor;
    final radius = widget.borderRadius ?? BorderRadius.circular(scale.size(12));

    final keysList = widget.options.keys.toList();
    final valuesList = widget.options.values.toList();

    return Skeletonizer(
      enabled: widget.isLoading,
      child: Container(
        height: scale.sizeHeight(48),
        padding: widget.padding ?? EdgeInsets.all(scale.size(4)),
        decoration: BoxDecoration(color: bgColor, borderRadius: radius),
        child: Stack(
          key: _stackKey,
          children: [
            // Sliding thumb
            if (_isInit)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: _thumbLeft,
                top: 0,
                bottom: 0,
                width: _thumbWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: activeCol,
                    borderRadius: radius,
                    boxShadow: [
                      BoxShadow(
                        color: uiTheme.shadowColor.withValues(alpha: 0.1),
                        blurRadius: scale.size(4),
                        offset: Offset(0, scale.sizeHeight(2)),
                      ),
                    ],
                  ),
                ),
              ),

            // Interactive Text Options
            Row(
              mainAxisSize: widget.mainAxisSize,
              children: List.generate(keysList.length, (index) {
                final isSelected = widget.selectedValue == keysList[index];

                final icon = widget.icons?[keysList[index]];

                Widget child = GestureDetector(
                  key: _keys[index],
                  onTap: () => widget.onChanged(keysList[index]),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: scale.size(16)),
                    alignment: Alignment.center,
                    child: Skeleton.replace(
                      replace: widget.isLoading,
                      replacement: Bone(
                        width: scale.size(60),
                        height: scale.size(20),
                        borderRadius: BorderRadius.circular(scale.size(4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...[
                            AnimatedTheme(
                              data: Theme.of(context).copyWith(
                                iconTheme: IconThemeData(
                                  color: isSelected ? activeTextCol : inactiveCol,
                                ),
                              ),
                              child: HeroIcon(
                                icon,
                                size: (widget.textSize ?? scale.size(14)) + scale.size(2),
                                style: HeroIconStyle.solid,
                              ),
                            ),
                            SizedBox(width: scale.size(6)),
                          ],
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            style: theme.textTheme.titleSmall!.copyWith(
                              fontSize: widget.textSize ?? scale.size(14),
                              fontWeight: FontWeight.w600,
                              color: isSelected ? activeTextCol : inactiveCol,
                            ),
                            child: Text(
                              valuesList[index],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                if (widget.mainAxisSize == MainAxisSize.max) {
                  return Expanded(child: child);
                }
                return child;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
