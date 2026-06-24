import 'package:intl/intl.dart';

extension NumFormatExtension on num {
  /// Mengubah angka menjadi format ringkas (contoh: 1500 -> 1.5K, 2000000 -> 2M).
  /// Sangat berguna untuk counter followers, likes, atau views.
  String toCompact() {
    return NumberFormat.compact(locale: 'en_US').format(this);
  }
}
