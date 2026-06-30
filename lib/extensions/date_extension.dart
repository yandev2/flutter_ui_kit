/// Gaya format tanggal/waktu untuk [DateTimeFormatExtension].
enum AppDateTimeFormat {
  /// `15 12 2002`
  dmyNumeric,

  /// `15 Des 2002`
  dmyShortMonth,

  /// `15 Desember 2002`
  dmyFullMonth,

  /// `Desember 2002`
  monthYear,

  /// `14:24`
  timeHm,
}

const _monthsShortId = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

const _monthsFullId = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

/// Format [DateTime] ke berbagai bentuk teks tanggal/waktu.
extension DateTimeFormatExtension on DateTime {
  String formatted([AppDateTimeFormat style = AppDateTimeFormat.dmyNumeric]) {
    switch (style) {
      case AppDateTimeFormat.dmyNumeric:
        return toDmyNumeric();
      case AppDateTimeFormat.dmyShortMonth:
        return toDmyShortMonth();
      case AppDateTimeFormat.dmyFullMonth:
        return toDmyFullMonth();
      case AppDateTimeFormat.monthYear:
        return toMonthYear();
      case AppDateTimeFormat.timeHm:
        return toTimeHm();
    }
  }

  /// `15 12 2002`
  String toDmyNumeric() => '$day $month $year';

  /// `15 Des 2002`
  String toDmyShortMonth() => '$day ${_monthsShortId[month - 1]} $year';

  /// `15 Desember 2002`
  String toDmyFullMonth() => '$day ${_monthsFullId[month - 1]} $year';

  /// `Desember 2002`
  String toMonthYear() => '${_monthsFullId[month - 1]} $year';

  /// `14:24`
  String toTimeHm() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

/// Parse string ke bentuk format tertentu atau ke [DateTime].
extension StringParseDateExtension on String {
  /// Parse string ISO/date lalu format ke bentuk teks tanggal/waktu.
  String toFormattedDate([
    AppDateTimeFormat style = AppDateTimeFormat.dmyNumeric,
  ]) {
    final parsed = DateTime.tryParse(trim());
    if (parsed == null) return this;
    return parsed.formatted(style);
  }

  /// Parse string teks tanggal/waktu (seperti '15 Desember 2002') kembali ke [DateTime].
  /// Berguna untuk konversi terbalik dari string ke date berdasarkan format.
  DateTime? toDate([AppDateTimeFormat? style]) {
    final trimmed = trim();

    if (style == null) {
      return DateTime.tryParse(trimmed);
    }

    final parts = trimmed.split(' ');

    switch (style) {
      case AppDateTimeFormat.dmyNumeric:
        if (parts.length >= 3) {
          final day = int.tryParse(parts[0]);
          final month = int.tryParse(parts[1]);
          final year = int.tryParse(parts[2]);
          if (day != null && month != null && year != null) {
            return DateTime(year, month, day);
          }
        }
        break;
      case AppDateTimeFormat.dmyShortMonth:
        if (parts.length >= 3) {
          final day = int.tryParse(parts[0]);
          final month = _monthsShortId.indexOf(parts[1]) + 1;
          final year = int.tryParse(parts[2]);
          if (day != null && month > 0 && year != null) {
            return DateTime(year, month, day);
          }
        }
        break;
      case AppDateTimeFormat.dmyFullMonth:
        if (parts.length >= 3) {
          final day = int.tryParse(parts[0]);
          final month = _monthsFullId.indexOf(parts[1]) + 1;
          final year = int.tryParse(parts[2]);
          if (day != null && month > 0 && year != null) {
            return DateTime(year, month, day);
          }
        }
        break;
      case AppDateTimeFormat.monthYear:
        if (parts.length >= 2) {
          final month = _monthsFullId.indexOf(parts[0]) + 1;
          final year = int.tryParse(parts[1]);
          if (month > 0 && year != null) {
            return DateTime(year, month, 1);
          }
        }
        break;
      case AppDateTimeFormat.timeHm:
        final timeParts = trimmed.split(':');
        if (timeParts.length >= 2) {
          final hour = int.tryParse(timeParts[0]);
          final minute = int.tryParse(timeParts[1]);
          if (hour != null && minute != null) {
            final now = DateTime.now();
            return DateTime(now.year, now.month, now.day, hour, minute);
          }
        }
        break;
    }

    // Fallback parser standar Dart jika tidak cocok dengan format
    return DateTime.tryParse(trimmed);
  }
}
