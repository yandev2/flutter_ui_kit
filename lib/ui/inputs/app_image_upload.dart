import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dotted_border/dotted_border.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';
import 'package:flutter_ui_kit/ui/dialogs/app_dialog.dart';

class AppImageUpload extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? localImagePath;
  final bool sourceCamera;
  final bool sourceGallery;
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

    AppDialog.show(
      title: 'Select Image Source',
      description: 'Choose where you want to pick the image from:',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: HeroIcon(HeroIcons.camera, color: AppColors.primary),
            title: Text('Camera', style: TextStyle(color: AppColors.textPrimary)),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: HeroIcon(HeroIcons.photo, color: AppColors.primary),
            title: Text('Gallery', style: TextStyle(color: AppColors.textPrimary)),
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppScale.w(24)),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? (isDark ? AppColors.surface : AppColors.white),
        borderRadius: BorderRadius.circular(AppScale.r(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: widget.titleSize ?? AppScale.sp(16),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppScale.h(4)),
          Text(
            widget.subtitle,
            style: TextStyle(
              fontSize: widget.descriptionSize ?? AppScale.sp(12),
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppScale.h(24)),
          GestureDetector(
            onTap: _showImageSourceBottomSheet,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                color: AppColors.neutral300,
                strokeWidth: 1.5,
                dashPattern: const [8, 4],
                radius: Radius.circular(AppScale.r(12)),
              ),
              child: Container(
                width: double.infinity,
                height: widget.localImagePath == null ? AppScale.h(160) : null,
                constraints: widget.localImagePath != null 
                    ? BoxConstraints(
                        maxHeight: AppScale.h(360),
                        minHeight: AppScale.h(160),
                      )
                    : null,
                decoration: BoxDecoration(
                  color: widget.imageAreaColor ?? (isDark 
                      ? AppColors.white.withValues(alpha: 0.02)
                      : AppColors.neutral100.withValues(alpha: 0.5)),
                  borderRadius: BorderRadius.circular(AppScale.r(12)),
                ),
                child: widget.localImagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppScale.r(12)),
                        child: kIsWeb
                            ? Image.network(
                                widget.localImagePath!,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(widget.localImagePath!),
                                fit: BoxFit.cover,
                              ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeroIcon(
                            HeroIcons.photo,
                            size: AppScale.w(40),
                            color: AppColors.neutral400,
                            style: HeroIconStyle.outline,
                          ),
                          SizedBox(height: AppScale.h(12)),
                          RichText(
                            text: TextSpan(
                              text: 'Drag Files here or ',
                              style: TextStyle(
                                fontSize: AppScale.sp(12),
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Browse',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          SizedBox(height: AppScale.h(24)),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: widget.primaryButtonText,
                  onPressed: _showImageSourceBottomSheet,
                  isFullWidth: true,
                ),
              ),
              SizedBox(width: AppScale.w(12)),
              Expanded(
                child: AppButton(
                  text: widget.secondaryButtonText,
                  variant: AppButtonVariant.outline,
                  onPressed: widget.onCancel ?? () {},
                  isFullWidth: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
