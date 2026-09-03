# Graph Report - flutter_ui_kit  (2026-09-04)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 1698 nodes · 2240 edges · 80 communities (73 shown, 7 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 18 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `fdacd46c`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Win32Window
- app_timeline.dart
- app_progress_circle.dart
- ui_component_theme.dart
- List
- app_time_picker.dart
- app_scale.dart
- app_text_field.dart
- app_password_field.dart
- app_file_upload.dart
- app_year_picker.dart
- app_otp_form.dart
- ui_component_flutter.dart
- app_date_picker.dart
- app_colors.dart
- app_typography.dart
- app_dropdown.dart
- GeneratedPluginRegistrant.swift
- app_month_picker.dart
- main.dart
- date_extension.dart
- app_switch_button.dart
- package:heroicons/heroicons.dart
- app_main_appbar.dart
- app_segmented_switch.dart
- app_image_upload.dart
- my_application.cc
- app_button.dart
- app_bottom_navigation.dart
- app_dialog.dart
- animated_widget_extension.dart
- package:flutter/material.dart
- string_extension.dart
- widget_extension.dart
- app_currency_field.dart
- app_dashboard_appbar.dart
- offline_image_io.dart
- State
- app_radio.dart
- package:flutter/services.dart
- app_image.dart
- StatelessWidget
- currency_formatter_demo_page.dart
- bool get
- app_image_viewer_dialog.dart
- wWinMain
- currency_extension.dart
- currency_extension_demo_page.dart
- num_extension_demo_page.dart
- manifest.json
- ValueChanged
- Color
- app_month_picker_demo_page.dart
- app_switch_button_demo_page.dart
- app_year_picker_demo_page.dart
- string_extension_demo_page.dart
- app_detail_appbar.dart
- ../ui_component_flutter.dart
- app_timeline_demo_page.dart
- currency_input_formatter.dart
- double?
- widget_extension_demo_page.dart
- app_dashboard_appbar_demo_page.dart
- app_image_upload_demo_page.dart
- app_otp_demo_page.dart
- app_progress_bar_demo_page.dart
- app_progress_circle_demo_page.dart
- CustomPainter
- MainActivity.kt
- _AppProgressCircleState
- _AppbarDelegate
- AppMainAppbar
- _TimelineGlowIndicatorState
- _VerticalTimelineLayout
- offline_image.dart
- String

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 24 edges
2. `MessageHandler` - 12 edges
3. `FlutterWindow` - 10 edges
4. `Create` - 10 edges
5. `WndProc` - 10 edges
6. `MessageHandler` - 9 edges
7. `WindowClassRegistrar` - 7 edges
8. `_MyApplication` - 7 edges
9. `OnCreate` - 7 edges
10. `Destroy` - 7 edges

## Surprising Connections (you probably didn't know these)
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  example/windows/runner/win32_window.cpp → example/windows/runner/win32_window.h
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  example/windows/runner/main.cpp → example/windows/runner/utils.cpp
- `Create` --calls--> `Scale()`  [EXTRACTED]
  example/windows/runner/win32_window.h → example/windows/runner/win32_window.cpp
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  example/windows/runner/flutter_window.h → example/windows/flutter/generated_plugin_registrant.cc
- `main()` --calls--> `my_application_new()`  [INFERRED]
  example/linux/runner/main.cc → example/linux/runner/my_application.cc

## Import Cycles
- None detected.

## Communities (80 total, 7 thin omitted)

### Community 0 - "Win32Window"
Cohesion: 0.05
Nodes (57): RegisterPlugins(), DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM, FlutterWindow (+49 more)

### Community 1 - "app_timeline.dart"
Cohesion: 0.04
Nodes (55): activeColor, AppTimelineNode, build, _buildHorizontalNode, _buildIndicator, _buildLineBar, _buildNodeContent, centers (+47 more)

### Community 2 - "app_progress_circle.dart"
Cohesion: 0.04
Nodes (53): Curve, animateOnAppear, _animateTo, animationCurve, animationDuration, build, _buildProgressAnimation, color (+45 more)

### Community 3 - "ui_component_theme.dart"
Cohesion: 0.04
Nodes (45): app_colors.dart, app_field_metrics.dart, app_spacing.dart, app_typography.dart, AppTheme, _buildDarkTheme, _buildLightTheme, _darkColorScheme (+37 more)

