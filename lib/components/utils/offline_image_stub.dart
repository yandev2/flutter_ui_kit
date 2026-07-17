import 'package:flutter/widgets.dart';

Widget buildOfflineImage({
  required String imagePath,
  required BoxConstraints constraints,
  required Widget Function(String message) errorBuilder,
}) {
  throw UnsupportedError('Cannot use offline image on this platform');
}

Widget buildPathImage({
  required String imagePath,
  BoxFit fit = BoxFit.cover,
}) {
  throw UnsupportedError('Cannot use local path image on this platform');
}
