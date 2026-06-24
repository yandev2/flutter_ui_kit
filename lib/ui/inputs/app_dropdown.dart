import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/inputs/app_checkbox.dart';

class AppDropdown extends StatefulWidget {
  final String? title;
  final List<String> items;
  final bool isMultiSelect;
  final String? value;
  final List<String>? selectedValues;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<List<String>>? onMultiChanged;
  final String? hint;
  final IconData? prefixIcon;
  final bool isLoading;
  final bool showClearButton;
  
  final double? titleSize;
  final double? textSize;
  final double? hintSize;
  final Color? fillColor;

  const AppDropdown({
    super.key,
    this.title,
    required this.items,
    this.isMultiSelect = false,
    this.value,
    this.selectedValues,
    this.onChanged,
    this.onMultiChanged,
    this.hint,
    this.prefixIcon,
    this.isLoading = false,
    this.showClearButton = true,
    this.titleSize,
    this.textSize,
    this.hintSize,
    this.fillColor,
  }) : assert(
          !isMultiSelect || onMultiChanged != null,
          'onMultiChanged is required when isMultiSelect is true',
        ),
        assert(
          isMultiSelect || onChanged != null,
          'onChanged is required when isMultiSelect is false',
        );

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  final _triggerKey = GlobalKey();

  List<String> get _validSelectedValues {
    final source = widget.selectedValues ?? const <String>[];
    return source.where(widget.items.contains).toList();
  }

  String? get _validSingleValue {
    final value = widget.value;
    return value != null && widget.items.contains(value) ? value : null;
  }

  bool get _hasSelection {
    if (widget.isMultiSelect) return _validSelectedValues.isNotEmpty;
    return _validSingleValue != null;
  }