### Community 4 - "List"
Cohesion: 0.05
Nodes (42): class, AppBottomNavigationDemoPage, _AppBottomNavigationDemoPageState, build, createState, _currentIndex, _navItems, _selectedVariant (+34 more)

### Community 5 - "app_time_picker.dart"
Cohesion: 0.05
Nodes (44): AppTimePickerDemoPage, _AppTimePickerDemoPageState, build, _buildSectionTitle, createState, _selectedTime1, _selectedTime2, _selectedTime3 (+36 more)

### Community 6 - "app_scale.dart"
Cohesion: 0.04
Nodes (44): AppScaleConfig get, BuildContext, InheritedWidget, ContextExtension, adaptive, _applyCap, AppScale, AppScaleConfig (+36 more)

### Community 7 - "app_text_field.dart"
Cohesion: 0.05
Nodes (44): FocusNode, AppTextField, _AppTextFieldState, autofillHints, build, controller, createState, _currentText (+36 more)

### Community 8 - "app_password_field.dart"
Cohesion: 0.05
Nodes (43): HeroIcons?, AppPasswordField, _AppPasswordFieldState, autofillHints, build, controller, createState, errorSize (+35 more)

### Community 9 - "app_file_upload.dart"
Cohesion: 0.05
Nodes (44): allowedExtensions, AppFileUpload, _AppFileUploadState, AppFileUploadType, AppFileUploadVariant, backgroundColor, borderColor, build (+36 more)

### Community 10 - "app_year_picker.dart"
Cohesion: 0.05
Nodes (42): AppFileUploadDemoPage, _AppFileUploadDemoPageState, build, _buildSectionTitle, createState, _selectedFilePath, _selectedPdfPath, _textFieldDocPath (+34 more)

### Community 11 - "app_otp_form.dart"
Cohesion: 0.05
Nodes (43): AppOtpForm, _AppOtpFormState, autofocus, backgroundColor, build, _buildOtpField, buttonText, _code (+35 more)

### Community 12 - "ui_component_flutter.dart"
Cohesion: 0.05
Nodes (40): components/app_bottom_navigation.dart, components/app_button.dart, components/app_currency_field.dart, components/app_dashboard_appbar.dart, components/app_date_picker.dart, components/app_detail_appbar.dart, components/app_dialog.dart, components/app_dropdown.dart (+32 more)

### Community 13 - "app_date_picker.dart"
Cohesion: 0.05
Nodes (40): build, _canConfirm, _canGoNextMonth, _canGoPrevMonth, confirmTextColor, createState, currentMonth, d (+32 more)

### Community 14 - "app_colors.dart"
Cohesion: 0.05
Nodes (40): AppColors, backgroundDark, backgroundLight, borderDark, borderLight, cardDark, cardLight, dangerDark (+32 more)

### Community 15 - "app_typography.dart"
Cohesion: 0.05
Nodes (36): app_scale.dart, appFieldHorizontalPadding, appFieldMinHeight, appFieldVerticalPadding, AppRadius, AppSpacing, circular, lg (+28 more)

### Community 16 - "app_dropdown.dart"
Cohesion: 0.05
Nodes (38): AppDropdown, _AppDropdownState, build, _buildMultiTriggerContent, _buildSingleTriggerContent, _buildTrailingIcons, _clearAllSelected, createState (+30 more)

### Community 17 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.07
Nodes (25): Any, Cocoa, AppDelegate, Bool, RunnerTests, RegisterGeneratedPlugins(), AppDelegate, Bool (+17 more)

### Community 18 - "app_month_picker.dart"
Cohesion: 0.06
Nodes (36): AppMonthPicker, _AppMonthPickerState, build, confirmTextColor, _controller, createState, dispose, endMonth (+28 more)

### Community 19 - "main.dart"
Cohesion: 0.06
Nodes (35): animation_demo_page.dart, app_bottom_navigation_demo_page.dart, app_button_demo_page.dart, app_dashboard_appbar_demo_page.dart, app_date_picker_demo_page.dart, app_detail_appbar_demo_page.dart, app_dialog_demo_page.dart, app_dropdown_demo_page.dart (+27 more)

