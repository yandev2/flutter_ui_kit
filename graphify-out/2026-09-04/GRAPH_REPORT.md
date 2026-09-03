# Graph Report - flutter_ui_kit  (2026-09-04)

## Corpus Check
- 174 files · ~60,553 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1645 nodes · 2160 edges · 89 communities (81 shown, 8 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 18 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Component Group 0
- Component Group 1
- Component Group 2
- Component Group 3
- Component Group 4
- Component Group 5
- Component Group 6
- Component Group 7
- Component Group 8
- Component Group 9
- Component Group 10
- Component Group 11
- Component Group 12
- Component Group 13
- Component Group 14
- Component Group 15
- Component Group 16
- Component Group 17
- Component Group 18
- Component Group 19
- Component Group 20
- Component Group 21
- Component Group 22
- Component Group 23
- Component Group 24
- Component Group 25
- Component Group 26
- Component Group 27
- Component Group 28
- Component Group 29
- Component Group 30
- Component Group 31
- Component Group 32
- Component Group 33
- Component Group 34
- Component Group 35
- Component Group 36
- Component Group 37
- Component Group 38
- Component Group 39
- Component Group 40
- Component Group 41
- Component Group 42
- Component Group 43
- Component Group 44
- Component Group 45
- Component Group 46
- Component Group 47
- Component Group 48
- Component Group 49
- Component Group 50
- Component Group 51
- Component Group 52
- Component Group 53
- Component Group 54
- Component Group 55
- Component Group 56
- Component Group 57
- Component Group 58
- Component Group 59
- Component Group 60
- Component Group 61
- Component Group 62
- Component Group 63
- Component Group 64
- Component Group 65
- Component Group 66
- Component Group 67
- Component Group 68
- Component Group 69
- Component Group 70
- Component Group 71
- Component Group 72
- Component Group 73
- Component Group 74
- Component Group 75
- Component Group 76
- Component Group 77
- Component Group 78
- Component Group 79
- Component Group 80
- Component Group 81
- Component Group 82
- Component Group 83
- Component Group 88

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 24 edges
2. `MessageHandler` - 12 edges
3. `FlutterWindow` - 10 edges
4. `Create` - 10 edges
5. `WndProc` - 10 edges
6. `MessageHandler` - 9 edges
7. `_MyApplication` - 7 edges
8. `OnCreate` - 7 edges
9. `WindowClassRegistrar` - 7 edges
10. `Destroy` - 7 edges

## Surprising Connections (you probably didn't know these)
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  example/windows/runner/main.cpp → example/windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  example/windows/runner/win32_window.cpp → example/windows/runner/win32_window.h
- `my_application_activate()` --calls--> `fl_register_plugins()`  [INFERRED]
  example/linux/runner/my_application.cc → example/linux/flutter/generated_plugin_registrant.cc
- `main()` --calls--> `my_application_new()`  [INFERRED]
  example/linux/runner/main.cc → example/linux/runner/my_application.cc
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  example/windows/runner/flutter_window.h → example/windows/flutter/generated_plugin_registrant.cc

## Import Cycles
- None detected.

## Communities (89 total, 8 thin omitted)

### Community 0 - "Component Group 0"
Cohesion: 0.05
Nodes (57): RegisterPlugins(), DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM, FlutterWindow (+49 more)

### Community 1 - "Component Group 1"
Cohesion: 0.04
Nodes (55): activeColor, AppTimelineNode, build, _buildHorizontalNode, _buildIndicator, _buildLineBar, _buildNodeContent, centers (+47 more)

### Community 2 - "Component Group 2"
Cohesion: 0.04
Nodes (53): Curve, animateOnAppear, _animateTo, animationCurve, animationDuration, build, _buildProgressAnimation, color (+45 more)

### Community 3 - "Component Group 3"
Cohesion: 0.04
Nodes (45): app_colors.dart, app_field_metrics.dart, app_spacing.dart, app_typography.dart, AppTheme, _buildDarkTheme, _buildLightTheme, _darkColorScheme (+37 more)

### Community 4 - "Component Group 4"
Cohesion: 0.04
Nodes (44): AppScaleConfig get, BuildContext, InheritedWidget, ContextExtension, adaptive, _applyCap, AppScale, AppScaleConfig (+36 more)

### Community 5 - "Component Group 5"
Cohesion: 0.05
Nodes (44): FocusNode, AppTextField, _AppTextFieldState, autofillHints, build, controller, createState, _currentText (+36 more)

### Community 6 - "Component Group 6"
Cohesion: 0.05
Nodes (43): AppOtpForm, _AppOtpFormState, autofocus, backgroundColor, build, _buildOtpField, buttonText, _code (+35 more)

### Community 7 - "Component Group 7"
Cohesion: 0.05
Nodes (41): AppTimePickerDemoPage, _AppTimePickerDemoPageState, build, _buildSectionTitle, createState, _selectedTime1, _selectedTime2, _selectedTime3 (+33 more)

### Community 8 - "Component Group 8"
Cohesion: 0.05
Nodes (40): components/app_bottom_navigation.dart, components/app_button.dart, components/app_currency_field.dart, components/app_dashboard_appbar.dart, components/app_date_picker.dart, components/app_detail_appbar.dart, components/app_dialog.dart, components/app_dropdown.dart (+32 more)

### Community 9 - "Component Group 9"
Cohesion: 0.05
Nodes (40): AppColors, backgroundDark, backgroundLight, borderDark, borderLight, cardDark, cardLight, dangerDark (+32 more)

### Community 10 - "Component Group 10"
Cohesion: 0.05
Nodes (36): app_scale.dart, appFieldHorizontalPadding, appFieldMinHeight, appFieldVerticalPadding, AppRadius, AppSpacing, circular, lg (+28 more)

### Community 11 - "Component Group 11"
Cohesion: 0.05
Nodes (38): AppDropdown, _AppDropdownState, build, _buildMultiTriggerContent, _buildSingleTriggerContent, _buildTrailingIcons, _clearAllSelected, createState (+30 more)

### Community 12 - "Component Group 12"
Cohesion: 0.07
Nodes (25): Any, Cocoa, AppDelegate, Bool, RunnerTests, RegisterGeneratedPlugins(), AppDelegate, Bool (+17 more)

### Community 13 - "Component Group 13"
Cohesion: 0.05
Nodes (36): build, _canConfirm, _canGoNextMonth, _canGoPrevMonth, createState, currentMonth, d, _dateOnly (+28 more)

### Community 14 - "Component Group 14"
Cohesion: 0.06
Nodes (33): DateTime, AppDatePickerDemoPage, _AppDatePickerDemoPageState, build, _buildSectionTitle, createState, _selectedDate1, _selectedDate2 (+25 more)

### Community 15 - "Component Group 15"
Cohesion: 0.06
Nodes (35): accent, activeColor, animationDuration, AppSwitchControlPosition, AppSwitchTheme, build, controlPosition, copyWith (+27 more)

### Community 16 - "Component Group 16"
Cohesion: 0.06
Nodes (33): animation_demo_page.dart, app_bottom_navigation_demo_page.dart, app_button_demo_page.dart, app_dashboard_appbar_demo_page.dart, app_date_picker_demo_page.dart, app_detail_appbar_demo_page.dart, app_dialog_demo_page.dart, app_dropdown_demo_page.dart (+25 more)

### Community 17 - "Component Group 17"
Cohesion: 0.06
Nodes (32): actions, appBarHeight, backgroundColor, borderRadius, _bottomAreaHeight, _bottomOnlyExtent, build, createState (+24 more)

### Community 18 - "Component Group 18"
Cohesion: 0.07
Nodes (29): BorderRadiusGeometry?, GlobalKey, activeColor, activeTextColor, AppSegmentedSwitch, _AppSegmentedSwitchState, backgroundColor, borderRadius (+21 more)

### Community 19 - "Component Group 19"
Cohesion: 0.07
Nodes (29): AppMonthPicker, _AppMonthPickerState, build, _controller, createState, dispose, endMonth, fillColor (+21 more)

### Community 20 - "Component Group 20"
Cohesion: 0.07
Nodes (28): FixedExtentScrollController, AppYearPicker, _AppYearPickerState, build, _controller, createState, dispose, endYear (+20 more)

### Community 21 - "Component Group 21"
Cohesion: 0.07
Nodes (28): allowedExtensions, AppFileUpload, _AppFileUploadState, backgroundColor, build, _buildFilePreview, _buildPreview, buttonHeight (+20 more)

### Community 22 - "Component Group 22"
Cohesion: 0.07
Nodes (27): ImagePicker, AppImageUpload, _AppImageUploadState, backgroundColor, build, _buildPreview, createState, descriptionSize (+19 more)

### Community 23 - "Component Group 23"
Cohesion: 0.09
Nodes (22): fl_register_plugins(), main(), first_frame_cb(), my_application_activate(), my_application_class_init(), my_application_dispose(), my_application_init(), my_application_local_command_line() (+14 more)

### Community 24 - "Component Group 24"
Cohesion: 0.07
Nodes (26): IconData?, AppButtonShape, AppButtonSize, AppButtonVariant, _backgroundColor, _baseColor, build, _buildContent (+18 more)

### Community 25 - "Component Group 25"
Cohesion: 0.08
Nodes (26): AppPasswordField, _AppPasswordFieldState, autofillHints, build, controller, createState, errorSize, errorText (+18 more)

### Community 26 - "Component Group 26"
Cohesion: 0.08
Nodes (25): EdgeInsetsGeometry?, AppBottomNavItem, backgroundColor, build, _buildIcon, _buildItemContent, _buildLabel, currentIndex (+17 more)

### Community 27 - "Component Group 27"
Cohesion: 0.08
Nodes (23): app_image.dart, double? imageHeight,
  BoxFit, AppDialogVariant, barrierDismissible, build, content, description, descriptionSize (+15 more)

### Community 28 - "Component Group 28"
Cohesion: 0.09
Nodes (21): date_extension.dart, capitalize, removeWhitespace, reverse, StringCarbonDateExtension, StringFormatExtension, toAlphaNumericOnly, toCamelCase (+13 more)

### Community 29 - "Component Group 29"
Cohesion: 0.11
Nodes (15): build, AppButtonDemoPage, build, _buildSectionTitle, AppDetailAppbarDemoPage, build, AppDialogDemoPage, build (+7 more)

### Community 30 - "Component Group 30"
Cohesion: 0.09
Nodes (21): align, backgroundColor, center, clipOval, clipRRect, constrained, expanded, flexible (+13 more)

### Community 31 - "Component Group 31"
Cohesion: 0.10
Nodes (20): Iterable, AppCurrencyField, autofillHints, build, controller, currencyType, decimalDigits, errorSize (+12 more)

### Community 32 - "Component Group 32"
Cohesion: 0.11
Nodes (19): Animation, AnimationController, Duration?, animated, _AnimatedMotionWrapper, _AnimatedMotionWrapperState, _animation, AppAnimationVariant (+11 more)

### Community 33 - "Component Group 33"
Cohesion: 0.10
Nodes (19): AppDashboardAppbar, _avatarDiameter, _avatarIconSize, avatarSize, avatarUrl, build, _buildActionButton, _buildAvatar (+11 more)

### Community 34 - "Component Group 34"
Cohesion: 0.12
Nodes (15): dart:io, buildOfflineImage, buildPathImage, file, fit, buildOfflineImage, buildPathImage, fit (+7 more)

### Community 35 - "Component Group 35"
Cohesion: 0.11
Nodes (17): HeroIcons?, AppProgressBar, backgroundColor, build, color, height, icon, iconSize (+9 more)

### Community 36 - "Component Group 36"
Cohesion: 0.12
Nodes (16): BorderRadius?, BoxFit, AppImage, borderRadius, build, _buildErrorWidget, errorBackgroundColor, errorIconColor (+8 more)

### Community 37 - "Component Group 37"
Cohesion: 0.12
Nodes (16): activeColor, AppRadio, AppRadioVariant, backgroundColor, build, description, descriptionSize, dotColor (+8 more)

### Community 38 - "Component Group 38"
Cohesion: 0.15
Nodes (13): CardExpiryFormatter, formatEditUpdate, CurrencyInputFormatter, formatEditUpdate, mask, MaskInputFormatter, formatEditUpdate, NoSpaceFormatter (+5 more)

### Community 39 - "Component Group 39"
Cohesion: 0.14
Nodes (14): build, createState, CurrencyFormatterDemoPage, _CurrencyFormatterDemoPageState, dispose, _dollarController, _rupiahController, build (+6 more)

### Community 40 - "Component Group 40"
Cohesion: 0.14
Nodes (13): bool get, ColorScheme get, double get, colorScheme, isDarkMode, screenHeight, screenSize, screenWidth (+5 more)

### Community 41 - "Component Group 41"
Cohesion: 0.14
Nodes (14): AnimationDemoPage, MyApp, MyHomePage, AppBottomNavigation, AppButton, AppDetailAppbar, AppDialog, _MenuItemRow (+6 more)

### Community 42 - "Component Group 42"
Cohesion: 0.14
Nodes (13): AppImageViewerDialog, build, _buildError, _buildImageContent, _close, imagePath, imageUrl, _isOnline (+5 more)

### Community 43 - "Component Group 43"
Cohesion: 0.15
Nodes (12): activeColor, AppSelectionPill, build, control, isSelected, onChanged, text, textSize (+4 more)

### Community 44 - "Component Group 44"
Cohesion: 0.18
Nodes (11): AppDropdownDemoPage, _AppDropdownDemoPageState, build, _buildSectionTitle, createState, _items, _multiValues, _pillSelected (+3 more)

### Community 45 - "Component Group 45"
Cohesion: 0.18
Nodes (11): AppMainAppbarDemoPage, _AppMainAppbarDemoPageState, build, _components, createState, _DemoMode, _floating, _pinned (+3 more)

### Community 46 - "Component Group 46"
Cohesion: 0.24
Nodes (9): wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), _In_, _In_opt_ (+1 more)

