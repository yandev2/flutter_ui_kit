import 'package:flutter/widgets.dart';

Widget buildOfflineImage({
  required String imagePath,
  required BoxConstraints constraints,
  required Widget Function(String message) errorBuilder,
}) {
  return errorBuilder('Offline image is not supported on this platform');
}
