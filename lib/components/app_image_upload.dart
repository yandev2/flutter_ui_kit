import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:heroicons/heroicons.dart';
import 'package:dotted_border/dotted_border.dart';

import '../ui_component_flutter.dart';
import 'utils/offline_image.dart';

class AppImageUpload extends StatefulWidget {
  final String title;
  final String subtitle;

  /// Path lokal gambar yang baru dipilih user.
  /// Hanya set dari callback [onImageSelected] — jangan set ke [initialImageUrl].
  final String? localImagePath;

  /// URL foto existing (mis. dari server saat edit profile).
  /// Hanya untuk preview; tidak pernah dikembalikan lewat [onImageSelected].
  final String? initialImageUrl;

  final bool sourceCamera;
  final bool sourceGallery;

  /// Dipanggil hanya saat user memilih gambar baru dari kamera/galeri.
  /// [path] selalu berupa path lokal — tidak pernah URL [initialImageUrl].
  final ValueChanged<String>? onImageSelected;
  final VoidCallback? onCancel;
  final String primaryButtonText;
  final String secondaryButtonText;

  final double? titleSize;
  final double? descriptionSize;

  final Color? backgroundColor;
  final Color? imageAreaColor;

  const AppImageUpload({
    super.key,
    this.title = 'Upload Files',
    this.subtitle = 'Upload your source files here',
    this.localImagePath,
    this.initialImageUrl,
    this.sourceCamera = true,
    this.sourceGallery = true,
    this.onImageSelected,
    this.onCancel,
    this.primaryButtonText = 'Pick Image',
    this.secondaryButtonText = 'Cancel',
    this.titleSize,
    this.descriptionSize,
    this.backgroundColor,
    this.imageAreaColor,
  });

  @override
  State<AppImageUpload> createState() => _AppImageUploadState();
}

class _AppImageUploadState extends State<AppImageUpload> {
  final ImagePicker _picker = ImagePicker();

  bool get _hasInitialImageUrl =>
      widget.initialImageUrl != null &&
      widget.initialImageUrl!.trim().isNotEmpty;

  bool get _hasPreview =>
      widget.localImagePath != null || _hasInitialImageUrl;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null && widget.onImageSelected != null) {
        widget.onImageSelected!(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showImageSourceBottomSheet() {
    if (!widget.sourceCamera && !widget.sourceGallery) return;

    if (widget.sourceCamera && !widget.sourceGallery) {
      _pickImage(ImageSource.camera);
      return;
    }

    if (!widget.sourceCamera && widget.sourceGallery) {
      _pickImage(ImageSource.gallery);
      return;
    }

    final uiTheme = context.uiTheme;

    AppDialog.show(
      context,
      variant: AppDialogVariant.info,
      title: 'Select Image Source',
      description: 'Choose where you want to pick the image from:',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: HeroIcon(HeroIcons.camera, color: uiTheme.primary),
            title: Text(
              'Camera',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: uiTheme.onSurface),
            ),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: HeroIcon(HeroIcons.photo, color: uiTheme.primary),
            title: Text(
              'Gallery',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: uiTheme.onSurface),
            ),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
      textLeft: 'Cancel',
      onLeft: () => Navigator.pop(context),
    );
  }

  Widget _buildPreview(ThemeData theme, UIComponentTheme uiTheme) {
    if (widget.localImagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size(12)),
        child: buildPathImage(
          imagePath: widget.localImagePath!,
          fit: BoxFit.cover,
        ),
      );
    }

    if (_hasInitialImageUrl) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size(12)),
        child: AppImage(
          imageUrl: widget.initialImageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          borderRadius: BorderRadius.circular(size(12)),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HeroIcon(
          HeroIcons.photo,
          size: size(40),
          color: uiTheme.borderColor,
          style: HeroIconStyle.outline,
        ),
        SizedBox(height: size(12)),
        RichText(
          text: TextSpan(
            text: 'Drag Files here or ',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: size(12),
              color: uiTheme.hintColor,
            ),
            children: [
              TextSpan(
                text: 'Browse',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: size(12),
                  color: uiTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size(24)),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? uiTheme.surface,
        borderRadius: BorderRadius.circular(size(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: size(10),
            offset: Offset(0, size(4)),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: widget.titleSize,
              color: uiTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size(4)),
          Text(
            widget.subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: widget.descriptionSize ?? size(14),
              color: uiTheme.hintColor,
            ),
          ),
          SizedBox(height: size(24)),
          GestureDetector(
            onTap: _showImageSourceBottomSheet,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                color: uiTheme.borderColor,
                strokeWidth: 1.5,
                dashPattern: const [8, 4],
                radius: Radius.circular(size(12)),
              ),
              child: Container(
                width: double.infinity,
                height: _hasPreview ? null : size(160),
                constraints: _hasPreview
                    ? BoxConstraints(maxHeight: size(360), minHeight: size(160))
                    : null,
                decoration: BoxDecoration(
                  color:
                      widget.imageAreaColor ??
                      uiTheme.background.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(size(12)),
                ),
                child: _buildPreview(theme, uiTheme),
              ),
            ),
          ),
          SizedBox(height: size(24)),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  size: AppButtonSize.small,
                  textSize: size(12),
                  text: widget.primaryButtonText,
                  onPressed: _showImageSourceBottomSheet,
                  isMax: true,
                ),
              ),
              SizedBox(width: size(12)),
              Expanded(
                child: AppButton(
                  text: widget.secondaryButtonText,
                  size: AppButtonSize.small,
                  textSize: size(12),
                  textColor: uiTheme.onSurface,
                  variant: AppButtonVariant.outline,
                  onPressed: widget.onCancel ?? () {},
                  isMax: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