### Community 47 - "Component Group 47"
Cohesion: 0.18
Nodes (11): AppCurrencyType, AppCurrencyTypeExtension, NumCurrencyFormatExtension, StringCurrencyFormatExtension, toCurrency, toCurrencyFraction, toDollar, toRupiah (+3 more)

### Community 48 - "Component Group 48"
Cohesion: 0.20
Nodes (10): class, AppSegmentedSwitchDemoPage, _AppSegmentedSwitchDemoPageState, build, createState, _isLoading, _selectedBool, _selectedCompact (+2 more)

### Community 49 - "Component Group 49"
Cohesion: 0.20
Nodes (10): AppBottomNavigationDemoPage, _AppBottomNavigationDemoPageState, build, createState, _currentIndex, _navItems, _selectedVariant, AppBottomNavigationVariant (+2 more)

### Community 50 - "Component Group 50"
Cohesion: 0.24
Nodes (10): AppSnackbarDemoPage, _AppSnackbarDemoPageState, build, createState, AppDatePicker, _AppDatePickerState, _CalendarPopup, _CalendarPopupState (+2 more)

### Community 51 - "Component Group 51"
Cohesion: 0.20
Nodes (10): build, _buildFormatDemo, _buildSectionTitle, createState, CurrencyExtensionDemoPage, _CurrencyExtensionDemoPageState, _largeValue, _negativeValue (+2 more)

