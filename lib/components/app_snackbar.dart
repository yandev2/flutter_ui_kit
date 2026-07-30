import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../ui_component_flutter.dart';

enum AppSnackbarType { normal, success, error, warning }

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? icon,
    AppSnackbarType type = AppSnackbarType.normal,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,

    /// Jarak dari tepi layar (nilai desain, diskalakan via `size()`).
    /// Jika [positionTop] true → offset dari atas (+ safe area top).
    /// Jika [positionTop] false → offset dari bawah (+ safe area bottom).
    /// Default: `150` untuk top, `16` untuk bottom.
    double? offset,

    /// Ukuran font title (nilai desain, diskalakan via `size()`).
    double? titleSize,

    /// Ukuran font subtitle/deskripsi (nilai desain, diskalakan via `size()`).
    double? subtitleSize,

    /// Ukuran font action label (nilai desain, diskalakan via `size()`).
    double? actionLabelSize,
  }) {
    final uiTheme = context.uiTheme;
    final theme = Theme.of(context);

    Color? iconColor;
    Widget? defaultIcon;

    switch (type) {
      case AppSnackbarType.success:
        iconColor = uiTheme.success;
        defaultIcon = HeroIcon(
          HeroIcons.checkCircle,
          color: iconColor,
          style: HeroIconStyle.outline,
        );
        break;
      case AppSnackbarType.error:
        iconColor = uiTheme.error;
        defaultIcon = HeroIcon(
          HeroIcons.exclamationCircle,
          color: iconColor,
          style: HeroIconStyle.outline,
        );
        break;
      case AppSnackbarType.warning:
        iconColor = uiTheme.warning;
        defaultIcon = HeroIcon(
          HeroIcons.exclamationTriangle,
          color: iconColor,
          style: HeroIconStyle.outline,
        );
        break;
      case AppSnackbarType.normal:
        break;
    }

    final Widget finalIcon = icon ?? defaultIcon ?? const SizedBox.shrink();
    final bool hasIcon = finalIcon is! SizedBox;

    final resolvedOffset = offset ?? (positionTop ? 150.0 : 16.0);
    final horizontal = size(16);
    final padding = MediaQuery.paddingOf(context);

    final EdgeInsetsGeometry margin = positionTop
        ? EdgeInsets.only(
            top: padding.top + size(resolvedOffset),
            left: horizontal,
            right: horizontal,
          )
        : EdgeInsets.only(
            bottom: padding.bottom + size(resolvedOffset),
            left: horizontal,
            right: horizontal,
          );

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      margin: margin,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      content: Material(
        color: uiTheme.surface,
        elevation: isDark ? 8 : 6,
        shadowColor: uiTheme.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size(12)),
          side: BorderSide(color: uiTheme.borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size(16), vertical: size(16)),
          child: Row(
            crossAxisAlignment: subtitle != null
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              if (hasIcon) ...[finalIcon, SizedBox(width: size(12))],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: uiTheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: titleSize != null ? size(titleSize) : null,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: size(4)),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: uiTheme.hintColor,
                          fontSize:
                              subtitleSize != null ? size(subtitleSize) : null,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (actionLabel != null) ...[
                SizedBox(width: size(12)),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (onAction != null) onAction();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size(4)),
                    child: Text(
                      actionLabel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: uiTheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: actionLabelSize != null
                            ? size(actionLabelSize)
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void success(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,
    double? offset,
    double? titleSize,
    double? subtitleSize,
    double? actionLabelSize,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.success,
      duration: duration,
      positionTop: positionTop,
      offset: offset,
      titleSize: titleSize,
      subtitleSize: subtitleSize,
      actionLabelSize: actionLabelSize,
    );
  }

  static void info(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,
    double? offset,
    double? titleSize,
    double? subtitleSize,
    double? actionLabelSize,
  }) {
    final uiTheme = context.uiTheme;
    show(
      context,
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.normal,
      icon: HeroIcon(
        HeroIcons.informationCircle,
        color: uiTheme.info,
        style: HeroIconStyle.outline,
      ),
      duration: duration,
      positionTop: positionTop,
      offset: offset,
      titleSize: titleSize,
      subtitleSize: subtitleSize,
      actionLabelSize: actionLabelSize,
    );
  }

  static void warning(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,
    double? offset,
    double? titleSize,
    double? subtitleSize,
    double? actionLabelSize,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.warning,
      duration: duration,
      positionTop: positionTop,
      offset: offset,
      titleSize: titleSize,
      subtitleSize: subtitleSize,
      actionLabelSize: actionLabelSize,
    );
  }

  static void error(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,
    double? offset,
    double? titleSize,
    double? subtitleSize,
    double? actionLabelSize,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.error,
      duration: duration,
      positionTop: positionTop,
      offset: offset,
      titleSize: titleSize,
      subtitleSize: subtitleSize,
      actionLabelSize: actionLabelSize,
    );
  }
}
