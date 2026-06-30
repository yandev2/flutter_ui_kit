import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../ui_component_flutter.dart';
import '../theme/app_scale.dart' as scale;
import 'utils/offline_image.dart';

class AppImageViewerDialog extends StatelessWidget {
  final String? imageUrl;
  final String? imagePath;

  const AppImageViewerDialog.online({super.key, required this.imageUrl})
    : imagePath = null;

  const AppImageViewerDialog.offline({super.key, required this.imagePath})
    : imageUrl = null;

  bool get _isOnline => imageUrl != null && imageUrl!.trim().isNotEmpty;

  static Future<T?> showOnline<T>(
    BuildContext context, {
    required String imageUrl,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (context) => AppImageViewerDialog.online(imageUrl: imageUrl),
    );
  }

  static Future<T?> showOffline<T>(
    BuildContext context, {
    required String imagePath,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (context) => AppImageViewerDialog.offline(imagePath: imagePath),
    );
  }

  void _close(BuildContext context) => Navigator.of(context).pop();

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeroIcon(
            HeroIcons.photo,
            color: context.uiTheme.hintColor,
            size: scale.size(48),
          ),
          SizedBox(height: scale.sizeHeight(12)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: scale.size(14),
              color: context.uiTheme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContent(BuildContext context, BoxConstraints constraints) {
    if (_isOnline) {
      return AppImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      );
    }

    return buildOfflineImage(
      imagePath: imagePath!,
      constraints: constraints,
      errorBuilder: (message) => _buildError(context, message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: scale.size(8),
        vertical: scale.sizeHeight(8),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height * 0.92,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(scale.size(12)),
          child: ColoredBox(
            color: Colors.black.withValues(alpha: 0.55),
            child: Stack(
              children: [
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return InteractiveViewer(
                        minScale: 0.8,
                        maxScale: 5,
                        panEnabled: true,
                        scaleEnabled: true,
                        boundaryMargin: EdgeInsets.all(scale.size(48)),
                        child: Center(
                          child: SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: _buildImageContent(context, constraints),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: scale.sizeHeight(8),
                  right: scale.size(8),
                  child: Material(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      onPressed: () => _close(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: scale.size(22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