### Community 52 - "Component Group 52"
Cohesion: 0.20
Nodes (10): build, _buildFormatDemo, _buildSectionTitle, createState, _fraction, _largeNumber, NumExtensionDemoPage, _NumExtensionDemoPageState (+2 more)

### Community 53 - "Component Group 53"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 54 - "Component Group 54"
Cohesion: 0.18
Nodes (10): AppSelectionTile, build, control, description, descriptionSize, isSelected, onChanged, title (+2 more)

### Community 55 - "Component Group 55"
Cohesion: 0.22
Nodes (9): AppSwitchButtonDemoPage, _AppSwitchButtonDemoPageState, build, _buildSectionTitle, createState, _switch1, _switch2, _switch3 (+1 more)

### Community 56 - "Component Group 56"
Cohesion: 0.22
Nodes (9): AppYearPickerDemoPage, _AppYearPickerDemoPageState, build, _buildSectionTitle, createState, _selectedYear1, _selectedYear2, _selectedYear3 (+1 more)

### Community 57 - "Component Group 57"
Cohesion: 0.22
Nodes (8): Color, backgroundColor, build, isBack, onBack, title, titleColor, VoidCallback?

### Community 58 - "Component Group 58"
Cohesion: 0.22
Nodes (8): dart:ui, AppGlassyVariant, _clampAlpha, _getBlurFromVariant, _getOpacityFromVariant, glassy, GlassyExtension, _resolveGradient

