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

    // Menghitung margin jika posisinya Top (mengakali SnackBar murni flutter)
    final EdgeInsetsGeometry margin = positionTop
        ? EdgeInsets.only(
            bottom: context.screenHeight - size(150),
            left: size(16),
            right: size(16),
          )
        : EdgeInsets.all(size(16));

    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      margin: margin,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: size(16), vertical: size(16)),
        decoration: BoxDecoration(
          color: uiTheme.surface,
          borderRadius: BorderRadius.circular(size(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: size(10),
              offset: Offset(0, size(4)),
            ),
          ],
        ),
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
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: size(4)),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: uiTheme.hintColor,
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
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Helper methods
  static void success(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.success,
      duration: duration,
      positionTop: positionTop,
    );
  }

  static void info(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,
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
    );
  }

  static void warning(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.warning,
      duration: duration,
      positionTop: positionTop,
    );
  }

  static void error(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    bool positionTop = false,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      type: AppSnackbarType.error,
      duration: duration,
      positionTop: positionTop,
    );
  }
}
