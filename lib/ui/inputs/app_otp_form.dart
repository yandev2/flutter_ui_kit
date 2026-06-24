import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';

class AppOtpForm extends StatefulWidget {
  final String? title;
  final String? description;
  final int codeLength;
  final String? value;
  final String? buttonText;
  final String? footerText;
  final String? footerActionText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final VoidCallback? onVerify;
  final VoidCallback? onFooterActionTap;
  final bool isLoading;
  final bool autofocus;
  final double? width;
  final EdgeInsetsGeometry? padding;

  final double? titleSize;
  final double? descriptionSize;
  final double? textSize;
  final double? footerTextSize;
  final Color? backgroundColor;
  final Color? fieldBackgroundColor;

  const AppOtpForm({
    super.key,
    this.title,
    this.description,
    this.codeLength = 4,
    this.value,
    this.buttonText,
    this.footerText,
    this.footerActionText,
    this.onChanged,
    this.onCompleted,
    this.onVerify,
    this.onFooterActionTap,
    this.isLoading = false,
    this.autofocus = false,
    this.width,
    this.padding,
    this.titleSize,
    this.descriptionSize,
    this.textSize,
    this.footerTextSize,
    this.backgroundColor,
    this.fieldBackgroundColor,
  }) : assert(codeLength > 0, 'codeLength must be greater than 0');

  @override
  State<AppOtpForm> createState() => _AppOtpFormState();
}