### Community 59 - "Component Group 59"
Cohesion: 0.25
Nodes (8): AppMonthPickerDemoPage, _AppMonthPickerDemoPageState, build, _buildSectionTitle, createState, _selectedMonth1, _selectedMonth2, _selectedMonth3

### Community 60 - "Component Group 60"
Cohesion: 0.25
Nodes (8): build, _buildFormatDemo, _buildSectionTitle, _carbonApi, createState, StringExtensionDemoPage, _StringExtensionDemoPageState, static const

### Community 61 - "Component Group 61"
Cohesion: 0.22
Nodes (8): AppSnackbar, AppSnackbarType, error, info, show, success, warning, ../ui_component_flutter.dart

### Community 62 - "Component Group 62"
Cohesion: 0.29
Nodes (7): Axis, AppTimelineDemoPage, _AppTimelineDemoPageState, build, createState, _direction, _isLoading

### Community 63 - "Component Group 63"
Cohesion: 0.25
Nodes (7): dart:math, extensions/currency_extension.dart, decimalDigits, formatEditUpdate, showSymbol, symbolSeparator, type

### Community 64 - "Component Group 64"
Cohesion: 0.25
Nodes (7): double?, _asPercentValue, DoublePercentFormatExtension, StringPercentFormatExtension, toPercent, toPercentFraction, toThousandFormat

