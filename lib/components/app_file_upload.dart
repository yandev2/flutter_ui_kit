import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:heroicons/heroicons.dart';
import 'package:dotted_border/dotted_border.dart';

import '../ui_component_flutter.dart';

CrossAxisAlignment _crossAxisFromTextAlign(TextAlign align) {
  switch (align) {
    case TextAlign.left:
    case TextAlign.start:
      return CrossAxisAlignment.start;
    case TextAlign.right:
    case TextAlign.end:
      return CrossAxisAlignment.end;
    default:
      return CrossAxisAlignment.center;
  }
}

class AppFileUpload extends StatefulWidget {
  final String title;
  final String subtitle;

  /// Path lokal file yang baru dipilih user.
  final String? localFilePath;

  /// URL file existing (mis. dari server saat edit dokumen).
  final String? initialFileUrl;

  final List<String>? allowedExtensions;
  final ValueChanged<String>? onFileSelected;
  final VoidCallback? onCancel;
  final String primaryButtonText;
  final String secondaryButtonText;

  final double? titleSize;
  final double? descriptionSize;
  final double? buttonHeight;
  final double? fileAreaMinHeight;
  final TextAlign headerAlignment;

  final Color? backgroundColor;
  final Color? fileAreaColor;

  const AppFileUpload({
    super.key,
    this.title = 'Upload Files',
    this.subtitle = 'Upload your source files here',
    this.localFilePath,
    this.initialFileUrl,
    this.allowedExtensions,
    this.onFileSelected,
    this.onCancel,
    this.primaryButtonText = 'Pick File',
    this.secondaryButtonText = 'Cancel',
    this.titleSize,
    this.descriptionSize,
    this.buttonHeight,
    this.fileAreaMinHeight,
    this.headerAlignment = TextAlign.center,
    this.backgroundColor,
    this.fileAreaColor,
  });

  @override
  State<AppFileUpload> createState() => _AppFileUploadState();
}

class _AppFileUploadState extends State<AppFileUpload> {
  bool get _hasInitialFileUrl =>
      widget.initialFileUrl != null &&
      widget.initialFileUrl!.trim().isNotEmpty;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: widget.allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: widget.allowedExtensions,
        // ignore: deprecated_member_use
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        widget.onFileSelected?.call(result.files.single.path!);
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  String _getDisplayName(String pathOrUrl) {
    final withoutQuery = pathOrUrl.split('?').first;
    return withoutQuery.split('/').last.split('\\').last;
  }

  Widget _buildFilePreview(
    ThemeData theme,
    UIComponentTheme uiTheme, {
    required String displayName,
  }) {
    return Column(
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
          displayName,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: uiTheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPreview(ThemeData theme, UIComponentTheme uiTheme) {
    if (widget.localFilePath != null) {
      return _buildFilePreview(
        theme,
        uiTheme,
        displayName: _getDisplayName(widget.localFilePath!),
      );
    }

    if (_hasInitialFileUrl) {
      return _buildFilePreview(
        theme,
        uiTheme,
        displayName: _getDisplayName(widget.initialFileUrl!),
      );
    }

    return Column(
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
          textAlign: widget.headerAlignment,
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
            textAlign: widget.headerAlignment,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: size(10),
              color: uiTheme.hintColor,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;
    final headerCrossAxis = _crossAxisFromTextAlign(widget.headerAlignment);

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
        crossAxisAlignment: headerCrossAxis,
        children: [
          Text(
            widget.title,
            textAlign: widget.headerAlignment,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: widget.titleSize,
              color: uiTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size(4)),
          Text(
            widget.subtitle,
            textAlign: widget.headerAlignment,
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
                constraints: BoxConstraints(
                  minHeight: size(widget.fileAreaMinHeight ?? 160),
                ),
                decoration: BoxDecoration(
                  color:
                      widget.fileAreaColor ??
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
                  height: widget.buttonHeight,
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
                  height: widget.buttonHeight,
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
