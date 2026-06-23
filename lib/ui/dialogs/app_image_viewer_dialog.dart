import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/dialogs/app_image_viewer_file_image_stub.dart'
    if (dart.library.io) 'package:flutter_ui_kit/ui/dialogs/app_image_viewer_file_image.dart';

class AppImageViewerDialog extends StatelessWidget {
  final String? imageUrl;
  final String? imagePath;

  const AppImageViewerDialog.online({
    super.key,
    required this.imageUrl,
  }) : imagePath = null;

  const AppImageViewerDialog.offline({
    super.key,
    required this.imagePath,
  }) : imageUrl = null;

  bool get _isOnline => imageUrl != null && imageUrl!.trim().isNotEmpty;

  static Future<T?> showOnline<T>({
    required String imageUrl,
    bool barrierDismissible = true,
  }) {
    return Get.dialog<T>(
      AppImageViewerDialog.online(imageUrl: imageUrl),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.92),
    );
  }

  static Future<T?> showOffline<T>({
    required String imagePath,
    bool barrierDismissible = true,
  }) {
    return Get.dialog<T>(
      AppImageViewerDialog.offline(imagePath: imagePath),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.92),
    );
  }

  void _close() => Get.back();

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeroIcon(
            HeroIcons.photo,
            color: AppColors.neutral400,
            size: AppScale.w(48),
          ),
          SizedBox(height: AppScale.h(12)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppScale.sp(14),
              color: AppColors.neutral300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContent(BoxConstraints constraints) {
    if (_isOnline) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.contain,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        placeholder: (_, _) => Center(
          child: SizedBox(
            width: AppScale.w(36),
            height: AppScale.w(36),
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.white,
            ),
          ),
        ),
        errorWidget: (_, _, _) => _buildError('Failed to load image'),
      );
    }

    return buildOfflineImage(
      imagePath: imagePath!,
      constraints: constraints,
      errorBuilder: _buildError,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: AppScale.w(8),
        vertical: AppScale.h(8),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height * 0.92,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppScale.r(12)),
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
                        boundaryMargin: EdgeInsets.all(AppScale.w(48)),
                        child: Center(
                          child: SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: _buildImageContent(constraints),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: AppScale.h(8),
                  right: AppScale.w(8),
                  child: Material(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      onPressed: _close,
                      icon: Icon(
                        Icons.close,
                        color: AppColors.white,
                        size: AppScale.w(22),
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