### Community 65 - "Component Group 65"
Cohesion: 0.29
Nodes (7): AppFileUploadDemoPage, _AppFileUploadDemoPageState, build, createState, _selectedFilePath, _selectedPdfPath, _updateDocLocalPath

### Community 66 - "Component Group 66"
Cohesion: 0.29
Nodes (7): build, _buildSubtitle, createState, paddingBottom, SpecificPaddingDemoExtension, WidgetExtensionDemoPage, _WidgetExtensionDemoPageState

### Community 67 - "Component Group 67"
Cohesion: 0.33
Nodes (6): AppDashboardAppbarDemoPage, _AppDashboardAppbarDemoPageState, build, createState, _isDark, _isLoading

### Community 68 - "Component Group 68"
Cohesion: 0.33
Nodes (6): AppImageUploadDemoPage, _AppImageUploadDemoPageState, build, createState, _profileLocalPath, _selectedImagePath

### Community 69 - "Component Group 69"
Cohesion: 0.33
Nodes (6): AppOtpDemoPage, _AppOtpDemoPageState, build, createState, _isLoading, _otpCode

### Community 70 - "Component Group 70"
Cohesion: 0.33
Nodes (6): AppProgressBarDemoPage, _AppProgressBarDemoPageState, build, createState, _isLoading, _progress

### Community 71 - "Component Group 71"
Cohesion: 0.33
Nodes (6): AppProgressCircleDemoPage, _AppProgressCircleDemoPageState, build, createState, _isLoading, _progress

### Community 72 - "Component Group 72"
Cohesion: 0.33
Nodes (6): AppTextFieldDemoPage, _AppTextFieldDemoPageState, build, _buildSectionTitle, createState, package:heroicons/heroicons.dart

### Community 73 - "Component Group 73"
Cohesion: 0.40
Nodes (4): build, _buildSubtitle, _buildTextField, GenericFormattersDemoPage

### Community 74 - "Component Group 74"
Cohesion: 0.40
Nodes (4): build, _buildTypographyItem, TypographyDemoPage, package:ui_component_flutter/theme/theme.dart

### Community 75 - "Component Group 75"
Cohesion: 0.67
Nodes (3): CustomPainter, _CircleProgressPainter, _VerticalTimelineLinePainter

### Community 77 - "Component Group 77"
Cohesion: 0.67
Nodes (3): AppProgressCircle, _AppProgressCircleState, SingleTickerProviderStateMixin

## Knowledge Gaps
- **1103 isolated node(s):** `build`, `_currentIndex`, `_selectedVariant`, `_navItems`, `createState` (+1098 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppCurrencyType` connect `Component Group 47` to `Component Group 63`, `Component Group 31`?**
  _High betweenness centrality (0.013) - this node is a cross-community bridge._
- **Why does `_VerticalTimelineLinePainter` connect `Component Group 75` to `Component Group 1`?**
  _High betweenness centrality (0.005) - this node is a cross-community bridge._
- **What connects `build`, `_currentIndex`, `_selectedVariant` to the rest of the system?**
  _1103 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Component Group 0` be split into smaller, more focused modules?**
  _Cohesion score 0.05311676909569798 - nodes in this community are weakly interconnected._
- **Should `Component Group 1` be split into smaller, more focused modules?**
  _Cohesion score 0.03571428571428571 - nodes in this community are weakly interconnected._
- **Should `Component Group 2` be split into smaller, more focused modules?**
  _Cohesion score 0.037037037037037035 - nodes in this community are weakly interconnected._
- **Should `Component Group 3` be split into smaller, more focused modules?**
  _Cohesion score 0.043478260869565216 - nodes in this community are weakly interconnected._