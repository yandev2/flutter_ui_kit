/// Format [double] ke teks persentase.
///
/// Nilai 0.0–1.0 dianggap sebagai pecahan (0.5 → `50%`, 1.0 → `100%`).
/// Nilai di atas 1 dianggap sudah dalam bentuk persen (50 → `50%`).
extension DoublePercentFormatExtension on double {
  String toPercent({int? fractionDigits}) {
    final percent = _asPercentValue();

    if (fractionDigits != null) {
      return '${percent.toStringAsFixed(fractionDigits)}%';
    }

    if (percent == percent.roundToDouble()) {
      return '${percent.round()}%';
    }

    return '${percent.toStringAsFixed(1)}%';
  }

  double _asPercentValue() {
    if (this >= 0 && this <= 1) return this * 100;
    return this;
  }
}

/// Format [num] ke teks persentase (alias untuk [double]).
extension NumPercentFormatExtension on num {
  String toPercent({int? fractionDigits}) {
    return toDouble().toPercent(fractionDigits: fractionDigits);
  }
}
