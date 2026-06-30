import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:heroicons/heroicons.dart';
import 'package:dotted_border/dotted_border.dart';

import '../ui_component_flutter.dart';

class AppFileUpload extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? localFilePath;
  final List<String>? allowedExtensions;
  final ValueChanged<String>? onFileSelected;
  final VoidCallback? onCancel;
  final String primaryButtonText;
  final String secondaryButtonText;

  final double? titleSize;
  final double? descriptionSize;

  final Color? backgroundColor;
  final Color? fileAreaColor;

  const AppFileUpload({
    super.key,
    this.title = 'Upload Files',
    this.subtitle = 'Upload your source files here',
    this.localFilePath,
    this.allowedExtensions,
    this.onFileSelected,
    this.onCancel,
    this.primaryButtonText = 'Pick File',
    this.secondaryButtonText = 'Cancel',
    this.titleSize,
    this.descriptionSize,
    this.backgroundColor,
    this.fileAreaColor,
  });

  @override
  State<AppFileUpload> createState() => _AppFileUploadState();
}

class _AppFileUploadState extends State<AppFileUpload> {
  Future<void> _pickFile() async {
    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: widget.allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: widget.allowedExtensions,
      );

      if (result != null && result.files.single.path != null) {
        if (widget.onFileSelected != null) {
          widget.onFileSelected!(result.files.single.path!);
        }
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  String _getFileName(String path) {
    return path.split('/').last.split('\\').last;
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
            onTap: _pickFile,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                color: uiTheme.borderColor,
                strokeWidth: 1.5,
                dashPattern: const [8, 4],
                radius: Radius.circular(size(12)),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(size(16)),
                constraints: BoxConstraints(minHeight: size(160)),
                decoration: BoxDecoration(
                  color:
                      widget.fileAreaColor ??
                      uiTheme.background.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(size(12)),
                ),
                child: widget.localFilePath != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeroIcon(
                            HeroIcons.documentText,
                            size: size(48),
                            color: uiTheme.primary,
                            style: HeroIconStyle.solid,
                          ),
                          SizedBox(height: size(12)),
                          Text(
                            _getFileName(widget.localFilePath!),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: uiTheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeroIcon(
                            HeroIcons.documentArrowUp,
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
                          if (widget.allowedExtensions != null) ...[
                            SizedBox(height: size(8)),
                            Text(
                              'Supported formats: ${widget.allowedExtensions!.join(", ")}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: size(10),
                                color: uiTheme.hintColor,
                              ),
                            ),
                          ],
                        ],
                      ),
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
                  onPressed: _pickFile,
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
