import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../theme/theme.dart';
import '../theme/app_scale.dart' as scale;
import 'app_image.dart';

enum AppDialogVariant { success, error, info, warning }

/// Menampilkan [AppDialog] via [showDialog].
Future<void> showAppDialog(
  BuildContext context, {
  AppDialogVariant variant = AppDialogVariant.info,
  required String title,
  String? description,
  double? titleSize,
  double? descriptionSize,
  String? textLeft,
  String? textRight,
  VoidCallback? onLeft,
  VoidCallback? onRight,
  Widget? content,
  String? imageUrl,
  double? imageWidth,
  double? imageHeight,
  BoxFit imageFit = BoxFit.contain,
  bool barrierDismissible = false,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return AppDialog(
        variant: variant,
        title: title,
        description: description,
        titleSize: titleSize,
        descriptionSize: descriptionSize,
        textLeft: textLeft,
        textRight: textRight,
        onLeft: onLeft,
        onRight: onRight,
        content: content,
        imageUrl: imageUrl,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        imageFit: imageFit,
      );
    },
  );
}

class AppDialog extends StatelessWidget {
  final AppDialogVariant variant;
  final String title;
  final String? description;

  /// Ukuran font title (nilai desain, diskalakan via `size()`). Default `16`.
  final double? titleSize;

  /// Ukuran font description (nilai desain, diskalakan via `size()`). Default `12`.
  final double? descriptionSize;
  final String? textLeft;
  final String? textRight;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;
  final Widget? content;
  final String? imageUrl;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit imageFit;

  const AppDialog({
    super.key,
    this.variant = AppDialogVariant.info,
    required this.title,
    this.description,
    this.titleSize,
    this.descriptionSize,
    this.textLeft,
    this.textRight,
    this.onLeft,
    this.onRight,
    this.content,
    this.imageUrl,
    this.imageWidth,
    this.imageHeight,
    this.imageFit = BoxFit.contain,
  });

  Color _rightButtonColor(BuildContext context) {
    switch (variant) {
      case AppDialogVariant.success:
        return context.uiTheme.success;
      case AppDialogVariant.error:
        return context.uiTheme.danger;
      case AppDialogVariant.warning:
        return context.uiTheme.warning;
      case AppDialogVariant.info:
        return context.uiTheme.primary;
    }
  }

  ({HeroIcons icon, Color color}) _variantIcon(BuildContext context) {
    final uiTheme = context.uiTheme;
    switch (variant) {
      case AppDialogVariant.success:
        return (icon: HeroIcons.checkCircle, color: uiTheme.success);
      case AppDialogVariant.error:
        return (icon: HeroIcons.exclamationCircle, color: uiTheme.error);
      case AppDialogVariant.warning:
        return (icon: HeroIcons.exclamationTriangle, color: uiTheme.warning);
      case AppDialogVariant.info:
        return (icon: HeroIcons.informationCircle, color: uiTheme.primary);
    }
  }

  /// Helper untuk menampilkan dialog secara statis.
  static Future<void> show(
    BuildContext context, {
    AppDialogVariant variant = AppDialogVariant.info,
    required String title,
    String? description,
    double? titleSize,
    double? descriptionSize,
    String? textLeft,
    String? textRight,
    VoidCallback? onLeft,
    VoidCallback? onRight,
    Widget? content,
    String? imageUrl,
    double? imageWidth,
    double? imageHeight,
    BoxFit imageFit = BoxFit.contain,
    bool barrierDismissible = false,
  }) {
    return showAppDialog(
      context,
      variant: variant,
      title: title,
      description: description,
      titleSize: titleSize,
      descriptionSize: descriptionSize,
      textLeft: textLeft,
      textRight: textRight,
      onLeft: onLeft,
      onRight: onRight,
      content: content,
      imageUrl: imageUrl,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      imageFit: imageFit,
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    final secondaryBtnBg = Theme.of(context).brightness == Brightness.dark
        ? context.uiTheme.surface
        : context.uiTheme.background;
    final secondaryBtnText = context.uiTheme.onSurface;
    final variantIcon = _variantIcon(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scale.size(16)),
      ),
      backgroundColor: context.uiTheme.surface,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: scale.size(24)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: EdgeInsets.all(scale.size(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null) ...[
                Center(
                  child: AppImage(
                    imageUrl: imageUrl!,
                    width: imageWidth != null ? scale.size(imageWidth!) : null,
                    height: imageHeight != null
                        ? scale.sizeHeight(imageHeight!)
                        : scale.sizeHeight(140),
                    fit: imageFit,
                  ),
                ),
                SizedBox(height: scale.sizeHeight(20)),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeroIcon(
                    variantIcon.icon,
                    size: scale.size(22),
                    color: variantIcon.color,
                    style: HeroIconStyle.outline,
                  ),
                  SizedBox(width: scale.size(8)),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: scale.size(titleSize ?? 16),
                        fontWeight: FontWeight.bold,
                        color: context.uiTheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              if (description != null) ...[
                SizedBox(height: scale.sizeHeight(8)),
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: scale.size(descriptionSize ?? 12),
                    color: context.uiTheme.onSurface.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                ),
              ],
              if (content != null) ...[
                SizedBox(height: scale.sizeHeight(16)),
                content!,
              ],
              SizedBox(height: scale.sizeHeight(20)),
              Row(
                children: [
                  if (textLeft != null) ...[
                    Expanded(
                      child: TextButton(
                        onPressed: onLeft ?? () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: scale.sizeHeight(10),
                          ),
                          backgroundColor: secondaryBtnBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(scale.size(8)),
                          ),
                        ),
                        child: Text(
                          textLeft!,
                          style: TextStyle(
                            color: secondaryBtnText,
                            fontWeight: FontWeight.w600,
                            fontSize: scale.size(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (textLeft != null && textRight != null)
                    SizedBox(width: scale.size(12)),
                  if (textRight != null) ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed:
                            onRight ?? () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: scale.sizeHeight(10),
                          ),
                          backgroundColor: _rightButtonColor(context),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(scale.size(8)),
                          ),
                        ),
                        child: Text(
                          textRight!,
                          style: TextStyle(
                            color: context.uiTheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: scale.size(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
