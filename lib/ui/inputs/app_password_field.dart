import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/inputs/app_textfield.dart';

class AppPasswordField extends StatefulWidget {
  final String? title;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final bool showStrengthIndicator;
  final ValueChanged<String>? onChanged;

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
    this.prefixIcon = Icons.lock_outline,
    this.showStrengthIndicator = true,
    this.onChanged,
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
    final length = _passwordText.length;
    final isYellow = length > 0 && length < 8;
    final isGreen = length >= 8;

    int activeSegments = 0;
    if (isGreen) {
      activeSegments = 4;
    } else if (isYellow) {
      activeSegments = 2;
    }

    final color = isGreen ? Colors.green : Colors.amber;

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
          onChanged: (val) {
            setState(() {
              _passwordText = val;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(val);
            }
          },
          suffixWidget: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Icon(
              _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: AppColors.textSecondary,
              size: AppScale.w(20),
            ),
          ),
        ),
        if (widget.showStrengthIndicator) ...[
          SizedBox(height: AppScale.h(8)),
          Row(
            children: List.generate(4, (index) {
              final isActive = index < activeSegments;
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: AppScale.h(4),
                  margin: EdgeInsets.only(
                    right: index < 3 ? AppScale.w(4) : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? color : AppColors.border,
                    borderRadius: BorderRadius.circular(AppScale.r(2)),
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
