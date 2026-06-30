import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../theme/theme.dart';

class AppDropdown extends StatefulWidget {
  final String? title;
  final List<String> items;
  final bool isMultiSelect;
  final String? value;
  final List<String>? selectedValues;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<List<String>>? onMultiChanged;
  final String? hint;
  final HeroIcons? prefixIcon;
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
  bool _isOpen = false;

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
    final boxSize = box.size;
    return RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + boxSize.height + sizeHeight(8),
      offset.dx + boxSize.width,
      offset.dy + boxSize.height + sizeHeight(8),
    );
  }

  BoxDecoration _triggerDecoration() {
    final uiTheme = context.uiTheme;
    return BoxDecoration(
      color: widget.fillColor ?? uiTheme.background,
      borderRadius: BorderRadius.circular(size(8)),
      border: Border.all(
        color: _isOpen ? uiTheme.primary : uiTheme.borderColor,
        width: size(1),
      ),
    );
  }

  ShapeBorder _menuShape() {
    final uiTheme = context.uiTheme;
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(size(8)),
      side: BorderSide(color: uiTheme.borderColor, width: size(1)),
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
    final uiTheme = context.uiTheme;

    setState(() => _isOpen = true);

    showMenu<String>(
      context: context,
      position: _menuPosition(box),
      color: uiTheme.surface,
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
      if (mounted) setState(() => _isOpen = false);
      if (selected != null) widget.onChanged?.call(selected);
    });
  }

  void _openMultiMenu() {
    if (widget.isLoading) return;

    final box = _triggerKey.currentContext!.findRenderObject()! as RenderBox;
    final uiTheme = context.uiTheme;

    setState(() => _isOpen = true);

    showMenu<void>(
      context: context,
      position: _menuPosition(box),
      color: uiTheme.surface,
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
            horizontal: size(8),
            vertical: sizeHeight(4),
          ),
          child: StatefulBuilder(
            builder: (context, setMenuState) {
              var current = List<String>.from(_validSelectedValues);

              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: sizeHeight(280)),
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
                        borderRadius: BorderRadius.circular(size(6)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size(12),
                            vertical: sizeHeight(10),
                          ),
                          child: _MenuItemRow(
                            label: item,
                            isSelected: isSelected,
                            showCheckbox: true,
                            textSize: widget.textSize ?? size(16),
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
    ).then((_) {
      if (mounted) setState(() => _isOpen = false);
    });
  }

  void _openMenu() {
    if (widget.isMultiSelect) {
      _openMultiMenu();
    } else {
      _openSingleMenu();
    }
  }

  Widget _buildSingleTriggerContent() {
    final uiTheme = context.uiTheme;
    return Text(
      _validSingleValue ?? widget.hint ?? '',
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: _hasSelection ? uiTheme.onBackground : uiTheme.hintColor,
        fontSize:
            (_hasSelection ? widget.textSize : widget.hintSize) ?? size(14),
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildMultiTriggerContent() {
    final uiTheme = context.uiTheme;
    final selected = _validSelectedValues;

    if (selected.isEmpty) {
      return Text(
        widget.hint ?? '',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: uiTheme.hintColor,
          fontSize: widget.hintSize ?? size(14),
        ),
      );
    }

    return Wrap(
      spacing: size(8),
      runSpacing: sizeHeight(8),
      children: selected.map((item) {
        return _SelectedChip(
          label: item,
          onRemove: widget.isLoading ? null : () => _removeSelectedItem(item),
        );
      }).toList(),
    );
  }

  Widget _buildTrailingIcons() {
    final uiTheme = context.uiTheme;
    if (widget.isLoading) {
      return SizedBox(
        width: size(16),
        height: size(16),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: uiTheme.primary,
        ),
      );
    }

    return HeroIcon(
      HeroIcons.chevronDown,
      color: _isOpen ? uiTheme.primary : uiTheme.hintColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;

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
        Container(
          key: _triggerKey,
          padding: EdgeInsets.symmetric(
            horizontal: size(16),
            vertical: widget.isMultiSelect && _hasSelection
                ? sizeHeight(8)
                : sizeHeight(12),
          ),
          decoration: _triggerDecoration(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                child: GestureDetector(
                  onTap: _openMenu,
                  behavior: HitTestBehavior.opaque,
                  child: widget.isMultiSelect
                      ? _buildMultiTriggerContent()
                      : _buildSingleTriggerContent(),
                ),
              ),
              SizedBox(width: size(8)),
              if (widget.isMultiSelect &&
                  widget.showClearButton &&
                  _hasSelection &&
                  !widget.isLoading)
                GestureDetector(
                  onTap: _clearAllSelected,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(size(4)),
                    child: HeroIcon(
                      HeroIcons.xMark,
                      size: size(18),
                      color: uiTheme.hintColor,
                    ),
                  ),
                ),
              if (widget.isMultiSelect &&
                  widget.showClearButton &&
                  _hasSelection &&
                  !widget.isLoading)
                SizedBox(width: size(4)),
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

  const _SelectedChip({required this.label, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    return Container(
      constraints: BoxConstraints(maxWidth: size(220)),
      padding: EdgeInsets.symmetric(
        horizontal: size(12),
        vertical: sizeHeight(8),
      ),
      decoration: BoxDecoration(
        color: uiTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(size(6)),
        border: Border.all(color: uiTheme.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: size(14),
                fontWeight: FontWeight.w600,
                color: uiTheme.primary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onRemove != null) ...[
            SizedBox(width: size(4)),
            GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: HeroIcon(
                HeroIcons.xMark,
                size: size(16),
                color: uiTheme.primary,
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
    final uiTheme = context.uiTheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: textSize ?? size(14),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? uiTheme.primary : uiTheme.onSurface,
            ),
          ),
        ),
        if (showCheckbox)
          IgnorePointer(
            child: Container(
              width: size(18),
              height: size(18),
              decoration: BoxDecoration(
                color: isSelected ? uiTheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(size(4)),
                border: Border.all(
                  color: isSelected ? uiTheme.primary : uiTheme.hintColor,
                  width: size(1.5),
                ),
              ),
              child: isSelected
                  ? HeroIcon(
                      HeroIcons.check,
                      size: size(14),
                      color: uiTheme.onPrimary,
                    )
                  : null,
            ),
          )
        else if (isSelected)
          HeroIcon(HeroIcons.check, size: size(18), color: uiTheme.primary),
      ],
    );
  }
}
