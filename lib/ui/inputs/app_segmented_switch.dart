import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppSegmentedSwitch extends StatefulWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color? activeColor;
  final BorderRadiusGeometry? borderRadius;
  final MainAxisSize mainAxisSize;

  const AppSegmentedSwitch({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.activeColor,
    this.borderRadius,
    this.mainAxisSize = MainAxisSize.max,
  }) : assert(options.length > 1, 'Must provide at least 2 options');

  @override
  State<AppSegmentedSwitch> createState() => _AppSegmentedSwitchState();
}

class _AppSegmentedSwitchState extends State<AppSegmentedSwitch> {
  late List<GlobalKey> _keys;
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
  void didUpdateWidget(covariant AppSegmentedSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options.length != widget.options.length) {
      _keys = List.generate(widget.options.length, (_) => GlobalKey());
      _isInit = false;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateThumbPosition());
  }

  void _updateThumbPosition() {
    if (!mounted) return;
    if (widget.selectedIndex < 0 || widget.selectedIndex >= _keys.length) {
      return;
    }

    final key = _keys[widget.selectedIndex];
    final currentContext = key.currentContext;
    if (currentContext != null) {
      final RenderBox renderBox =
          currentContext.findRenderObject() as RenderBox;
      final RenderBox parentBox = context.findRenderObject() as RenderBox;

      final offset = renderBox.localToGlobal(Offset.zero, ancestor: parentBox);

      setState(() {
        _thumbLeft = offset.dx;
        _thumbWidth = renderBox.size.width;
        _isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.activeColor ?? AppColors.primary;
    final radius =
        widget.borderRadius ?? BorderRadius.circular(AppScale.r(100));

    return Container(
      height: AppScale.h(48),
      padding: EdgeInsets.all(AppScale.w(4)),
      decoration: BoxDecoration(color: color, borderRadius: radius),
      child: Stack(
        children: [
          // Sliding white thumb
          if (_isInit)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left:
                  _thumbLeft -
                  AppScale.w(4), // Kurangi padding container parent
              top: 0,
              bottom: 0,
              width: _thumbWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: radius,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),

          // Interactive Text Options
          Row(
            mainAxisSize: widget.mainAxisSize,
            children: List.generate(widget.options.length, (index) {
              final isSelected = widget.selectedIndex == index;

              Widget child = GestureDetector(
                key: _keys[index],
                onTap: () => widget.onChanged(index),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppScale.w(16)),
                  alignment: Alignment.center,
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: AppScale.sp(14),
                      fontWeight: FontWeight.bold,
                      color: isSelected ? color : Colors.white,
                    ),
                    child: Text(
                      widget.options[index],
                      textAlign: TextAlign.center,
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
    );
  }
}
