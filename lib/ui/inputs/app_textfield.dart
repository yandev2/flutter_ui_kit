import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppTextField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? helperText;
  final String? errorText;

  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.title,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixWidget,
    this.suffixWidget,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Menentukan Prefix
    Widget? builtPrefix;
    if (prefixWidget != null) {
      builtPrefix = prefixWidget;
    } else if (prefixIcon != null) {
      builtPrefix = Icon(
        prefixIcon,
        color: AppColors.textSecondary,
        size: AppScale.w(20),
      );
    }

    // Menentukan Suffix
    Widget? builtSuffix;
    if (suffixWidget != null) {
      builtSuffix = suffixWidget;
    } else if (suffixIcon != null) {
      builtSuffix = Icon(
        suffixIcon,
        color: AppColors.textSecondary,
        size: AppScale.w(20),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              fontSize: AppScale.sp(14),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: AppScale.h(6)),
        ],
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          style: TextStyle(
            fontSize: AppScale.sp(14),
            color: theme.textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppScale.sp(14),
            ),
            errorText: errorText,
            // Constraints (0,0) agar icon bisa diset padding-nya secara manual
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            prefixIcon: builtPrefix != null
                ? Padding(
                    padding: EdgeInsets.only(
                      left: AppScale.w(16),
                      right: AppScale.w(
                        8,
                      ), // Jarak antara prefix dan teks ketikan
                    ),
                    child: builtPrefix,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: builtSuffix != null
                ? Padding(
                    padding: EdgeInsets.only(
                      left: AppScale.w(8),
                      right: AppScale.w(
                        16,
                      ), // Jarak antara suffix dan tepi form
                    ),
                    child: builtSuffix,
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppScale.w(16),
              vertical: AppScale.h(12),
            ),
            filled: true,
            fillColor: theme.scaffoldBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              borderSide: BorderSide(
                color: AppColors.border,
                width: AppScale.w(1.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              borderSide: BorderSide(
                color: AppColors.border,
                width: AppScale.w(1.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: AppScale.w(1.5),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppScale.r(8)),
              borderSide: BorderSide(
                color: AppColors.error,
                width: AppScale.w(1.0),
              ),
            ),
          ),
        ),
        if (helperText != null && errorText == null) ...[
          SizedBox(height: AppScale.h(6)),
          Text(
            helperText!,
            style: TextStyle(
              fontSize: AppScale.sp(12),
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