### Community 20 - "date_extension.dart"
Cohesion: 0.06
Nodes (33): DateTime, AppDatePickerDemoPage, _AppDatePickerDemoPageState, build, _buildSectionTitle, createState, _selectedDate1, _selectedDate2 (+25 more)

### Community 21 - "app_switch_button.dart"
Cohesion: 0.06
Nodes (35): accent, activeColor, animationDuration, AppSwitchControlPosition, AppSwitchTheme, build, controlPosition, copyWith (+27 more)

### Community 22 - "package:heroicons/heroicons.dart"
Cohesion: 0.08
Nodes (27): dart:ui, build, _buildTypographyItem, TypographyDemoPage, main, AppGlassyVariant, _clampAlpha, _getBlurFromVariant (+19 more)

### Community 23 - "app_main_appbar.dart"
Cohesion: 0.06
Nodes (32): actions, appBarHeight, backgroundColor, borderRadius, _bottomAreaHeight, _bottomOnlyExtent, build, createState (+24 more)

### Community 24 - "app_segmented_switch.dart"
Cohesion: 0.07
Nodes (29): BorderRadiusGeometry?, GlobalKey, activeColor, activeTextColor, AppSegmentedSwitch, _AppSegmentedSwitchState, backgroundColor, borderRadius (+21 more)

### Community 25 - "app_image_upload.dart"
Cohesion: 0.07
Nodes (27): ImagePicker, AppImageUpload, _AppImageUploadState, backgroundColor, build, _buildPreview, createState, descriptionSize (+19 more)

### Community 26 - "my_application.cc"
Cohesion: 0.09
Nodes (22): fl_register_plugins(), main(), first_frame_cb(), my_application_activate(), my_application_class_init(), my_application_dispose(), my_application_init(), my_application_local_command_line() (+14 more)

### Community 27 - "app_button.dart"
Cohesion: 0.07
Nodes (26): IconData?, AppButtonShape, AppButtonSize, AppButtonVariant, _backgroundColor, _baseColor, build, _buildContent (+18 more)

### Community 28 - "app_bottom_navigation.dart"
Cohesion: 0.08
Nodes (25): EdgeInsetsGeometry?, AppBottomNavItem, backgroundColor, build, _buildIcon, _buildItemContent, _buildLabel, currentIndex (+17 more)

### Community 29 - "app_dialog.dart"
Cohesion: 0.08
Nodes (23): app_image.dart, double? imageHeight,
  BoxFit, AppDialogVariant, barrierDismissible, build, content, description, descriptionSize (+15 more)

### Community 30 - "animated_widget_extension.dart"
Cohesion: 0.09
Nodes (22): Animation, AnimationController, Duration?, animated, _AnimatedMotionWrapper, _AnimatedMotionWrapperState, AnimatedWidgetExtension, _animation (+14 more)

### Community 31 - "package:flutter/material.dart"
Cohesion: 0.11
Nodes (16): build, AppButtonDemoPage, build, _buildSectionTitle, AppDetailAppbarDemoPage, build, AppDialogDemoPage, build (+8 more)

### Community 32 - "string_extension.dart"
Cohesion: 0.09
Nodes (21): date_extension.dart, capitalize, removeWhitespace, reverse, StringCarbonDateExtension, StringFormatExtension, toAlphaNumericOnly, toCamelCase (+13 more)

### Community 33 - "widget_extension.dart"
Cohesion: 0.09
Nodes (21): align, backgroundColor, center, clipOval, clipRRect, constrained, expanded, flexible (+13 more)

### Community 34 - "app_currency_field.dart"
Cohesion: 0.10
Nodes (20): Iterable, AppCurrencyField, autofillHints, build, controller, currencyType, decimalDigits, errorSize (+12 more)

### Community 35 - "app_dashboard_appbar.dart"
Cohesion: 0.11
Nodes (18): _avatarDiameter, _avatarIconSize, avatarSize, avatarUrl, build, _buildActionButton, _buildAvatar, isDarkMode (+10 more)

### Community 36 - "offline_image_io.dart"
Cohesion: 0.12
Nodes (15): dart:io, buildOfflineImage, buildPathImage, file, fit, buildOfflineImage, buildPathImage, fit (+7 more)