  RelativeRect _menuPosition(RenderBox box) {
    final offset = box.localToGlobal(Offset.zero);
    final size = box.size;
    return RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + size.height + AppScale.h(8),
      offset.dx + size.width,
      offset.dy + size.height + AppScale.h(8),
    );
  }

  BoxDecoration _triggerDecoration(ThemeData theme) {
    return BoxDecoration(
      color: widget.fillColor ?? theme.scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(AppScale.r(8)),
      border: Border.all(
        color: AppColors.border,
        width: AppScale.w(1.0),
      ),
    );
  }

  ShapeBorder _menuShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppScale.r(8)),
      side: BorderSide(color: AppColors.border, width: 1),
    );
  }

  void _removeSelectedItem(String item) {
    if (widget.isLoading) return;
    final next = List<String>.from(_validSelectedValues)..remove(item);
    widget.onMultiChanged!(next);
  }

  void _clearAllSelected() {
    if (widget.isLoading) return;
    widget.onMultiChanged!([]);
  }

  void _openSingleMenu() {
    if (widget.isLoading) return;

    final box = _triggerKey.currentContext!.findRenderObject()! as RenderBox;

    showMenu<String>(
      context: context,
      position: _menuPosition(box),
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 4,
      shape: _menuShape(),
      constraints: BoxConstraints(
        minWidth: box.size.width,
        maxWidth: box.size.width,
      ),
      items: widget.items.map((item) {
        final isSelected = item == _validSingleValue;
        return PopupMenuItem<String>(
          value: item,
          child: _MenuItemRow(
            label: item,
            isSelected: isSelected,
            showCheckbox: false,
            textSize: widget.textSize,
          ),
        );
      }).toList(),
    ).then((selected) {
      if (selected != null) widget.onChanged!(selected);
    });
  }

  void _openMultiMenu() {
    if (widget.isLoading) return;

    final box = _triggerKey.currentContext!.findRenderObject()! as RenderBox;
    final theme = Theme.of(context);

    showMenu<void>(
      context: context,
      position: _menuPosition(box),
      color: theme.scaffoldBackgroundColor,
      elevation: 4,
      shape: _menuShape(),
      constraints: BoxConstraints(
        minWidth: box.size.width,
        maxWidth: box.size.width,
      ),
      items: [
        PopupMenuItem<void>(
          enabled: false,
          padding: EdgeInsets.symmetric(
            horizontal: AppScale.w(8),
            vertical: AppScale.h(4),
          ),
          child: StatefulBuilder(
            builder: (context, setMenuState) {
              var current = List<String>.from(_validSelectedValues);

              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: AppScale.h(280)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.items.map((item) {
                      final isSelected = current.contains(item);
                      return InkWell(
                        onTap: () {
                          setMenuState(() {
                            if (isSelected) {
                              current.remove(item);
                            } else {
                              current.add(item);
                            }
                          });
                          widget.onMultiChanged!(List<String>.from(current));
                        },
                        borderRadius: BorderRadius.circular(AppScale.r(6)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppScale.w(8),
                            vertical: AppScale.h(6),
                          ),
                          child: _MenuItemRow(
                            label: item,
                            isSelected: isSelected,
                            showCheckbox: true,
                            textSize: widget.textSize,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openMenu() {
    if (widget.isMultiSelect) {
      _openMultiMenu();
    } else {
      _openSingleMenu();
    }
  }

  Widget _buildSingleTriggerContent(ThemeData theme) {
    return Text(
      _validSingleValue ?? widget.hint ?? '',
      style: TextStyle(
        color: _hasSelection
            ? theme.textTheme.bodyLarge?.color
            : AppColors.textSecondary,
        fontSize: (_hasSelection ? widget.textSize : widget.hintSize) ?? AppScale.sp(14),
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildMultiTriggerContent(ThemeData theme) {
    final selected = _validSelectedValues;

    if (selected.isEmpty) {
      return Text(
        widget.hint ?? '',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: widget.hintSize ?? AppScale.sp(14),
        ),
      );
    }

    return Wrap(
      spacing: AppScale.w(8),
      runSpacing: AppScale.h(8),
      children: selected.map((item) {
        return _SelectedChip(
          label: item,
          onRemove: widget.isLoading ? null : () => _removeSelectedItem(item),
        );
      }).toList(),
    );
  }

  Widget _buildTrailingIcons() {
    if (widget.isLoading) {
      return SizedBox(
        width: AppScale.w(16),
        height: AppScale.w(16),
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return Icon(
      Icons.keyboard_arrow_down,
      color: AppColors.textSecondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: TextStyle(
              fontSize: widget.titleSize ?? AppScale.sp(14),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: AppScale.h(8)),
        ],
        Container(
          key: _triggerKey,
          padding: EdgeInsets.symmetric(
            horizontal: AppScale.w(16),
            vertical: widget.isMultiSelect && _hasSelection
                ? AppScale.h(8)
                : AppScale.h(12),
          ),
          decoration: _triggerDecoration(theme),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.prefixIcon != null) ...[
                Icon(
                  widget.prefixIcon,
                  color: AppColors.textSecondary,
                  size: AppScale.w(20),
                ),
                SizedBox(width: AppScale.w(12)),
              ],
              Expanded(
                child: GestureDetector(
                  onTap: _openMenu,
                  behavior: HitTestBehavior.opaque,
                  child: widget.isMultiSelect
                      ? _buildMultiTriggerContent(theme)
                      : _buildSingleTriggerContent(theme),
                ),
              ),
              SizedBox(width: AppScale.w(8)),
              if (widget.isMultiSelect &&
                  widget.showClearButton &&
                  _hasSelection &&
                  !widget.isLoading)
                GestureDetector(
                  onTap: _clearAllSelected,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(AppScale.w(4)),
                    child: Icon(
                      Icons.close,
                      size: AppScale.w(18),
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              if (widget.isMultiSelect &&
                  widget.showClearButton &&
                  _hasSelection &&
                  !widget.isLoading)
                SizedBox(width: AppScale.w(4)),
              GestureDetector(
                onTap: _openMenu,
                behavior: HitTestBehavior.opaque,
                child: _buildTrailingIcons(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SelectedChip extends StatelessWidget {
  final String label;
  final VoidCallback? onRemove;

  const _SelectedChip({
    required this.label,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: AppScale.w(220)),
      padding: EdgeInsets.symmetric(
        horizontal: AppScale.w(10),
        vertical: AppScale.h(6),
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppScale.r(6)),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: AppScale.sp(12),
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onRemove != null) ...[
            SizedBox(width: AppScale.w(4)),
            GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Icons.close,
                size: AppScale.w(14),
                color: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MenuItemRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool showCheckbox;
  final double? textSize;

  const _MenuItemRow({
    required this.label,
    required this.isSelected,
    required this.showCheckbox,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: textSize ?? AppScale.sp(14),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? AppColors.primary
                  : theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
        if (showCheckbox)
          IgnorePointer(
            child: AppCheckbox(
              value: isSelected,
              onChanged: (_) {},
              size: AppScale.w(18),
            ),
          )
        else if (isSelected)
          Icon(
            Icons.check,
            size: AppScale.w(18),
            color: AppColors.primary,
          ),
      ],
    );
  }
}
