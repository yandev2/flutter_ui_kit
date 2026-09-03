import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:heroicons/heroicons.dart';
import 'package:dotted_border/dotted_border.dart';

import '../ui_component_flutter.dart';

/// Tipe tampilan untuk [AppFileUpload].
enum AppFileUploadType {
  /// Tampilan card besar dengan dropzone dotted border (default).
  card,

  /// Tampilan ringkas menyerupai form text field.
  textField,
}

/// Alias untuk [AppFileUploadType].
typedef AppFileUploadVariant = AppFileUploadType;

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
  /// Tipe tampilan komponen ([AppFileUploadType.card] atau [AppFileUploadType.textField]).
  final AppFileUploadType type;

  final String? title;
  final String? subtitle;

  /// Teks hint saat file belum dipilih pada tipe [AppFileUploadType.textField].
  /// Default: `'Upload file'`.
  final String? hint;

  /// Path lokal file yang baru dipilih user.
  final String? localFilePath;

  /// URL file existing (mis. dari server saat edit dokumen).
  final String? initialFileUrl;

  final List<String>? allowedExtensions;
  final ValueChanged<String>? onFileSelected;
  final VoidCallback? onCancel;
  final String primaryButtonText;
  final String secondaryButtonText;

  /// Prefix icon khusus untuk tipe [AppFileUploadType.textField].
  /// Default: [HeroIcons.documentText].
  final HeroIcons? prefixIcon;

  /// Suffix widget kustom untuk tipe [AppFileUploadType.textField].
  final Widget? suffixWidget;

  /// Mode read only.
  final bool readOnly;

  /// Menampilkan indikator loading.
  final bool isLoading;

  final double? titleSize;
  final double? descriptionSize;
  final double? buttonHeight;
  final double? fileAreaMinHeight;
  final double? textSize;
  final double? hintSize;
  final TextAlign headerAlignment;

  final Color? backgroundColor;
  final Color? fileAreaColor;
  final Color? fillColor;
  final Color? borderColor;

  const AppFileUpload({
    super.key,
    this.type = AppFileUploadType.card,
    this.title,
    this.subtitle,
    this.hint,
    this.localFilePath,
    this.initialFileUrl,
    this.allowedExtensions,
    this.onFileSelected,
    this.onCancel,
    this.primaryButtonText = 'Pick File',
    this.secondaryButtonText = 'Cancel',
    this.prefixIcon,
    this.suffixWidget,
    this.readOnly = false,
    this.isLoading = false,
    this.titleSize,
    this.descriptionSize,
    this.buttonHeight,
    this.fileAreaMinHeight,
    this.textSize,
    this.hintSize,
    this.headerAlignment = TextAlign.center,
    this.backgroundColor,
    this.fileAreaColor,
    this.fillColor,
    this.borderColor,
  });

  @override
  State<AppFileUpload> createState() => _AppFileUploadState();
}

class _AppFileUploadState extends State<AppFileUpload> {
  bool get _hasInitialFileUrl =>
      widget.initialFileUrl != null &&
      widget.initialFileUrl!.trim().isNotEmpty;

  bool get _hasFile =>
      (widget.localFilePath != null &&
          widget.localFilePath!.trim().isNotEmpty) ||
      _hasInitialFileUrl;

  String? get _currentDisplayName {
    if (widget.localFilePath != null &&
        widget.localFilePath!.trim().isNotEmpty) {
      return _getDisplayName(widget.localFilePath!);
    }
    if (_hasInitialFileUrl) {
      return _getDisplayName(widget.initialFileUrl!);
    }
    return null;
  }

