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
  String toDmyShortMonth() =>
      '$day ${_monthsShortId[month - 1]} $year';

  /// `15 Desember 2002`
  String toDmyFullMonth() =>
      '$day ${_monthsFullId[month - 1]} $year';

  /// `Desember 2002`
  String toMonthYear() => '${_monthsFullId[month - 1]} $year';

  /// `14:24`
  String toTimeHm() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

/// Parse string ISO/date lalu format ke bentuk tanggal/waktu.
extension StringDateTimeFormatExtension on String {
  String toFormattedDate([
    AppDateTimeFormat style = AppDateTimeFormat.dmyNumeric,
  ]) {
    final parsed = DateTime.tryParse(trim());
    if (parsed == null) return this;
    return parsed.formatted(style);
  }
}
