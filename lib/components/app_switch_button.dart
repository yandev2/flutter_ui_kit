import 'package:flutter/material.dart';
import '../theme/theme.dart';

enum AppSwitchControlPosition { start, end }

class AppSwitchTheme {
  const AppSwitchTheme({
    required this.trackWidth,
    required this.trackHeight,
    required this.thumbSize,
    required this.trackPadding,
    required this.gap,
    required this.titleDescGap,
    required this.titleStyle,
    required this.descriptionStyle,
    required this.errorStyle,
    required this.activeColor,
    required this.inactiveTrackColor,
    required this.inactiveThumbColor,
    required this.disabledOpacity,
    required this.animationDuration,
  });

  final double trackWidth;
  final double trackHeight;
  final double thumbSize;
  final double trackPadding;
  final double gap;
  final double titleDescGap;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final TextStyle errorStyle;
  final Color activeColor;
  final Color inactiveTrackColor;
  final Color inactiveThumbColor;
  final double disabledOpacity;
  final Duration animationDuration;

  static AppSwitchTheme of(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final uiTheme = context.uiTheme;

    return AppSwitchTheme(
      trackWidth: size(48),
      trackHeight: size(28),
      thumbSize: size(22),
      trackPadding: size(3),
      gap: size(12),
      titleDescGap: size(3),
      titleStyle: (textTheme.bodyLarge ?? const TextStyle()).copyWith(
        fontWeight: FontWeight.w600,
        color: uiTheme.onBackground,
        height: 1.3,
      ),
      descriptionStyle: (textTheme.bodySmall ?? const TextStyle()).copyWith(
        color: uiTheme.hintColor,
        height: 1.45,
      ),
      errorStyle: (textTheme.labelSmall ?? const TextStyle()).copyWith(
        color: uiTheme.error,
      ),
      activeColor: uiTheme.primary,
      inactiveTrackColor: uiTheme.hintColor.withValues(alpha: 0.25),
      inactiveThumbColor: uiTheme.surface,
      disabledOpacity: 0.45,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  AppSwitchTheme copyWith({
    double? trackWidth,
    double? trackHeight,
    double? thumbSize,
    double? trackPadding,
    double? gap,
    double? titleDescGap,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    TextStyle? errorStyle,
    Color? activeColor,
    Color? inactiveTrackColor,
    Color? inactiveThumbColor,
    double? disabledOpacity,
    Duration? animationDuration,
  }) {
    return AppSwitchTheme(
      trackWidth: trackWidth ?? this.trackWidth,
      trackHeight: trackHeight ?? this.trackHeight,
      thumbSize: thumbSize ?? this.thumbSize,
      trackPadding: trackPadding ?? this.trackPadding,
      gap: gap ?? this.gap,
      titleDescGap: titleDescGap ?? this.titleDescGap,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      activeColor: activeColor ?? this.activeColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      inactiveThumbColor: inactiveThumbColor ?? this.inactiveThumbColor,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}

class AppSwitchButton extends StatelessWidget {
  const AppSwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
    this.description,
    this.enabled = true,
    this.controlPosition = AppSwitchControlPosition.end,
    this.activeColor,
    this.errorText,
    this.style,
    this.leading,
    this.trailing,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? title;
  final String? description;
  final bool enabled;
  final AppSwitchControlPosition controlPosition;
  final Color? activeColor;
  final String? errorText;
  final AppSwitchTheme? style;
  final Widget? leading;
  final Widget? trailing;

  bool get _hasTitle => title != null && title!.isNotEmpty;
  bool get _hasDescription => description != null && description!.isNotEmpty;
  bool get _hasError => errorText != null && errorText!.isNotEmpty;
  bool get _isInteractive => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = style ?? AppSwitchTheme.of(context);
    final accent = activeColor ?? theme.activeColor;

    final control = _SwitchControl(
      theme: theme,
      accent: accent,
      value: value,
      enabled: _isInteractive,
      onChanged: _isInteractive ? (v) => onChanged!(v) : null,
    );

    final textBlock = (_hasTitle || _hasDescription)
        ? Expanded(
            child: GestureDetector(
              onTap: _isInteractive ? () => onChanged!(!value) : null,
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_hasTitle)
                    Text(
                      title!,
                      style: theme.titleStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (_hasDescription) ...[
                    if (_hasTitle) SizedBox(height: theme.titleDescGap),
                    Text(
                      description!,
                      style: theme.descriptionStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          )
        : null;

    return Opacity(
      opacity: enabled ? 1 : theme.disabledOpacity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            toggled: value,
            enabled: _isInteractive,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leading != null) ...[leading!, SizedBox(width: theme.gap)],
                if (controlPosition == AppSwitchControlPosition.start) ...[
                  control,
                  if (textBlock != null) SizedBox(width: theme.gap),
                ],
                ?textBlock,
                if (controlPosition == AppSwitchControlPosition.end) ...[
                  if (textBlock != null) SizedBox(width: theme.gap),
                  control,
                ],
                if (trailing != null) ...[
                  SizedBox(width: theme.gap),
                  trailing!,
                ],
              ],
            ),
          ),
          if (_hasError) ...[
            SizedBox(height: size(6)),
            Text(errorText!, style: theme.errorStyle),
          ],
        ],
      ),
    );
  }
}

class _SwitchControl extends StatelessWidget {
  const _SwitchControl({
    required this.theme,
    required this.accent,
    required this.value,
    required this.enabled,
    this.onChanged,
  });

  final AppSwitchTheme theme;
  final Color accent;
  final bool value;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      child: AnimatedContainer(
        duration: theme.animationDuration,
        curve: Curves.easeInOutCubic,
        width: theme.trackWidth,
        height: theme.trackHeight,
        decoration: BoxDecoration(
          color: value
              ? accent.withValues(alpha: 0.35)
              : theme.inactiveTrackColor,
          borderRadius: BorderRadius.circular(theme.trackHeight / 2),
        ),
        child: AnimatedAlign(
          duration: theme.animationDuration,
          curve: Curves.easeInOutCubic,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(theme.trackPadding),
            child: Container(
              width: theme.thumbSize,
              height: theme.thumbSize,
              decoration: BoxDecoration(
                color: value ? accent : theme.inactiveThumbColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: size(4),
                    offset: Offset(0, size(2)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
