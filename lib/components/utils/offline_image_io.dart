import 'dart:io';
import 'package:flutter/widgets.dart';

Widget buildOfflineImage({
  required String imagePath,
  required BoxConstraints constraints,
  required Widget Function(String message) errorBuilder,
}) {
  final file = File(imagePath);
  if (!file.existsSync()) {
    return errorBuilder('Image file not found');
  }

  return Image.file(
    file,
    fit: BoxFit.contain,
    width: constraints.maxWidth,
    height: constraints.maxHeight,
    errorBuilder: (_, _, _) => errorBuilder('Failed to load image'),
  );
}