### Community 37 - "State"
Cohesion: 0.15
Nodes (15): AppSnackbarDemoPage, _AppSnackbarDemoPageState, build, createState, AppTextFieldDemoPage, _AppTextFieldDemoPageState, build, _buildSectionTitle (+7 more)

### Community 38 - "app_radio.dart"
Cohesion: 0.12
Nodes (16): activeColor, AppRadio, AppRadioVariant, backgroundColor, build, description, descriptionSize, dotColor (+8 more)

### Community 39 - "package:flutter/services.dart"
Cohesion: 0.15
Nodes (13): CardExpiryFormatter, formatEditUpdate, CurrencyInputFormatter, formatEditUpdate, mask, MaskInputFormatter, formatEditUpdate, NoSpaceFormatter (+5 more)

### Community 40 - "app_image.dart"
Cohesion: 0.12
Nodes (15): BorderRadius?, BoxFit, borderRadius, build, _buildErrorWidget, errorBackgroundColor, errorIconColor, errorIconSize (+7 more)

### Community 41 - "StatelessWidget"
Cohesion: 0.12
Nodes (16): AnimationDemoPage, MyApp, MyHomePage, AppBottomNavigation, AppButton, AppDashboardAppbar, AppDialog, _MenuItemRow (+8 more)

### Community 42 - "currency_formatter_demo_page.dart"
Cohesion: 0.14
Nodes (14): build, createState, CurrencyFormatterDemoPage, _CurrencyFormatterDemoPageState, dispose, _dollarController, _rupiahController, build (+6 more)

### Community 43 - "bool get"
Cohesion: 0.14
Nodes (13): bool get, ColorScheme get, double get, colorScheme, isDarkMode, screenHeight, screenSize, screenWidth (+5 more)

### Community 44 - "app_image_viewer_dialog.dart"
Cohesion: 0.14
Nodes (13): AppImageViewerDialog, build, _buildError, _buildImageContent, _close, imagePath, imageUrl, _isOnline (+5 more)

### Community 45 - "wWinMain"
Cohesion: 0.24
Nodes (9): wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), _In_, _In_opt_ (+1 more)

### Community 46 - "currency_extension.dart"
Cohesion: 0.18
Nodes (11): AppCurrencyType, AppCurrencyTypeExtension, NumCurrencyFormatExtension, StringCurrencyFormatExtension, toCurrency, toCurrencyFraction, toDollar, toRupiah (+3 more)

### Community 47 - "currency_extension_demo_page.dart"
Cohesion: 0.20
Nodes (10): build, _buildFormatDemo, _buildSectionTitle, createState, CurrencyExtensionDemoPage, _CurrencyExtensionDemoPageState, _largeValue, _negativeValue (+2 more)

### Community 48 - "num_extension_demo_page.dart"
Cohesion: 0.20
Nodes (10): build, _buildFormatDemo, _buildSectionTitle, createState, _fraction, _largeNumber, NumExtensionDemoPage, _NumExtensionDemoPageState (+2 more)

### Community 49 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 50 - "ValueChanged"
Cohesion: 0.18
Nodes (10): build, control, description, descriptionSize, isSelected, onChanged, title, titleSize (+2 more)

### Community 51 - "Color"
Cohesion: 0.20
Nodes (9): Color, activeColor, AppSelectionPill, build, control, isSelected, onChanged, text (+1 more)

### Community 52 - "app_month_picker_demo_page.dart"
Cohesion: 0.22
Nodes (9): AppMonthPickerDemoPage, _AppMonthPickerDemoPageState, build, _buildSectionTitle, createState, _selectedMonth1, _selectedMonth2, _selectedMonth3 (+1 more)

### Community 53 - "app_switch_button_demo_page.dart"
Cohesion: 0.22
Nodes (9): AppSwitchButtonDemoPage, _AppSwitchButtonDemoPageState, build, _buildSectionTitle, createState, _switch1, _switch2, _switch3 (+1 more)

### Community 54 - "app_year_picker_demo_page.dart"
Cohesion: 0.25
Nodes (8): AppYearPickerDemoPage, _AppYearPickerDemoPageState, build, _buildSectionTitle, createState, _selectedYear1, _selectedYear2, _selectedYear3

