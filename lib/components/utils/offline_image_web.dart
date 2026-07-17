import 'package:flutter/widgets.dart';

Widget buildOfflineImage({
  required String imagePath,
  required BoxConstraints constraints,
  required Widget Function(String message) errorBuilder,
}) {
  return errorBuilder('Offline image is not supported on Web');
}

Widget buildPathImage({
  required String imagePath,
  BoxFit fit = BoxFit.cover,
}) {
  // image_picker on web returns blob / object URLs that Image.network can load.
  return Image.network(imagePath, fit: fit);
}
