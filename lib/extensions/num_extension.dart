/// Format [double] ke teks persentase.
///
/// Nilai antara -1.0 hingga 1.0 dianggap sebagai pecahan (0.5 → `50%`, 1.0 → `100%`, -0.2 → `-20%`).
/// Nilai di luar rentang tersebut dianggap sudah dalam bentuk persen (50 → `50%`).
extension DoublePercentFormatExtension on double {
  String toPercent({
    int? fractionDigits,
    bool useComma = false,
    bool? isFraction,
    String fallback = '-',
  }) {
    if (isNaN || isInfinite) return fallback;

    final percent = _asPercentValue(isFraction: isFraction);

    String result;
    if (fractionDigits != null) {
      result = percent.toStringAsFixed(fractionDigits);
    } else if (percent == percent.roundToDouble()) {
      result = percent.round().toString();
    } else {
      result = percent.toStringAsFixed(1);
    }

    if (useComma) {
      result = result.replaceAll('.', ',');
    }

    return '$result%';
  }

  double _asPercentValue({bool? isFraction}) {
    // Jika user memaksa flag isFraction (true/false), ikuti pilihan user
    if (isFraction != null) {
      return isFraction ? this * 100 : this;
    }
    // Jika null, gunakan fallback logika default bawaan (heuristic)
    if (this >= -1.0 && this <= 1.0 && this != 0.0) return this * 100;
    return this;
  }
}

/// Format [num] ke teks persentase dan format angka (alias untuk [double]).
extension NumFormatExtension on num {
  String toPercent({
    int? fractionDigits,
    bool useComma = false,
    bool? isFraction,
    String fallback = '-',
  }) {
    return toDouble().toPercent(
      fractionDigits: fractionDigits,
      useComma: useComma,
      isFraction: isFraction,
      fallback: fallback,
    );
  }

  /// Memformat angka menjadi string dengan pemisah ribuan (contoh: 1000000 -> "1.000.000").
  /// Mengabaikan angka desimal dan membulatkan ke bawah.
  String toThousandFormat({String separator = '.'}) {
    final isNegative = this < 0;
    final str = abs().truncate().toString();
    var res = '';
    var count = 0;
    for (var i = str.length - 1; i >= 0; i--) {
      if (count != 0 && count % 3 == 0) {
        res = separator + res;
      }
      res = str[i] + res;
      count++;
    }
    return isNegative ? '-$res' : res;
  }
}

/// Parse string teks persentase kembali menjadi pecahan [double].
extension StringPercentFormatExtension on String {
  /// Parse string seperti `"50%"` atau `"50"` menjadi nilai pecahan (contoh: `0.5`).
  double? toPercentFraction() {
    final cleanString = replaceAll('%', '').trim();
    final value = double.tryParse(cleanString);
    if (value != null) {
      return value / 100;
    }
    return null;
  }
}
