import 'package:flutter/material.dart';

extension StringFormatExtension on String {
  /// Mengubah String menjadi int, mengembalikan null jika gagal.
  int? toIntOrNull() => int.tryParse(this);

  /// Mengubah String menjadi int, mengembalikan default value (0) jika gagal.
  int toInt({int defaultValue = 0}) => int.tryParse(this) ?? defaultValue;

  /// Mengubah String menjadi double, mengembalikan null jika gagal.
  double? toDoubleOrNull() => double.tryParse(this);

  /// Mengubah String menjadi double, mengembalikan default value (0.0) jika gagal.
  double toDouble({double defaultValue = 0.0}) => double.tryParse(this) ?? defaultValue;

  /// Kapitalisasi huruf pertama (contoh: "hello" -> "Hello").
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Kapitalisasi setiap awal kata (contoh: "hello world" -> "Hello World").
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Memotong string jika terlalu panjang dan menambahkan ellipsis ("...").
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  /// Mengubah format Hex Color ("#FF5733" atau "FF5733") menjadi [Color] Flutter.
  Color? toColor() {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.tryParse('0x$hexColor') ?? 0xFF000000);
    }
    return null;
  }
}
