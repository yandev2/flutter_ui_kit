import 'package:intl/intl.dart';

/// Pilihan mata uang yang didukung.
enum AppCurrencyType { rupiah, dollar, euro, pound, yen }

/// Helper extension untuk enum [AppCurrencyType].
extension AppCurrencyTypeExtension on AppCurrencyType {
  /// Mendapatkan simbol mata uang.
  String get symbol {
    switch (this) {
      case AppCurrencyType.rupiah:
        return 'Rp';
      case AppCurrencyType.dollar:
        return '\$';
      case AppCurrencyType.euro:
        return '€';
      case AppCurrencyType.pound:
        return '£';
      case AppCurrencyType.yen:
        return '¥';
    }
  }

  /// Mendapatkan format penulisan angka spesifik (locale) tiap negara.
  String get locale {
    switch (this) {
      case AppCurrencyType.rupiah:
        return 'id_ID';
      case AppCurrencyType.dollar:
        return 'en_US';
      case AppCurrencyType.euro:
        return 'fr_FR'; // Locale Eropa umum
      case AppCurrencyType.pound:
        return 'en_GB';
      case AppCurrencyType.yen:
        return 'ja_JP';
    }
  }
}

/// Format [num] ke teks mata uang yang fleksibel (berlaku untuk int dan double).
extension NumCurrencyFormatExtension on num {
  /// Mengubah angka menjadi format mata uang lengkap (misal: `Rp 5.000` / `$ 50.00`).
  ///
  /// - [type]: Jenis mata uang (Default: `AppCurrencyType.rupiah`).
  /// - [decimalDigits]: Jumlah angka di belakang koma (Default 0).
  /// - [compact]: Jika `true`, menyingkat angka besar (Contoh: 1.500.000 -> 1,5 jt / 1.5M).
  /// - [symbolSeparator]: Pemisah antara simbol dan nominal (Default: '').
  String toCurrency({
    AppCurrencyType type = AppCurrencyType.rupiah,
    int? decimalDigits = 0,
    bool compact = false,
    String symbolSeparator = '',
  }) {
    final absValue = abs();
    final isNegative = this < 0;

    NumberFormat formatter;
    if (compact) {
      formatter = NumberFormat.compact(locale: type.locale);
    } else {
      formatter = NumberFormat.currency(
        locale: type.locale,
        symbol: '',
        decimalDigits: decimalDigits,
      );
    }

    final formattedNum = formatter.format(absValue).trim();
    final sign = isNegative ? '-' : '';

    return '$sign${type.symbol}$symbolSeparator$formattedNum';
  }

  /// Alias cepat untuk format Rupiah.
  /// Contoh: `50000.toRupiah()` -> `Rp 50.000`
  String toRupiah({
    int decimalDigits = 0,
    bool compact = false,
    String symbolSeparator = ' ',
  }) => toCurrency(
    type: AppCurrencyType.rupiah,
    decimalDigits: decimalDigits,
    compact: compact,
    symbolSeparator: symbolSeparator,
  );

  /// Alias cepat untuk format Dollar.
  /// Contoh: `50.5.toDollar()` -> `$50.50`
  String toDollar({
    int decimalDigits = 2,
    bool compact = false,
    String symbolSeparator = '',
  }) => toCurrency(
    type: AppCurrencyType.dollar,
    decimalDigits: decimalDigits,
    compact: compact,
    symbolSeparator: symbolSeparator,
  );
}

/// Parse string mata uang kembali menjadi [double].
extension StringCurrencyFormatExtension on String {
  /// Menghilangkan simbol mata uang, spasi, dan separator ribuan untuk mengubah
  /// string seperti `"Rp 15.000,50"` kembali menjadi pecahan numerik `15000.5`.
  double? toCurrencyFraction([AppCurrencyType type = AppCurrencyType.rupiah]) {
    // Hilangkan simbol mata uang dan whitespace
    String cleanString = replaceAll(type.symbol, '').trim();

    // Perlakuan khusus separator berdasarkan locale
    if (type.locale == 'id_ID' || type.locale == 'fr_FR') {
      // Titik jadi ribuan, koma jadi desimal
      cleanString = cleanString.replaceAll('.', '');
      cleanString = cleanString.replaceAll(',', '.');
    } else {
      // Bahasa inggris: koma jadi ribuan, titik jadi desimal
      cleanString = cleanString.replaceAll(',', '');
    }

    // Hindari parsing string compact ("1,5 jt" atau "1.5M") karena lebih kompleks.
    // Hanya mendukung angka murni hasil toCurrency normal.
    return double.tryParse(cleanString);
  }
}
