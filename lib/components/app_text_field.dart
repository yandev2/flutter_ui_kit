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

  @override
  void initState() {
    super.initState();
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
          padding: EdgeInsets.symmetric(horizontal: size(16)),
          decoration: BoxDecoration(
            color: widget.fillColor ?? uiTheme.background,
            borderRadius: BorderRadius.circular(size(8)),
            border: Border.all(color: borderColor, width: size(1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.prefixIcon != null) ...[
                HeroIcon(
                  widget.prefixIcon!,
                  color: hasError
                      ? uiTheme.error
                      : _isFocused
                      ? uiTheme.primary
                      : uiTheme.hintColor,
                  size: size(20),
                ),
                SizedBox(width: size(12)),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: widget.obscureText,
                  onChanged: widget.onChanged,
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: uiTheme.onBackground,
                    fontSize: widget.textSize ?? size(14),
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: uiTheme.hintColor,
                      fontSize: widget.hintSize ?? size(14),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: sizeHeight(12),
                    ),
                  ),
                ),
              ),
              if (widget.suffixWidget != null) ...[
                SizedBox(width: size(12)),
                widget.suffixWidget!,
              ],
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
