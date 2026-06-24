import 'package:flutter/material.dart';

/// Ekstensi untuk mempermudah penulisan UI secara deklaratif (mengurangi nesting).
extension WidgetExtension on Widget {
  /// Membungkus widget dengan [Padding] di semua sisi.
  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  /// Membungkus widget dengan [Padding] simetris.
  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Membungkus widget dengan [Padding] spesifik.
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: this,
    );
  }

  /// Membungkus widget dengan [Expanded].
  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  /// Membungkus widget dengan [Flexible].
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(
      flex: flex,
      fit: fit,
      child: this,
    );
  }

  /// Membungkus widget dengan [Center].
  Widget center() {
    return Center(child: this);
  }

  /// Memberikan event aksi tap menggunakan [GestureDetector].
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: this,
    );
  }
}
