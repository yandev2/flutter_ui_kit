import 'package:flutter/material.dart';
import '../ui_component_flutter.dart';
import '../theme/app_scale.dart' as scale;

enum AppDialogVariant { success, error, info, warning }

class AppDialog extends StatelessWidget {
  final AppDialogVariant variant;
  final String title;
  final String description;
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
    required this.description,
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

  /// Helper untuk menampilkan dialog secara statis
  static void show(
    BuildContext context, {
    AppDialogVariant variant = AppDialogVariant.info,
    required String title,
    required String description,
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
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AppDialog(
          variant: variant,
          title: title,
          description: description,
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

  @override
  Widget build(BuildContext context) {
    // Dynamic color for secondary button based on theme
    final Color secondaryBtnBg = Theme.of(context).brightness == Brightness.dark
        ? context.uiTheme.surface
        : context.uiTheme.background;
    final Color secondaryBtnText = context.uiTheme.onSurface;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scale.size(16)),
      ),
      backgroundColor: context.uiTheme.surface,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: scale.size(24)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
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
              Text(
                title,
                style: TextStyle(
                  fontSize: scale.size(20),
                  fontWeight: FontWeight.bold,
                  color: context.uiTheme.onSurface,
                ),
              ),
              SizedBox(height: scale.sizeHeight(12)),
              Text(
                description,
                style: TextStyle(
                  fontSize: scale.size(14),
                  color: context.uiTheme.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
              if (content != null) ...[
                SizedBox(height: scale.sizeHeight(20)),
                content!,
              ],
              SizedBox(height: scale.sizeHeight(24)),
              Row(
                children: [
                  if (textLeft != null) ...[
                    Expanded(
                      child: TextButton(
                        onPressed: onLeft ?? () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: scale.sizeHeight(15),
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
                            fontSize: scale.size(14),
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
                        onPressed: onRight,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: scale.sizeHeight(15),
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
                            fontSize: scale.size(14),
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
