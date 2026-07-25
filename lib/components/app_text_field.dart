import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter/services.dart';
import '../theme/theme.dart';

class AppTextField extends StatefulWidget {
  final String? title;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final HeroIcons? prefixIcon;
  final Widget? suffixWidget;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onEditingComplete;
  final bool readOnly;
  final bool enabled;

  final double? titleSize;
  final double? textSize;
  final double? hintSize;
  final double? helperSize;
  final double? errorSize;

  final Color? fillColor;

  const AppTextField({
    super.key,
    this.title,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixWidget,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.autofillHints,
    this.textInputAction,
    this.onSubmitted,
    this.onEditingComplete,
    this.readOnly = false,
    this.enabled = true,
    this.titleSize,
    this.textSize,
    this.hintSize,
    this.helperSize,
    this.errorSize,
    this.fillColor,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String _currentText = '';

  @override
  void initState() {
    super.initState();
    _currentText = widget.controller?.text ?? '';
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String get _fieldValue => widget.controller?.text ?? _currentText;

  void _handleEditingComplete() {
    widget.onEditingComplete?.call(_fieldValue);
  }

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    Color borderColor;
    if (hasError) {
      borderColor = uiTheme.error;
    } else if (_isFocused) {
      borderColor = uiTheme.primary;
    } else {
      borderColor = uiTheme.borderColor;
    }

    final fieldFill = widget.fillColor ?? uiTheme.background;
    final verticalPadding = sizeHeight(12);
    final hasPrefix = widget.prefixIcon != null;
    final hasSuffix = widget.suffixWidget != null;

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
          decoration: BoxDecoration(
            color: fieldFill,
            borderRadius: BorderRadius.circular(size(8)),
            border: Border.all(color: borderColor, width: size(1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (hasPrefix)
                Padding(
                  padding: EdgeInsets.only(
                    left: size(16),
                    top: verticalPadding,
                    bottom: verticalPadding,
                    right: size(12),
                  ),
                  child: HeroIcon(
                    widget.prefixIcon!,
                    color: hasError
                        ? uiTheme.error
                        : _isFocused
                        ? uiTheme.primary
                        : uiTheme.hintColor,
                    size: size(20),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: hasPrefix ? 0 : size(16),
                    right: hasSuffix ? 0 : size(16),
                    top: verticalPadding,
                    bottom: verticalPadding,
                  ),
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    obscureText: widget.obscureText,
                    readOnly: widget.readOnly,
                    enabled: widget.enabled,
                    autocorrect: !widget.obscureText,
                    enableSuggestions: !widget.obscureText,
                    autofillHints: widget.autofillHints,
                    textInputAction: widget.textInputAction,
                    onSubmitted: widget.onSubmitted,
                    onEditingComplete: _handleEditingComplete,
                    onTapOutside: (_) => _focusNode.unfocus(),
                    onChanged: (value) {
                      _currentText = value;
                      widget.onChanged?.call(value);
                    },
                    inputFormatters: widget.inputFormatters,
                    keyboardType: widget.keyboardType,
                    maxLines: widget.maxLines,
                    maxLength: widget.maxLength,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: uiTheme.onBackground,
                      fontSize: widget.textSize ?? size(14),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fieldFill,
                      hintText: widget.hint,
                      hintStyle:
                          Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: uiTheme.hintColor,
                        fontSize: widget.hintSize ?? size(14),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              if (hasSuffix)
                Padding(
                  padding: EdgeInsets.only(
                    left: size(12),
                    right: size(16),
                    top: verticalPadding,
                    bottom: verticalPadding,
                  ),
                  child: widget.suffixWidget!,
                ),
            ],
          ),
        ),
        if (hasError) ...[
          SizedBox(height: sizeHeight(4)),
          Text(
            widget.errorText!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: uiTheme.error,
              fontSize: widget.errorSize ?? size(12),
            ),
          ),
        ] else if (widget.helperText != null) ...[
          SizedBox(height: sizeHeight(4)),
          Text(
            widget.helperText!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: uiTheme.hintColor,
              fontSize: widget.helperSize ?? size(12),
            ),
          ),
        ],
      ],
    );
  }
}
