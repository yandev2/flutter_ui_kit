import 'package:flutter/material.dart';
import '../ui_component_flutter.dart';

class AppCurrencyField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? initialValue;

  final int decimalDigits;
  final bool showSymbol;
  final AppCurrencyType currencyType;

  final double? titleSize;
  final double? textSize;
  final double? hintSize;
  final double? helperSize;
  final double? errorSize;

  final Color? fillColor;
  final Iterable<String>? autofillHints;

  const AppCurrencyField({
    super.key,
    this.title = 'Nominal',
    this.hint = '0',
    this.helperText,
    this.errorText,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.decimalDigits = 0,
    this.showSymbol = true,
    this.currencyType = AppCurrencyType.rupiah,
    this.titleSize,
    this.textSize,
    this.hintSize,
    this.helperSize,
    this.errorSize,
    this.fillColor,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      title: title,
      hint: hint,
      helperText: helperText,
      errorText: errorText,
      controller: controller,
      initialValue: initialValue,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.done,
      autofillHints:
          autofillHints ?? const [AutofillHints.transactionAmount],
      inputFormatters: [
        CurrencyInputFormatter(
          type: currencyType,
          decimalDigits: decimalDigits,
          showSymbol: showSymbol,
        ),
      ],
      onChanged: onChanged,
      titleSize: titleSize,
      textSize: textSize,
      hintSize: hintSize,
      helperSize: helperSize,
      errorSize: errorSize,
      fillColor: fillColor,
    );
  }
}
