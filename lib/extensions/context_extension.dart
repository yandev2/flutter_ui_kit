import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// Mendapatkan [ThemeData]
  ThemeData get theme => Theme.of(this);

  /// Mendapatkan [TextTheme]
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Mendapatkan [ColorScheme]
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Mendapatkan ukuran layar
  Size get screenSize => MediaQuery.of(this).size;

  /// Mendapatkan lebar layar
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Mendapatkan tinggi layar
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Mengecek apakah aplikasi sedang dalam mode gelap
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
