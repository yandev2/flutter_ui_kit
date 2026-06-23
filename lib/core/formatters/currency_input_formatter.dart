import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final String symbol;
  final int decimalDigits;

  CurrencyInputFormatter({
    this.symbol = '',
    this.decimalDigits = 0,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove all non-digit characters
    String cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double value = double.parse(cleanText);

    // If there are decimal digits, we treat the last N digits as decimals
    if (decimalDigits > 0) {
      value = value / (100.0); // Assuming 2 decimal digits for cents
    }

    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: symbol == 'Rp' ? 'id_ID' : 'en_US',
      symbol: '', // We handle symbol rendering in the prefixWidget usually
      decimalDigits: decimalDigits,
    );

    String newText = currencyFormat.format(value).trim();

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
