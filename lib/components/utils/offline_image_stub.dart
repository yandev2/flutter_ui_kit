import 'package:flutter/widgets.dart';

Widget buildOfflineImage({
  required String imagePath,
  required BoxConstraints constraints,
  required Widget Function(String message) errorBuilder,
}) {
  throw UnsupportedError('Cannot use offline image on this platform');
}