  Future<void> _pickFile() async {
    try {
      final dynamic result = await FilePicker.pickFiles(
        type: widget.allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: widget.allowedExtensions,
        // ignore: deprecated_member_use
        allowMultiple: false,
      );

      String? path;
      if (result is List<PlatformFile>) {
        path = result.firstOrNull?.path;
      } else if (result != null) {
        try {
          final dynamic files = (result as dynamic).files;
          if (files is List && files.isNotEmpty) {
            path = (files.first as dynamic).path as String?;
          }
        } catch (_) {}
      }

      if (path != null) {
        widget.onFileSelected?.call(path);
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

  Widget _buildTextFieldLayout(
    BuildContext context,
    ThemeData theme,
    UIComponentTheme uiTheme,
  ) {
    final hasFile = _hasFile;
    final displayName = _currentDisplayName;
    final verticalPadding = sizeHeight(12);
    final fieldFill =
        widget.fillColor ?? widget.backgroundColor ?? uiTheme.background;
    final fieldBorder = widget.borderColor ?? uiTheme.borderColor;
    final contentOpacity = widget.readOnly ? 0.5 : 1.0;
    final isInteractive = !widget.readOnly && !widget.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          Text(
            widget.title!,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: widget.titleSize ?? size(14),
              fontWeight: FontWeight.bold,
              color: uiTheme.onBackground,
            ),
          ),
          SizedBox(height: sizeHeight(8)),
        ],
        Opacity(
          opacity: contentOpacity,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: isInteractive ? _pickFile : null,
            child: Container(
              decoration: BoxDecoration(
                color: fieldFill,
                borderRadius: BorderRadius.circular(size(8)),
                border: Border.all(color: fieldBorder, width: size(1)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Prefix Icon (sama persis dengan style padding di AppTextField)
                  Padding(
                    padding: EdgeInsets.only(
                      left: size(16),
                      top: verticalPadding,
                      bottom: verticalPadding,
                      right: size(12),
                    ),
                    child: HeroIcon(
                      widget.prefixIcon ?? HeroIcons.documentText,
                      color: hasFile ? uiTheme.primary : uiTheme.hintColor,
                      size: size(20),
                    ),
                  ),

                  // Konten teks (Nama file yang dipilih atau Teks Hint)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: verticalPadding,
                        bottom: verticalPadding,
                      ),
                      child: Text(
                        hasFile ? displayName! : (widget.hint ?? 'Upload file'),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: hasFile
                              ? uiTheme.onBackground
                              : uiTheme.hintColor,
                          fontSize: (hasFile
                                  ? widget.textSize
                                  : widget.hintSize) ??
                              size(14),
                          fontWeight:
                              hasFile ? FontWeight.w500 : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // Suffix Area:
                  // 1. Custom suffixWidget
                  // 2. Loading indicator
                  // 3. Suffix icon cancel/clear saat file ada
                  // 4. Suffix icon upload saat file belum ada
                  if (widget.suffixWidget != null)
                    Padding(
                      padding: EdgeInsets.only(
                        left: size(12),
                        right: size(16),
                        top: verticalPadding,
                        bottom: verticalPadding,
                      ),
                      child: widget.suffixWidget!,
                    )
                  else if (widget.isLoading)
                    Padding(
                      padding: EdgeInsets.only(
                        left: size(12),
                        right: size(16),
                        top: verticalPadding,
                        bottom: verticalPadding,
                      ),
                      child: SizedBox(
                        width: size(16),
                        height: size(16),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: uiTheme.primary,
                        ),
                      ),
                    )
                  else if (hasFile)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: isInteractive ? widget.onCancel : null,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: size(12),
                          right: size(16),
                          top: verticalPadding,
                          bottom: verticalPadding,
                        ),
                        child: HeroIcon(
                          HeroIcons.xMark,
                          size: size(20),
                          color: uiTheme.hintColor,
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.only(
                        left: size(12),
                        right: size(16),
                        top: verticalPadding,
                        bottom: verticalPadding,
                      ),
                      child: HeroIcon(
                        HeroIcons.arrowUpTray,
                        size: size(20),
                        color: uiTheme.hintColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.subtitle != null && widget.subtitle!.isNotEmpty) ...[
          SizedBox(height: sizeHeight(6)),
          Text(
            widget.subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: widget.descriptionSize ?? size(12),
              color: uiTheme.hintColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCardLayout(
    BuildContext context,
    ThemeData theme,
    UIComponentTheme uiTheme,
  ) {
    final headerCrossAxis = _crossAxisFromTextAlign(widget.headerAlignment);
    final titleText = widget.title ?? 'Upload Files';
    final subtitleText = widget.subtitle ?? 'Upload your source files here';

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
            titleText,
            textAlign: widget.headerAlignment,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: widget.titleSize,
              color: uiTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size(4)),
          Text(
            subtitleText,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;

    if (widget.type == AppFileUploadType.textField) {
      return _buildTextFieldLayout(context, theme, uiTheme);
    }

    return _buildCardLayout(context, theme, uiTheme);
  }
}
