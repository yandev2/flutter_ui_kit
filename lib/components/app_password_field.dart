import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter/services.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppPasswordField extends StatefulWidget {
  final String? title;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final HeroIcons? prefixIcon;
  final bool showStrengthIndicator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  final double? titleSize;
  final double? textSize;
  final double? hintSize;
  final double? helperSize;
  final double? errorSize;

  final Color? fillColor;

  const AppPasswordField({
    super.key,
    this.title = 'Password',
    this.hint = '••••••••',
    this.helperText,
    this.errorText,
    this.prefixIcon = HeroIcons.lockClosed,
    this.showStrengthIndicator = true,
    this.onChanged,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.titleSize,
    this.textSize,
    this.hintSize,
    this.helperSize,
    this.errorSize,
    this.fillColor,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;
  String _passwordText = '';

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final length = _passwordText.length;
    final isYellow = length > 0 && length < 8;
    final isGreen = length >= 8;

    int activeSegments = 0;
    if (isGreen) {
      activeSegments = 4;
    } else if (isYellow) {
      activeSegments = 2;
    }

    final color = isGreen ? uiTheme.success : uiTheme.warning;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          title: widget.title,
          hint: widget.hint,
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          obscureText: _obscureText,
          titleSize: widget.titleSize,
          textSize: widget.textSize,
          hintSize: widget.hintSize,
          helperSize: widget.helperSize,
          errorSize: widget.errorSize,
          fillColor: widget.fillColor,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          inputFormatters: [
            NoSpaceFormatter(),
            if (widget.inputFormatters != null) ...widget.inputFormatters!,
          ],
          onChanged: (val) {
            setState(() {
              _passwordText = val;
            });
            if (widget.onChanged != null) {
              widget.onChanged?.call(val);
            }
          },
          suffixWidget: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            behavior: HitTestBehavior.opaque,
            child: HeroIcon(
              _obscureText ? HeroIcons.eye : HeroIcons.eyeSlash,
              color: uiTheme.hintColor,
              size: size(20),
            ),
          ),
        ),
        if (widget.showStrengthIndicator) ...[
          SizedBox(height: sizeHeight(8)),
          Row(
            children: List.generate(4, (index) {
              final isActive = index < activeSegments;
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: sizeHeight(4),
                  margin: EdgeInsets.only(right: index < 3 ? size(4) : 0),
                  decoration: BoxDecoration(
                    color: isActive ? color : uiTheme.borderColor,
                    borderRadius: BorderRadius.circular(size(2)),
                  ),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}
