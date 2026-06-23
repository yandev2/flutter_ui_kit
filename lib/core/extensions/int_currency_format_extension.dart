import 'package:intl/intl.dart';

/// Jenis mata uang untuk [IntCurrencyFormatExtension].
enum AppCurrencyType {
  rupiah,
  dollar,
}

/// Format [int] ke teks mata uang Rupiah atau Dolar.
extension IntCurrencyFormatExtension on int {
  String toCurrency([AppCurrencyType type = AppCurrencyType.rupiah]) {
    switch (type) {
      case AppCurrencyType.rupiah:
        return toRupiah();
      case AppCurrencyType.dollar:
        return toDollar();
    }
  }

  /// `Rp.5.000`
  String toRupiah() {
    final formatted = NumberFormat('#,###', 'id_ID').format(this);
    return 'Rp.$formatted';
  }

  /// `$.5.000`
  String toDollar() {
    final formatted = NumberFormat('#,###', 'id_ID').format(this);
    return '\$.$formatted';
  }
}

/// Format [num] ke teks mata uang (alias untuk nilai non-int).
extension NumCurrencyFormatExtension on num {
  String toCurrency([AppCurrencyType type = AppCurrencyType.rupiah]) {
    return round().toCurrency(type);
  }

  String toRupiah() => round().toRupiah();

  String toDollar() => round().toDollar();
}