class _AppOtpFormState extends State<AppOtpForm> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  bool get _showButton =>
      widget.buttonText != null && widget.onVerify != null;

  bool get _showFooter =>
      widget.footerText != null || widget.footerActionText != null;

  @override
  void initState() {
    super.initState();
    _initFields();
    _syncValue(widget.value);
  }

  @override
  void didUpdateWidget(covariant AppOtpForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.codeLength != widget.codeLength) {
      _disposeFields();
      _initFields();
    }
    if (oldWidget.value != widget.value) {
      _syncValue(widget.value);
    }
  }

  @override
  void dispose() {
    _disposeFields();
    super.dispose();
  }

  void _initFields() {
    _controllers = List.generate(
      widget.codeLength,
      (_) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.codeLength,
      (index) => FocusNode(
        onKeyEvent: (node, event) {
          if (event is! KeyDownEvent ||
              event.logicalKey != LogicalKeyboardKey.backspace) {
            return KeyEventResult.ignored;
          }
          if (_controllers[index].text.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
            _controllers[index - 1].clear();
            _notifyChange();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
      ),
    );

    if (widget.autofocus && _focusNodes.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focusNodes.first.requestFocus();
      });
    }
  }

  void _disposeFields() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
  }

  void _syncValue(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    for (var i = 0; i < widget.codeLength; i++) {
      final char = i < digits.length ? digits[i] : '';
      if (_controllers[i].text != char) {
        _controllers[i].text = char;
      }
    }
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _notifyChange() {
    widget.onChanged?.call(_code);
    if (_code.length == widget.codeLength &&
        _controllers.every((c) => c.text.isNotEmpty)) {
      widget.onCompleted?.call(_code);
    }
  }

  void _handleInput(int index, String value) {
    if (widget.isLoading) return;

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 1) {
      for (var i = 0; i < widget.codeLength; i++) {
        _controllers[i].text = i < digits.length ? digits[i] : '';
      }
      final focusIndex = digits.length >= widget.codeLength
          ? widget.codeLength - 1
          : digits.length;
      _focusNodes[focusIndex].requestFocus();
      _notifyChange();
      return;
    }

    if (digits.length == 1) {
      _controllers[index].text = digits;
      if (index < widget.codeLength - 1) {
        _focusNodes[index + 1].requestFocus();
      }
      _notifyChange();
      return;
    }

    if (value.isEmpty) {
      _controllers[index].clear();
      _notifyChange();
    }
  }

  double _otpBoxSize(double availableWidth) {
    final gap = AppScale.w(widget.codeLength > 4 ? 8 : 12);
    final maxBoxSize = AppScale.w(56);
    final minBoxSize = AppScale.w(36);
    final rawSize =
        (availableWidth - gap * (widget.codeLength - 1)) / widget.codeLength;
    return rawSize.clamp(minBoxSize, maxBoxSize);
  }

  double _otpGap(int codeLength) => AppScale.w(codeLength > 4 ? 8 : 12);

  double _otpFontSize(double boxSize) =>
      widget.textSize ?? AppScale.sp(math.min(22, boxSize * 0.42));

  Widget _buildOtpField({
    required int index,
    required double boxSize,
    required double gap,
    required Color boxBg,
    required Color boxFocusedBorder,
    required Color boxIdleBorder,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        right: index < widget.codeLength - 1 ? gap : 0,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: boxBg,
          borderRadius: BorderRadius.circular(AppScale.r(12)),
          border: Border.all(
            color: _focusNodes[index].hasFocus
                ? boxFocusedBorder
                : boxIdleBorder,
            width: AppScale.w(1.5),
          ),
        ),
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          enabled: !widget.isLoading,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          cursorColor: AppColors.primary,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: TextStyle(
            fontSize: _otpFontSize(boxSize),
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            counterText: '',
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) => _handleInput(index, value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final boxBg = widget.fieldBackgroundColor ?? (isDark ? AppColors.neutral900 : AppColors.neutral100);
    final boxIdleBorder = isDark ? AppColors.border : Colors.transparent;
    final boxFocusedBorder = AppColors.primary;

    return Skeletonizer(
      enabled: widget.isLoading,
      child: Container(
        width: widget.width ?? AppScale.w(360),
        padding: widget.padding ??
            EdgeInsets.symmetric(
              horizontal: AppScale.w(24),
              vertical: AppScale.h(32),
            ),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? (isDark ? AppColors.surface : AppColors.white),
          borderRadius: BorderRadius.circular(AppScale.r(20)),
          border: isDark
              ? Border.all(color: AppColors.border, width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.title != null) ...[
              Skeleton.replace(
                replace: widget.isLoading,
                replacement: Bone.text(words: 3),
                child: Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: widget.titleSize ?? AppScale.sp(20),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: AppScale.h(12)),
            ],
            if (widget.description != null) ...[
              Skeleton.replace(
                replace: widget.isLoading,
                replacement: Bone.multiText(lines: 2),
                child: Text(
                  widget.description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: widget.descriptionSize ?? AppScale.sp(14),
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: AppScale.h(28)),
            ] else if (widget.title != null)
              SizedBox(height: AppScale.h(16)),
            Skeleton.replace(
              replace: widget.isLoading,
              replacement: LayoutBuilder(
                builder: (context, constraints) {
                  final boxSize = _otpBoxSize(constraints.maxWidth);
                  return Bone(
                    width: constraints.maxWidth,
                    height: boxSize,
                    borderRadius: BorderRadius.circular(AppScale.r(12)),
                  );
                },
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final boxSize = _otpBoxSize(constraints.maxWidth);
                  final gap = _otpGap(widget.codeLength);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.codeLength,
                      (index) => _buildOtpField(
                        index: index,
                        boxSize: boxSize,
                        gap: gap,
                        boxBg: boxBg,
                        boxFocusedBorder: boxFocusedBorder,
                        boxIdleBorder: boxIdleBorder,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_showButton) ...[
              SizedBox(height: AppScale.h(28)),
              Skeleton.leaf(
                child: AppButton(
                  text: widget.buttonText!,
                  onPressed: widget.isLoading ? null : widget.onVerify,
                  isFullWidth: true,
                  isLoading: widget.isLoading,
                ),
              ),
            ],
            if (_showFooter) ...[
              SizedBox(height: AppScale.h(20)),
              Skeleton.replace(
                replace: widget.isLoading,
                replacement: Bone.text(words: 4),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (widget.footerText != null)
                      Text(
                        widget.footerText!,
                        style: TextStyle(
                          fontSize: widget.footerTextSize ?? AppScale.sp(14),
                          color: AppColors.textSecondary,
                        ),
                      ),
                    if (widget.footerActionText != null)
                      GestureDetector(
                        onTap: widget.isLoading ? null : widget.onFooterActionTap,
                        child: Text(
                          widget.footerActionText!,
                          style: TextStyle(
                            fontSize: widget.footerTextSize ?? AppScale.sp(14),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
