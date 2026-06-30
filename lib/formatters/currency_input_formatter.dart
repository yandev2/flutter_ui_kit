import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../extensions/currency_extension.dart';

/// Formatter TextField khusus untuk mata uang.
/// Angka yang diketik akan otomatis ditambahkan separator (titik/koma).
/// Jika ada [decimalDigits], angka yang diketik akan otomatis bergeser dari belakang (desimal).
class CurrencyInputFormatter extends TextInputFormatter {
  final AppCurrencyType type;
  final int decimalDigits;
  final bool showSymbol;
  final String symbolSeparator;

  CurrencyInputFormatter({
    this.type = AppCurrencyType.rupiah,
    this.decimalDigits = 0,
    this.showSymbol = false,
    this.symbolSeparator = ' ',
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    // Hapus semua karakter selain angka
    String cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    double value = double.parse(cleanText);

    // Geser desimal dari kanan ke kiri
    if (decimalDigits > 0) {
      value = value / pow(10, decimalDigits);
    }

    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: type.locale,
      symbol:
          '', // Kita tambahkan simbol secara manual agar format spasi bisa diatur
      decimalDigits: decimalDigits,
    );

    String newText = currencyFormat.format(value).trim();

    // Tambahkan simbol jika diminta
    if (showSymbol) {
      newText = '${type.symbol}$symbolSeparator$newText';
    }

    return newValue.copyWith(
      text: newText,
      // Karena pengetikan uang nominal bergeser dari kanan ke kiri (terutama untuk desimal),
      // kursor selalu diamankan di akhir teks agar tidak melompat.
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
