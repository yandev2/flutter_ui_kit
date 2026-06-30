import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../ui_component_flutter.dart';
import '../theme/app_scale.dart' as scale;

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorIconSize,
    this.errorBackgroundColor,
    this.errorIconColor,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final double? errorIconSize;
  final Color? errorBackgroundColor;
  final Color? errorIconColor;

  bool get _hasValidUrl => imageUrl != null && imageUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final bgColor = errorBackgroundColor ?? context.uiTheme.borderColor;
    final iconColor = errorIconColor ?? context.uiTheme.hintColor;
    final iconSize = errorIconSize ?? scale.size(40);

    Widget child;
    if (!_hasValidUrl) {
      child = _buildErrorWidget(bgColor, iconColor, iconSize);
    } else {
      child = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (_, _) => Skeletonizer(
          child: Bone(
            width: width,
            height: height,
            borderRadius: BorderRadius.circular(scale.size(16)),
          ),
        ),
        errorWidget: (_, _, _) =>
            _buildErrorWidget(bgColor, iconColor, iconSize),
      );
    }

    if (width != null || height != null) {
      child = SizedBox(
        width: width == double.infinity ? null : width,
        height: height,
        child: child,
      );
    }

    if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }

  Widget _buildErrorWidget(Color bgColor, Color iconColor, double iconSize) {
    return Container(
      width: width,
      height: height,
      color: bgColor,
      alignment: Alignment.center,
      child: HeroIcon(HeroIcons.camera, color: iconColor, size: iconSize),
    );
  }
}
