import 'package:flutter/material.dart';

/// Ekstensi super lengkap untuk mempermudah penulisan UI secara deklaratif
/// dan meminimalisir deep-nesting pada pohon widget (Widget Tree).
extension WidgetExtension on Widget {
  // ==========================================
  // PADDING & MARGIN
  // ==========================================

  /// Membungkus widget dengan [Padding] di semua sisi.
  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
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
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Memberikan margin menggunakan [Container].
  Widget marginAll(double margin) {
    return Container(margin: EdgeInsets.all(margin), child: this);
  }

  // ==========================================
  // LAYOUT & POSITIONING
  // ==========================================

  /// Membungkus widget dengan [Expanded].
  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  /// Membungkus widget dengan [Flexible].
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(flex: flex, fit: fit, child: this);
  }

  /// Membungkus widget dengan [Center].
  Widget center() {
    return Center(child: this);
  }

  /// Membungkus widget dengan [Align].
  Widget align(AlignmentGeometry alignment) {
    return Align(alignment: alignment, child: this);
  }

  /// Membungkus widget dengan [Positioned] (hanya berlaku jika parent adalah [Stack]).
  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  // ==========================================
  // SIZING
  // ==========================================

  /// Membungkus widget ke dalam [SizedBox] dengan ukuran spesifik.
  Widget sized({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  /// Set lebar (width) secara instan.
  Widget width(double w) => SizedBox(width: w, child: this);

  /// Set tinggi (height) secara instan.
  Widget height(double h) => SizedBox(height: h, child: this);

  /// Membungkus widget dengan [ConstrainedBox].
  Widget constrained(BoxConstraints constraints) {
    return ConstrainedBox(constraints: constraints, child: this);
  }

  // ==========================================
  // VISIBILITY, STYLING, & DECORATION
  // ==========================================

  /// Menampilkan atau menyembunyikan widget layaknya pengkondisian `if`.
  Widget visible(
    bool isVisible, {
    Widget replacement = const SizedBox.shrink(),
  }) {
    return isVisible ? this : replacement;
  }

  /// Memberikan level transparansi menggunakan [Opacity].
  Widget opacity(double opacity) {
    return Opacity(opacity: opacity, child: this);
  }

  /// Memotong widget menjadi melengkung di sudut (border radius).
  Widget clipRRect({double radius = 8.0}) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  /// Memotong widget berbentuk lingkaran penuh/oval.
  Widget clipOval() {
    return ClipOval(child: this);
  }

  /// Memberikan background color langsung (menggunakan [DecoratedBox]).
  Widget backgroundColor(Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color),
      child: this,
    );
  }

  // ==========================================
  // GESTURES & INTERACTIONS
  // ==========================================

  /// Memberikan event aksi tap dasar menggunakan [GestureDetector] yang aman dari area kosong.
  Widget onTap(
    VoidCallback? onTap, {
    HitTestBehavior behavior = HitTestBehavior.opaque,
  }) {
    return GestureDetector(onTap: onTap, behavior: behavior, child: this);
  }

  /// Memberikan efek klik Ripple (efek air/bayangan khas Android Material).
  Widget onInkTap(VoidCallback? onTap, {double borderRadius = 0}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: this,
      ),
    );
  }

  // ==========================================
  // SCROLLING & SLIVERS
  // ==========================================

  /// Membungkus widget box biasa agar bisa ditaruh di dalam `CustomScrollView` (Sliver Array).
  Widget sliverToBoxAdapter() {
    return SliverToBoxAdapter(child: this);
  }
}
