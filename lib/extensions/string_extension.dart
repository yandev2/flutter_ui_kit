import 'package:flutter/material.dart';

/// Ekstensi super lengkap untuk manipulasi tipe data [String].
extension StringFormatExtension on String {
  // --- Numeric Parsers ---

  /// Mengubah String menjadi int, mengembalikan null jika gagal.
  int? toIntOrNull() => int.tryParse(this);

  /// Mengubah String menjadi int, mengembalikan default value (0) jika gagal.
  int toInt({int defaultValue = 0}) => int.tryParse(this) ?? defaultValue;

  /// Mengubah String menjadi double, mengembalikan null jika gagal.
  double? toDoubleOrNull() => double.tryParse(this);

  /// Mengubah String menjadi double, mengembalikan default value (0.0) jika gagal.
  double toDouble({double defaultValue = 0.0}) =>
      double.tryParse(this) ?? defaultValue;

  // --- Case Manipulators ---

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

  /// Mengubah ke camelCase (contoh: "Hello World" -> "helloWorld").
  String toCamelCase() {
    if (isEmpty) return this;
    final words = split(RegExp(r'[\s_-]+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '';
    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalize()).join('');
  }

  /// Mengubah ke snake_case (contoh: "helloWorld" -> "hello_world").
  String toSnakeCase() {
    if (isEmpty) return this;
    final exp = RegExp(r'(?<=[a-z])(?=[A-Z])|[\s-]+');
    return split(exp).join('_').toLowerCase();
  }

  /// Mengubah ke kebab-case (contoh: "hello World" -> "hello-world").
  String toKebabCase() {
    if (isEmpty) return this;
    final exp = RegExp(r'(?<=[a-z])(?=[A-Z])|[\s_]+');
    return split(exp).join('-').toLowerCase();
  }

  // --- Utility ---

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

  /// Menghapus semua spasi/whitespace dari string.
  String removeWhitespace() => replaceAll(RegExp(r'\s+'), '');

  /// Menghapus semua karakter selain angka (mengembalikan murni angka saja).
  /// Berguna untuk mengambil nilai mentah (raw) dari TextField yang menggunakan Mask Input Formatter (seperti NPWP, KTP, atau No HP).
  String toNumericOnly() => replaceAll(RegExp(r'[^\d]'), '');

  /// Menghapus semua karakter selain angka dan huruf (mengembalikan murni alfanumerik).
  String toAlphaNumericOnly() => replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

  /// Membalik urutan teks (contoh: "hello" -> "olleh").
  String reverse() {
    if (isEmpty) return this;
    return split('').reversed.join('');
  }

  // --- Validators ---

  /// Mengecek apakah string merupakan format email yang valid.
  bool get isEmail {
    final exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return exp.hasMatch(this);
  }

  /// Mengecek apakah string merupakan URL yang valid.
  bool get isUrl {
    final exp = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    return exp.hasMatch(this);
  }

  /// Mengecek apakah string murni terdiri dari angka (numeric).
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  /// Mengecek apakah string murni terdiri dari huruf alfabet.
  bool get isAlphabet {
    final exp = RegExp(r'^[a-zA-Z]+$');
    return exp.hasMatch(this);
  }

  /// Mengecek apakah password kuat (minimal 8 karakter, ada huruf besar, huruf kecil, angka, dan karakter spesial).
  bool get isStrongPassword {
    final exp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$',
    );
    return exp.hasMatch(this);
  }
}
