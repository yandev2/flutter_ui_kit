import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_kit/flutter_ui_kit.dart';

void main() {
  test('flutter_ui_kit barrel exports all public APIs', () {
    // Theme
    expect(AppColors.primary, isNotNull);
    expect(AppScale.mobileBreakpoint, 600.0);
    expect(AppTheme.lightTheme, isNotNull);
    expect(AppTheme.darkTheme, isNotNull);

    // Core formatters & extensions
    expect(CurrencyInputFormatter, isNotNull);
    expect(AppDateTimeFormat.values, isNotEmpty);
    expect(AppCurrencyType.values, isNotEmpty);
    expect(AppAnimationVariant.values, isNotEmpty);

    // Buttons
    expect(AppButtonVariant.values, isNotEmpty);
    expect(AppButtonShape.values, isNotEmpty);
    expect(AppButtonSize.values, isNotEmpty);
    expect(IconPosition.values, isNotEmpty);

    // Dialogs
    expect(AppDialogVariant.values, isNotEmpty);

    // Inputs
    expect(AppRadioVariant.values, isNotEmpty);
    expect(AppCheckboxVariant.values, isNotEmpty);

    // Navigation
    expect(AppNavigationBarVariant.values, isNotEmpty);

    // Status
    expect(AppSnackbarType.values, isNotEmpty);

    // Data display
    expect(AppCardStyle1Variant.values, isNotEmpty);
    expect(AppCardStyle2Variant.values, isNotEmpty);
    expect(AppTimelineStatus.values, isNotEmpty);

    // Widget types
    expect(AppButton, isNotNull);
    expect(AppCardDetail1, isNotNull);
    expect(AppDialog, isNotNull);
    expect(AppImageViewerDialog, isNotNull);
    expect(AppImage, isNotNull);
    expect(AppTextField, isNotNull);
    expect(AppPasswordField, isNotNull);
    expect(AppCheckbox, isNotNull);
    expect(AppRadio, isNotNull);
    expect(AppSwitch, isNotNull);
    expect(AppSegmentedSwitch, isNotNull);
    expect(AppSelectionPill, isNotNull);
    expect(AppSelectionTile, isNotNull);
    expect(AppDropdown, isNotNull);
    expect(AppDatePicker, isNotNull);
    expect(AppTimePicker, isNotNull);
    expect(AppYearPicker, isNotNull);
    expect(AppMonthPicker, isNotNull);
    expect(AppOtpForm, isNotNull);
    expect(AppNavigationBar, isNotNull);
    expect(AppWelcomeAppBar, isNotNull);
    expect(AppProfileCard1, isNotNull);
    expect(AppProfileCard2, isNotNull);
    expect(AppStatsOverview1, isNotNull);
    expect(AppStatsGlassyStyle, isNotNull);
    expect(AppEmptyState, isNotNull);
    expect(AppProgressBar, isNotNull);
    expect(AppSnackbar, isNotNull);
    expect(AppCircularPercent, isNotNull);
    expect(AppAvatarStack, isNotNull);
    expect(AppCardStyle1, isNotNull);
    expect(AppCardStyle2, isNotNull);
    expect(AppCardStyle3, isNotNull);
    expect(AppCardStyle4, isNotNull);
    expect(AppCardStyle5, isNotNull);
    expect(AppCardStyle6, isNotNull);
    expect(AppCardStyle7, isNotNull);
    expect(AppCardStyle8, isNotNull);
    expect(AppTimeline, isNotNull);

    // Helper types
    expect(AppProfileCard1FooterItem, isNotNull);
    expect(AppCardStyle5Stat, isNotNull);
    expect(AppTimeData, isNotNull);
    expect(AppTimelineNode, isNotNull);
    expect(AppNavigationBarItem, isNotNull);
  });
}