### Community 55 - "string_extension_demo_page.dart"
Cohesion: 0.25
Nodes (8): build, _buildFormatDemo, _buildSectionTitle, _carbonApi, createState, StringExtensionDemoPage, _StringExtensionDemoPageState, static const

### Community 56 - "app_detail_appbar.dart"
Cohesion: 0.22
Nodes (8): AppDetailAppbar, backgroundColor, build, isBack, onBack, title, titleColor, VoidCallback?

### Community 57 - "../ui_component_flutter.dart"
Cohesion: 0.22
Nodes (8): AppSnackbar, AppSnackbarType, error, info, show, success, warning, ../ui_component_flutter.dart

### Community 58 - "app_timeline_demo_page.dart"
Cohesion: 0.29
Nodes (7): Axis, AppTimelineDemoPage, _AppTimelineDemoPageState, build, createState, _direction, _isLoading

### Community 59 - "currency_input_formatter.dart"
Cohesion: 0.25
Nodes (7): dart:math, extensions/currency_extension.dart, decimalDigits, formatEditUpdate, showSymbol, symbolSeparator, type

### Community 60 - "double?"
Cohesion: 0.25
Nodes (7): double?, _asPercentValue, DoublePercentFormatExtension, StringPercentFormatExtension, toPercent, toPercentFraction, toThousandFormat

### Community 61 - "widget_extension_demo_page.dart"
Cohesion: 0.29
Nodes (7): build, _buildSubtitle, createState, paddingBottom, SpecificPaddingDemoExtension, WidgetExtensionDemoPage, _WidgetExtensionDemoPageState

### Community 62 - "app_dashboard_appbar_demo_page.dart"
Cohesion: 0.33
Nodes (6): AppDashboardAppbarDemoPage, _AppDashboardAppbarDemoPageState, build, createState, _isDark, _isLoading

### Community 63 - "app_image_upload_demo_page.dart"
Cohesion: 0.33
Nodes (6): AppImageUploadDemoPage, _AppImageUploadDemoPageState, build, createState, _profileLocalPath, _selectedImagePath

### Community 64 - "app_otp_demo_page.dart"
Cohesion: 0.33
Nodes (6): AppOtpDemoPage, _AppOtpDemoPageState, build, createState, _isLoading, _otpCode

### Community 65 - "app_progress_bar_demo_page.dart"
Cohesion: 0.33
Nodes (6): AppProgressBarDemoPage, _AppProgressBarDemoPageState, build, createState, _isLoading, _progress

### Community 66 - "app_progress_circle_demo_page.dart"
Cohesion: 0.33
Nodes (6): AppProgressCircleDemoPage, _AppProgressCircleDemoPageState, build, createState, _isLoading, _progress

### Community 67 - "CustomPainter"
Cohesion: 0.67
Nodes (3): CustomPainter, _CircleProgressPainter, _VerticalTimelineLinePainter

### Community 69 - "_AppProgressCircleState"
Cohesion: 0.67
Nodes (3): AppProgressCircle, _AppProgressCircleState, SingleTickerProviderStateMixin

## Knowledge Gaps
- **1141 isolated node(s):** `flutter_controller_`, `project_`, `x`, `y`, `height` (+1136 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **7 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppCurrencyType` connect `currency_extension.dart` to `app_currency_field.dart`, `currency_input_formatter.dart`?**
  _High betweenness centrality (0.015) - this node is a cross-community bridge._
- **What connects `flutter_controller_`, `project_`, `x` to the rest of the system?**
  _1141 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Win32Window` be split into smaller, more focused modules?**
  _Cohesion score 0.05311676909569798 - nodes in this community are weakly interconnected._
- **Should `app_timeline.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.03571428571428571 - nodes in this community are weakly interconnected._
- **Should `app_progress_circle.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.037037037037037035 - nodes in this community are weakly interconnected._
- **Should `ui_component_theme.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.043478260869565216 - nodes in this community are weakly interconnected._
- **Should `List` be split into smaller, more focused modules?**
  _Cohesion score 0.04830917874396135 - nodes in this community are weakly interconnected._