import 'package:flutter/material.dart';

/// Ekstensi untuk memanipulasi [Color] dengan mudah.
extension ColorExtension on Color {
  /// Menggelapkan warna sebesar persentase [amount] (0.0 - 1.0).
  /// Contoh: `Colors.red.darken(0.2)`
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// Mencerahkan warna sebesar persentase [amount] (0.0 - 1.0).
  /// Contoh: `Colors.blue.lighten(0.15)`
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  /// Mengonversi warna menjadi format string Hex (cth: `#FF5733`).
  String toHex({bool leadingHashSign = true}) {
    // Abaikan peringatan deprecation (jika ada pada Flutter versi terbaru)
    // ignore: deprecated_member_use
    final hexString = value.toRadixString(16).padLeft(8, '0').toUpperCase();
    return '${leadingHashSign ? '#' : ''}$hexString';
  }
}
