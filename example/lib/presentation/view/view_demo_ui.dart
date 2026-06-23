import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/view_demo_ui_controller.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/dialogs/app_dialog.dart';
import 'package:flutter_ui_kit/ui/dialogs/app_image_viewer_dialog.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';
import 'package:flutter_ui_kit/ui/inputs/app_checkbox.dart';
import 'package:flutter_ui_kit/ui/inputs/app_radio.dart';
import 'package:flutter_ui_kit/ui/inputs/app_segmented_switch.dart';
import 'package:flutter_ui_kit/ui/inputs/app_selection_pill.dart';
import 'package:flutter_ui_kit/ui/inputs/app_selection_tile.dart';
import 'package:flutter_ui_kit/ui/inputs/app_switch.dart';
import 'package:flutter_ui_kit/ui/inputs/app_dropdown.dart';
import 'package:flutter_ui_kit/ui/inputs/app_date_picker.dart';
import 'package:flutter_ui_kit/ui/inputs/app_time_picker.dart';
import 'package:flutter_ui_kit/ui/inputs/app_year_picker.dart';
import 'package:flutter_ui_kit/ui/inputs/app_month_picker.dart';
import 'package:flutter_ui_kit/ui/inputs/app_textfield.dart';
import 'package:flutter_ui_kit/ui/inputs/app_password_field.dart';
import 'package:flutter_ui_kit/ui/status/app_empty_state.dart';
import 'package:flutter_ui_kit/ui/navigation/app_navigation_bar.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/ui/status/app_snackbar.dart';
import 'package:flutter_ui_kit/ui/data_display/app_avatar_stack.dart';
import 'package:flutter_ui_kit/ui/status/app_progress_bar.dart';
import 'package:flutter_ui_kit/ui/status/app_circular_percent.dart';
import 'package:flutter_ui_kit/ui/data_display/app_timeline.dart';
import 'package:flutter_ui_kit/ui/data_display/app_card_style1.dart';
import 'package:flutter_ui_kit/ui/data_display/app_card_style2.dart';
import 'package:flutter_ui_kit/ui/data_display/app_card_style3.dart';
import 'package:flutter_ui_kit/ui/data_display/app_card_style4.dart';
import 'package:flutter_ui_kit/ui/data_display/app_card_style5.dart';
import 'package:flutter_ui_kit/ui/data_display/app_card_style6.dart';
import 'package:flutter_ui_kit/ui/data_display/app_card_style7.dart';
import 'package:flutter_ui_kit/ui/data_display/app_card_style8.dart';
import 'package:flutter_ui_kit/ui/card_detail/app_card_detail1.dart';
import 'package:flutter_ui_kit/ui/stats_overview/app_stats_overview1.dart';
import 'package:flutter_ui_kit/ui/stats_overview/app_stats_glassy_style.dart';
import 'package:flutter_ui_kit/ui/profile/app_profile_card1.dart';
import 'package:flutter_ui_kit/ui/profile/app_profile_card2.dart';
import 'package:flutter_ui_kit/ui/navigation/app_welcome_app_bar.dart';
import 'package:flutter_ui_kit/ui/inputs/app_otp_form.dart';
import 'package:flutter_ui_kit/core/formatters/currency_input_formatter.dart';
import 'package:flutter_ui_kit/core/extensions/extensions.dart';

class ViewDemoUi extends StatelessWidget {
  ViewDemoUi({super.key});

  final ViewDemoUiController controller = Get.put(ViewDemoUiController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDark = controller.isDarkMode.value;

      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'UI Components Demo',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppScale.sp(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.surface,
          elevation: 1,
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: AppColors.textPrimary,
              ),
              onPressed: controller.toggleTheme,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: AppScale.responsiveMaxWidth,
              padding: EdgeInsets.all(AppScale.w(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Dialog Components',
                    style: TextStyle(
                      fontSize: AppScale.sp(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppScale.h(16)),
                  Wrap(
                    spacing: AppScale.w(12),
                    runSpacing: AppScale.h(12),
                    children: [
                      _buildDialogButton(
                        'Success Dialog',
                        () => AppDialog.show(
                          variant: AppDialogVariant.success,
                          title: 'Payment Successful',
                          description:
                              'Your subscription has been renewed successfully. You can now access all features.',
                          textRight: 'Done',
                          onRight: () => Get.back(),
                        ),
                        AppColors.success,
                      ),
                      _buildDialogButton(
                        'Error Dialog',
                        () => AppDialog.show(
                          variant: AppDialogVariant.error,
                          title: 'Delete Content',
                          description:
                              'Are you sure you want to remove this content? It will be in your trash for 7 days.',
                          textLeft: 'Cancel',
                          textRight: 'Delete',
                          onRight: () => Get.back(),
                          content: Row(
                            children: [
                              Icon(Icons.check_box, color: AppColors.primary),
                              SizedBox(width: AppScale.w(8)),
                              Text(
                                'Do not show it anymore',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: AppScale.sp(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppColors.error,
                      ),
                      _buildDialogButton(
                        'Promo / Info Dialog',
                        () => AppDialog.show(
                          variant: AppDialogVariant.info,
                          title: 'Unlock magic features',
                          description:
                              'Discover the amazing features we designed to empower your customization experience.',
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/512/3565/3565099.png', // Dummy box image
                          textLeft: 'Cancel',
                          textRight: 'Unlock',
                          onRight: () => Get.back(),
                        ),
                        AppColors.primary,
                      ),
                      _buildDialogButton(
                        'Warning Dialog',
                        () => AppDialog.show(
                          variant: AppDialogVariant.warning,
                          title: 'Session Expiring',
                          description:
                              'Your session is about to expire due to inactivity. Please confirm to stay logged in.',
                          textLeft: 'Log Out',
                          textRight: 'Stay',
                          onRight: () => Get.back(),
                        ),
                        AppColors.warning,
                      ),
                      _buildDialogButton(
                        'Image Viewer (Online)',
                        () => AppImageViewerDialog.showOnline(
                          imageUrl:
                              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=1200&q=80',
                        ),
                        AppColors.info,
                      ),
                    ],
                  ),
                  SizedBox(height: AppScale.h(32)),
                  Text(
                    'Button Components',
                    style: TextStyle(
                      fontSize: AppScale.sp(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppScale.h(16)),
                  Wrap(
                    spacing: AppScale.w(16),
                    runSpacing: AppScale.h(16),
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      AppButton(text: 'Solid Rounded', onPressed: () {}),
                      AppButton(
                        text: 'Pill Solid',
                        shape: AppButtonShape.pill,
                        onPressed: () {},
                      ),
                      AppButton(
                        text: 'Outline',
                        variant: AppButtonVariant.outline,
                        onPressed: () {},
                      ),
                      AppButton(
                        text: 'Dashed',
                        variant: AppButtonVariant.dashed,
                        onPressed: () {},
                      ),
                      AppButton(
                        text: 'Smooth',
                        variant: AppButtonVariant.smooth,
                        onPressed: () {},
                      ),
                      AppButton(
                        text: 'Gradient',
                        variant: AppButtonVariant.gradient,
                        gradientColors: const [
                          Color(0xFF8B5CF6),
                          Color(0xFFEC4899),
                        ],
                        onPressed: () {},
                      ),
                      AppButton(
                        text: 'Raised',
                        variant: AppButtonVariant.raised,
                        onPressed: () {},
                      ),
                      AppButton.icon(
                        icon: Icons.delete,
                        color: AppColors.error,
                        onPressed: () {},
                      ),
                      AppButton.icon(
                        icon: Icons.add,
                        shape: AppButtonShape.square,
                        onPressed: () {},
                      ),
                      AppButton(
                        text: 'Caption',
                        icon: Icons.grid_view,
                        iconPosition: IconPosition.top,
                        variant: AppButtonVariant.text,
                        onPressed: () {},
                      ),
                      AppButton(
                        text: 'Next',
                        icon: Icons.arrow_forward_ios,
                        iconPosition: IconPosition.right,
                        variant: AppButtonVariant.text,
                        onPressed: () {},
                      ),
                      // Contoh Full Width
                      AppButton(
                        text: 'Full Width Button',
                        isFullWidth: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: AppScale.h(32)),
                  Text(
                    'Input Components (Selection)',
                    style: TextStyle(
                      fontSize: AppScale.sp(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppScale.h(16)),
                  Wrap(
                    spacing: AppScale.w(16),
                    runSpacing: AppScale.h(16),
                    children: [
                      // Group 1: Pill buttons
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppSelectionPill(
                                text: 'Yes',
                                isSelected: controller.checkPill1.value,
                                onChanged: (val) =>
                                    controller.checkPill1.value = val,
                                control: AppCheckbox(
                                  value: controller.checkPill1.value,
                                  onChanged: (val) =>
                                      controller.checkPill1.value = val!,
                                ),
                              ),
                              SizedBox(width: AppScale.w(16)),
                              AppSelectionPill(
                                text: 'No',
                                isSelected: controller.checkPill2.value,
                                onChanged: (val) =>
                                    controller.checkPill2.value = val,
                                control: AppCheckbox(
                                  value: controller.checkPill2.value,
                                  onChanged: (val) =>
                                      controller.checkPill2.value = val!,
                                  variant: AppCheckboxVariant.outline,
                                  activeColor: AppColors
                                      .textSecondary, // Unselected icon color
                                ),
                                activeColor:
                                    AppColors.border, // Unselected border
                              ),
                            ],
                          ),
                          SizedBox(height: AppScale.h(16)),
                          Row(
                            children: [
                              AppSelectionPill(
                                text: 'Yes',
                                isSelected:
                                    controller.radioPillGroup.value == 'yes',
                                onChanged: (_) =>
                                    controller.radioPillGroup.value = 'yes',
                                control: AppRadio<String>(
                                  value: 'yes',
                                  groupValue: controller.radioPillGroup.value,
                                  onChanged: (val) =>
                                      controller.radioPillGroup.value = val!,
                                  variant: AppRadioVariant.solid,
                                ),
                              ),
                              SizedBox(width: AppScale.w(16)),
                              AppSelectionPill(
                                text: 'No',
                                isSelected:
                                    controller.radioPillGroup.value == 'no',
                                onChanged: (_) =>
                                    controller.radioPillGroup.value = 'no',
                                control: AppRadio<String>(
                                  value: 'no',
                                  groupValue: controller.radioPillGroup.value,
                                  onChanged: (val) =>
                                      controller.radioPillGroup.value = val!,
                                  variant: AppRadioVariant.outline,
                                  activeColor: AppColors.textSecondary,
                                ),
                                activeColor: AppColors.border,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Group: Tiles with Description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSelectionTile(
                            title: 'I agree to this thing.',
                            description:
                                'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit, sed do.',
                            isSelected: controller.checkTile1.value,
                            onChanged: (val) =>
                                controller.checkTile1.value = val,
                            control: AppCheckbox(
                              value: controller.checkTile1.value,
                              onChanged: (val) =>
                                  controller.checkTile1.value = val!,
                              size: 24, // slightly larger to match text height
                            ),
                          ),
                          SizedBox(height: AppScale.h(24)),
                          AppSelectionTile(
                            title: 'Subscribe to newsletter',
                            // No description here, just title!
                            isSelected: controller.checkTile2.value,
                            onChanged: (val) =>
                                controller.checkTile2.value = val,
                            control: AppCheckbox(
                              value: controller.checkTile2.value,
                              onChanged: (val) =>
                                  controller.checkTile2.value = val!,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      // Group 2: Raw controls
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppCheckbox(
                            value: true,
                            onChanged: (_) {},
                            variant: AppCheckboxVariant.solid,
                          ),
                          SizedBox(width: 8),
                          AppCheckbox(
                            value: false,
                            onChanged: (_) {},
                            variant: AppCheckboxVariant.outline,
                            activeColor: AppColors.border,
                          ),
                          SizedBox(width: 8),
                          AppCheckbox(
                            value: false,
                            onChanged: (_) {},
                            variant: AppCheckboxVariant.outline,
                          ),
                          SizedBox(width: 8),
                          AppCheckbox(
                            value: true,
                            onChanged: (_) {},
                            variant: AppCheckboxVariant.outline,
                          ),
                          SizedBox(width: 8),
                          AppCheckbox(
                            value: true,
                            onChanged: (_) {},
                            variant: AppCheckboxVariant.checkOnly,
                          ),
                          SizedBox(width: 8),
                          AppCheckbox(
                            value: true,
                            onChanged: (_) {},
                            variant: AppCheckboxVariant.checkOnly,
                            activeColor: Colors.black,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppRadio<int>(
                            value: 1,
                            groupValue: 1,
                            onChanged: (_) {},
                            variant: AppRadioVariant.solid,
                          ),
                          SizedBox(width: 8),
                          AppRadio<int>(
                            value: 1,
                            groupValue: 0,
                            onChanged: (_) {},
                            variant: AppRadioVariant.outline,
                            activeColor: AppColors.border,
                          ),
                          SizedBox(width: 8),
                          AppRadio<int>(
                            value: 1,
                            groupValue: 0,
                            onChanged: (_) {},
                            variant: AppRadioVariant.outline,
                          ),
                          SizedBox(width: 8),
                          AppRadio<int>(
                            value: 1,
                            groupValue: 1,
                            onChanged: (_) {},
                            variant: AppRadioVariant.outline,
                          ),
                          SizedBox(width: 8),
                          AppRadio<int>(
                            value: 1,
                            groupValue: 1,
                            onChanged: (_) {},
                            variant: AppRadioVariant.dotOnly,
                          ),
                          SizedBox(width: 8),
                          AppRadio<int>(
                            value: 1,
                            groupValue: 1,
                            onChanged: (_) {},
                            variant: AppRadioVariant.dotOnly,
                            activeColor: Colors.black,
                          ),
                        ],
                      ),
                      // Group 4: Switches
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppSwitch(
                            value: controller.switchVal.value,
                            onChanged: (val) =>
                                controller.switchVal.value = val,
                          ),
                          SizedBox(width: 16),
                          AppSwitch(
                            value: !controller.switchVal.value,
                            onChanged: (val) =>
                                controller.switchVal.value = !val,
                          ),
                        ],
                      ),
                      // Group 5: Segmented Switch
                      SizedBox(
                        width: AppScale.w(370), // Max width to show it nicely
                        child: AppSegmentedSwitch(
                          options: const ['Hotels', 'Apartments', 'Villas'],
                          borderRadius: BorderRadius.circular(AppScale.r(8)),
                          selectedIndex: controller.segmentedVal.value,
                          onChanged: (val) =>
                              controller.segmentedVal.value = val,
                          mainAxisSize: MainAxisSize.max,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      // Auto-sizing segmented switch (MainAxisSize.min)
                      AppSegmentedSwitch(
                        options: const ['Flight', 'Train'],
                        selectedIndex: controller.segmentedVal.value.clamp(
                          0,
                          1,
                        ), // safety clamp for demo
                        onChanged: (val) => controller.segmentedVal.value = val,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      // Group 6: Dropdowns
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppScale.w(300),
                            child: AppDropdown(
                              title: 'City Location',
                              hint: 'Select your city...',
                              prefixIcon: Icons.search,
                              value: controller.dropdownVal.value,
                              items: const [
                                'Ikeja, Lagos',
                                'Surulere, Lagos',
                                'Victoria Island, Lagos',
                                'Lekki, Lagos',
                              ],
                              onChanged: (val) =>
                                  controller.dropdownVal.value = val,
                            ),
                          ),
                          SizedBox(height: AppScale.h(16)),
                          SizedBox(
                            width: AppScale.w(300),
                            child: AppDropdown(
                              title: 'Cities (Multi Select)',
                              hint: 'Select cities...',
                              prefixIcon: Icons.location_city_outlined,
                              isMultiSelect: true,
                              selectedValues:
                                  controller.dropdownMultiVal.toList(),
                              items: const [
                                'Ikeja, Lagos',
                                'Surulere, Lagos',
                                'Victoria Island, Lagos',
                                'Lekki, Lagos',
                              ],
                              onMultiChanged: (val) =>
                                  controller.dropdownMultiVal.assignAll(val),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                      // Group 7: TextFields
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Email Field
                          SizedBox(
                            width: AppScale.w(300),
                            child: AppTextField(
                              title: 'Email',
                              hint: 'olivia@untitledui.com',
                              prefixIcon: Icons.mail_outline,
                              suffixIcon: Icons.help_outline,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(height: 16),

                          // 2. Phone Field (Custom Prefix)
                          SizedBox(
                            width: AppScale.w(300),
                            child: AppTextField(
                              title: 'Phone number',
                              hint: '+1 (555) 000-0000',
                              keyboardType: TextInputType.phone,
                              prefixWidget: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'US',
                                    style: TextStyle(
                                      fontSize: AppScale.sp(14),
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                  SizedBox(width: AppScale.w(4)),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: AppScale.w(16),
                                    color: AppColors.textSecondary,
                                  ),
                                  SizedBox(width: AppScale.w(8)),
                                ],
                              ),
                              suffixIcon: Icons.help_outline,
                            ),
                          ),
                          SizedBox(height: 16),

                          // 3. Currency Field (Custom Prefix & Suffix)
                          Obx(
                            () => SizedBox(
                              width: AppScale.w(300),
                              child: AppTextField(
                                title: 'Sale amount',
                                hint: '1,000',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: false,
                                    ),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    symbol: controller.currencyType.value,
                                    decimalDigits: 0,
                                  ),
                                ],
                                prefixWidget: Text(
                                  controller.currencyType.value == 'Rp'
                                      ? 'Rp '
                                      : '\$ ',
                                  style: TextStyle(
                                    fontSize: AppScale.sp(14),
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                suffixWidget: GestureDetector(
                                  onTap: () {
                                    // Toggle Currency
                                    controller.currencyType.value =
                                        controller.currencyType.value == 'Rp'
                                        ? 'USD'
                                        : 'Rp';
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller.currencyType.value == 'Rp'
                                            ? 'IDR'
                                            : 'USD',
                                        style: TextStyle(
                                          fontSize: AppScale.sp(14),
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                        ),
                                      ),
                                      SizedBox(width: AppScale.w(4)),
                                      Icon(
                                        Icons.swap_vert,
                                        size: AppScale.w(16),
                                        color: AppColors.textSecondary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),

                          // 4. Password Field
                          SizedBox(
                            width: AppScale.w(300),
                            child: AppPasswordField(
                              title: 'Password',
                              hint: '••••••••',
                              onChanged: (val) {
                                // print('Password changed: $val');
                              },
                            ),
                          ),
                          SizedBox(height: 16),

                          // 5. Website Field (Prefix Block)
                          SizedBox(
                            width: AppScale.w(300),
                            child: AppTextField(
                              title: 'Website',
                              hint: 'www.untitledui.com',
                              keyboardType: TextInputType.url,
                              prefixWidget: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppScale.w(12),
                                ),
                                margin: EdgeInsets.only(right: AppScale.w(12)),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: AppColors.border),
                                  ),
                                ),
                                child: Text(
                                  'http://',
                                  style: TextStyle(
                                    fontSize: AppScale.sp(14),
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Group 8: Navigation Bars
                      SizedBox(height: AppScale.h(24)),
                      Text(
                        'Navigation Bars',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),

                      Obx(() {
                        final items = const [
                          AppNavigationBarItem(
                            icon: HeroIcons.home,
                            activeIcon: HeroIcons.home,
                            label: 'Home',
                          ),
                          AppNavigationBarItem(
                            icon: HeroIcons.magnifyingGlass,
                            activeIcon: HeroIcons.magnifyingGlass,
                            label: 'Search',
                          ),
                          AppNavigationBarItem(
                            icon: HeroIcons.chartPie,
                            activeIcon: HeroIcons.chartPie,
                            label: 'Analytics',
                          ),
                          AppNavigationBarItem(
                            icon: HeroIcons.clock,
                            activeIcon: HeroIcons.clock,
                            label: 'History',
                          ),
                          AppNavigationBarItem(
                            icon: HeroIcons.user,
                            activeIcon: HeroIcons.user,
                            label: 'Profile',
                          ),
                        ];

                        final itemsWithScanner = const [
                          AppNavigationBarItem(
                            icon: HeroIcons.home,
                            activeIcon: HeroIcons.home,
                            label: 'Home',
                          ),
                          AppNavigationBarItem(
                            icon: HeroIcons.magnifyingGlass,
                            activeIcon: HeroIcons.magnifyingGlass,
                            label: 'Search',
                          ),
                          AppNavigationBarItem(
                            icon: HeroIcons.viewfinderCircle,
                            activeIcon: HeroIcons.viewfinderCircle,
                            label: 'Scan',
                          ),
                          AppNavigationBarItem(
                            icon: HeroIcons.clock,
                            activeIcon: HeroIcons.clock,
                            label: 'History',
                          ),
                          AppNavigationBarItem(
                            icon: HeroIcons.user,
                            activeIcon: HeroIcons.user,
                            label: 'Profile',
                          ),
                        ];

                        return Column(
                          children: [
                            // Row 1 Left: Text on Selected
                            AppNavigationBar(
                              items: items,
                              selectedIndex: controller.navIndex.value,
                              onChanged: (val) =>
                                  controller.navIndex.value = val,
                              variant: AppNavigationBarVariant.textOnSelected,
                            ),
                            SizedBox(height: AppScale.h(24)),

                            // Row 1 Center: Text Always
                            AppNavigationBar(
                              items: items,
                              selectedIndex: controller.navIndex.value,
                              onChanged: (val) =>
                                  controller.navIndex.value = val,
                              variant: AppNavigationBarVariant.textAlways,
                            ),
                            SizedBox(height: AppScale.h(24)),

                            // Row 1 Right: Top Indicator
                            AppNavigationBar(
                              items: items,
                              selectedIndex: controller.navIndex.value,
                              onChanged: (val) =>
                                  controller.navIndex.value = val,
                              variant: AppNavigationBarVariant.topIndicator,
                            ),
                            SizedBox(height: AppScale.h(24)),

                            // Row 2 Left: Circle Background
                            AppNavigationBar(
                              items: items,
                              selectedIndex: controller.navIndex.value,
                              onChanged: (val) =>
                                  controller.navIndex.value = val,
                              variant: AppNavigationBarVariant.circleBackground,
                            ),
                            SizedBox(height: AppScale.h(24)),

                            // Row 2 Center: Pill Background Labeled
                            AppNavigationBar(
                              items: items,
                              selectedIndex: controller.navIndex.value,
                              onChanged: (val) =>
                                  controller.navIndex.value = val,
                              variant: AppNavigationBarVariant.pillBackground,
                            ),
                            SizedBox(height: AppScale.h(48)),

                            // Row 3 Left: Prominent Floating Center (Text on Selected)
                            AppNavigationBar(
                              items: itemsWithScanner,
                              selectedIndex: controller.navIndex.value,
                              onChanged: (val) =>
                                  controller.navIndex.value = val,
                              variant: AppNavigationBarVariant.textOnSelected,
                              prominentCenterIndex: 2,
                              isCenterFloating: true,
                            ),
                            SizedBox(
                              height: AppScale.h(48),
                            ), // Extra margin for floating element
                            // Row 3 Center: Prominent Floating Center (Text Always)
                            AppNavigationBar(
                              items: itemsWithScanner,
                              selectedIndex: controller.navIndex.value,
                              onChanged: (val) =>
                                  controller.navIndex.value = val,
                              variant: AppNavigationBarVariant.textAlways,
                              prominentCenterIndex: 2,
                              isCenterFloating: true,
                            ),
                            SizedBox(height: AppScale.h(24)),

                            // Row 3 Right: Prominent Inline Center (Text Always)
                            AppNavigationBar(
                              items: itemsWithScanner,
                              selectedIndex: controller.navIndex.value,
                              onChanged: (val) =>
                                  controller.navIndex.value = val,
                              variant: AppNavigationBarVariant.textAlways,
                              prominentCenterIndex: 2,
                              isCenterFloating: false,
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 5.5: Date & Time Pickers
                      Text(
                        'Date & Time Pickers',
                        style: TextStyle(
                          fontSize: AppScale.sp(20),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Obx(
                        () => AppDatePicker(
                          title: 'Select Date',
                          hint: 'Choose a date',
                          value: controller.selectedDate.value,
                          onChanged: (val) =>
                              controller.selectedDate.value = val,
                        ),
                      ),
                      SizedBox(height: AppScale.h(24)),
                      Obx(
                        () => AppTimePicker(
                          title: 'Select Time',
                          hint: 'Choose a time',
                          value: controller.selectedTime.value,
                          onChanged: (val) =>
                              controller.selectedTime.value = val,
                        ),
                      ),
                      SizedBox(height: AppScale.h(24)),
                      Obx(
                        () => AppYearPicker(
                          title: 'Select Year',
                          hint: 'Choose a year',
                          value: controller.selectedYear.value,
                          onChanged: (val) =>
                              controller.selectedYear.value = val,
                        ),
                      ),
                      SizedBox(height: AppScale.h(24)),
                      Obx(
                        () => AppMonthPicker(
                          title: 'Select Month',
                          hint: 'Choose a month',
                          value: controller.selectedMonth.value,
                          onChanged: (val) =>
                              controller.selectedMonth.value = val,
                        ),
                      ),
                      SizedBox(height: AppScale.h(32)),

                      // SECTION 5: Status Components
                      Text(
                        'Status Components',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            // Demo 1: Empty State with Custom Image Widget
                            AppEmptyState(
                              title: 'The task is all completed',
                              description:
                                  'It seems that all the tasks are proceeding in an orderly manner.',
                              customImageWidget: Container(
                                width: AppScale.w(160),
                                height: AppScale.w(160),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: HeroIcon(
                                    HeroIcons.checkBadge,
                                    style: HeroIconStyle.solid,
                                    color: AppColors.primary,
                                    size: AppScale.w(80),
                                  ),
                                ),
                              ),
                              actionLabel: 'Create new task',
                              onAction: () {},
                            ),

                            Divider(color: AppColors.border),

                            // Demo 2: Error State with Network Image
                            AppEmptyState(
                              title: 'No connection',
                              description:
                                  'Please check your internet connection and try again.',
                              imageUrl:
                                  'https://cdn-icons-png.flaticon.com/512/2748/2748558.png', // Fallback illustration
                              actionLabel: 'Retry',
                              onAction: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 6: Snackbars
                      Text(
                        'Snackbars (Toasts)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Wrap(
                        spacing: AppScale.w(12),
                        runSpacing: AppScale.h(12),
                        children: [
                          _buildDialogButton('Success Snackbar', () {
                            AppSnackbar.success(
                              title: 'Your Payment is Successful!',
                            );
                          }, AppColors.success),
                          _buildDialogButton('Info Snackbar', () {
                            AppSnackbar.info(
                              title: 'New Update Available',
                              subtitle:
                                  'Please update your app to the latest version.',
                            );
                          }, AppColors.info),
                          _buildDialogButton('Warning Snackbar', () {
                            AppSnackbar.warning(title: 'Storage almost full');
                          }, AppColors.warning),
                          _buildDialogButton('Error Snackbar', () {
                            AppSnackbar.error(
                              title: 'Oops! Something went wrong!',
                            );
                          }, AppColors.error),
                          _buildDialogButton('Normal Snackbar', () {
                            AppSnackbar.show(
                              title: 'Your draft has been discarded.',
                            );
                          }, AppColors.neutral600),
                          _buildDialogButton('With Action', () {
                            AppSnackbar.show(
                              title: 'Message Deleted.',
                              icon: HeroIcon(
                                HeroIcons.trash,
                                color: AppColors.neutral400,
                                style: HeroIconStyle.outline,
                              ),
                              actionLabel: 'Undo',
                              onAction: () {
                                // print('Undo clicked');
                              },
                            );
                          }, AppColors.info),
                          _buildDialogButton('Complex Snackbar', () {
                            AppSnackbar.show(
                              title: 'Upload Successful!',
                              subtitle: 'Image101 was uploaded successfully.',
                              icon: Container(
                                padding: EdgeInsets.all(AppScale.w(8)),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppScale.r(8),
                                  ),
                                ),
                                child: HeroIcon(
                                  HeroIcons.photo,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          }, AppColors.primary),
                        ],
                      ),

                      // SECTION 7: Avatar Stack
                      Text(
                        'Avatar Stack',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Container(
                        padding: EdgeInsets.all(AppScale.w(16)),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(AppScale.r(16)),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Small Stack (Max 3, no online indicator)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: AppScale.h(8)),
                            AppAvatarStack(
                              imageUrls: [
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80',
                                'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=100&q=80',
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
                                'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=80',
                              ],
                              maxDisplay: 3,
                              totalCount: 12,
                              size: AppScale.w(32),
                              overlap: AppScale.w(10),
                            ),

                            SizedBox(height: AppScale.h(24)),

                            Text(
                              'Large Stack (Max 5, with online indicator)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: AppScale.h(8)),
                            AppAvatarStack(
                              imageUrls: [
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80',
                                'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=100&q=80',
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
                                'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=80',
                                'invalid_url_to_test_error_state',
                              ],
                              maxDisplay: 6,
                              totalCount: 25,
                              size: AppScale.w(48),
                              overlap: AppScale.w(16),
                              showOnlineIndicator: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 8: Progress Bar
                      Text(
                        'Progress Bar',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Container(
                        padding: EdgeInsets.all(AppScale.w(16)),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(AppScale.r(16)),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'With Icon, Title, and Subtitle (Max Width)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: AppScale.h(16)),
                            AppProgressBar(
                              progress: 0.3,
                              title: '30%',
                              subtitle: 'Shipping...',
                              icon: HeroIcons.truck,
                              color: AppColors.primary,
                            ),

                            SizedBox(height: AppScale.h(24)),

                            Text(
                              'Simple Custom Color (Min Width)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: AppScale.h(16)),
                            AppProgressBar(
                              progress: 0.75,
                              title: '75%',
                              subtitle: 'Downloading...',
                              color: AppColors.success,
                              height: AppScale.h(12),
                              mainAxisSize: MainAxisSize.min,
                              width: AppScale.w(200),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 9: Timeline
                      Text(
                        'Timeline',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Container(
                        padding: EdgeInsets.all(AppScale.w(16)),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(AppScale.r(16)),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vertical Timeline',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: AppScale.h(16)),
                            AppTimeline(
                              activeColor: Color(
                                0xFF5A52FF,
                              ), // Purple color from reference
                              nodes: [
                                AppTimelineNode(
                                  title: 'Step One',
                                  subtitle: 'This is the first step.',
                                  status: AppTimelineStatus.completed,
                                ),
                                AppTimelineNode(
                                  title: 'Step Two',
                                  subtitle: 'This is the second step.',
                                  status: AppTimelineStatus.completed,
                                  isHighlighted: true,
                                ),
                                AppTimelineNode(
                                  title: 'Step Three',
                                  subtitle: 'This is the third step.',
                                  status: AppTimelineStatus.active,
                                ),
                                AppTimelineNode(
                                  title: 'Step Four',
                                  subtitle: 'This is the fourth step.',
                                  status: AppTimelineStatus.inactive,
                                ),
                                AppTimelineNode(
                                  title: 'Step Five',
                                  subtitle: 'This is the fifth step.',
                                  status: AppTimelineStatus.disabled,
                                ),
                              ],
                            ),

                            SizedBox(height: AppScale.h(32)),

                            Text(
                              'Horizontal Timeline',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: AppScale.h(16)),
                            AppTimeline(
                              direction: Axis.horizontal,
                              activeColor: AppColors.success,
                              itemWidth: AppScale.w(120),
                              nodes: [
                                AppTimelineNode(
                                  title: 'Ordered',
                                  subtitle: '08:00 AM',
                                  status: AppTimelineStatus.completed,
                                ),
                                AppTimelineNode(
                                  title: 'Packed',
                                  subtitle: '09:30 AM',
                                  status: AppTimelineStatus.active,
                                ),
                                AppTimelineNode(
                                  title: 'Shipped',
                                  status: AppTimelineStatus.inactive,
                                ),
                                AppTimelineNode(
                                  title: 'Delivered',
                                  status: AppTimelineStatus.disabled,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 10: Cards
                      Text(
                        'Cards (Style 1)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCardStyle1(
                              variant: AppCardStyle1Variant.solid,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=600&q=80',
                              title: 'Sophie Bennett',
                              subtitle:
                                  'Product Designer who focuses on simplicity & usability.',
                              isVerified: true,
                              footerItem1Icon: HeroIcons.user,
                              footerItem1Text: '312',
                              footerItem2Icon: HeroIcons.documentText,
                              footerItem2Text: '48',
                              onButtonTap: () {},
                            ),
                            SizedBox(width: AppScale.w(16)),
                            AppCardStyle1(
                              variant: AppCardStyle1Variant.glassy,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=600&q=80',
                              title: 'Sophie Bennett',
                              subtitle:
                                  'Product Designer who focuses on simplicity & usability.',
                              isVerified: true,
                              footerItem1Icon: HeroIcons.user,
                              footerItem1Text: '312',
                              footerItem2Icon: HeroIcons.documentText,
                              footerItem2Text: '48',
                              onButtonTap: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 11: Cards Style 2
                      Text(
                        'Cards (Style 2)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCardStyle2(
                              variant: AppCardStyle2Variant.glassy,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?auto=format&fit=crop&w=600&q=80',
                              title: 'New York',
                              subtitle: 'Economy',
                              footerItem1Icon: HeroIcons.tag,
                              footerItem1Text: 'from \$120',
                              footerItem2Icon: HeroIcons.paperAirplane,
                              footerItem2Text: 'JFK',
                              isFavorite: false,
                              progress: 0.65, // Slider percent
                              onButtonTap: () {},
                              onFavoriteTap: () {},
                            ),
                            SizedBox(width: AppScale.w(16)),
                            AppCardStyle2(
                              variant: AppCardStyle2Variant.solid,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?auto=format&fit=crop&w=600&q=80',
                              title: 'San Francisco',
                              subtitle: 'Premium economy',
                              footerItem1Icon: HeroIcons.tag,
                              footerItem1Text: 'from \$240',
                              footerItem2Icon: HeroIcons.paperAirplane,
                              footerItem2Text: 'SFO',
                              isFavorite: true,
                              progress: 0.35, // Slider percent
                              onButtonTap: () {},
                              onFavoriteTap: () {},
                            ),
                            SizedBox(width: AppScale.w(16)),
                            AppCardStyle2(
                              isLoading: true,
                              variant: AppCardStyle2Variant.solid,
                              imageUrl: '-',
                              title: '----------------',
                              subtitle: '----------------',
                              footerItem1Icon: HeroIcons.tag,
                              footerItem1Text: '-------',
                              footerItem2Icon: HeroIcons.paperAirplane,
                              footerItem2Text: '---',
                              isFavorite: true,
                              buttonText: '-------',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 12: Cards Style 3
                      Text(
                        'Cards (Style 3)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle3(
                        imageUrl:
                            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=600&q=80',
                        title: 'Santorini Sunset Loft',
                        price: '\$890',
                        description:
                            'Experience a cliffside loft with iconic white walls, blue domes, and magical sunset views.',
                        rating: 4.8,
                        tags: ['Romantic Stay', '2 Night Trip'],
                        isBookmarked: false,
                        onButtonTap: () {},
                        onBookmarkTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle3(
                        isLoading: true,
                        imageUrl: '-',
                        title: '------------------------',
                        price: '-----',
                        description:
                            '--------------------------------------------------------------',
                        rating: 5.0,
                        tags: ['-----------', '----------'],
                        buttonText: '--------',
                        isBookmarked: false,
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 13: Cards Style 4
                      Text(
                        'Cards (Style 4)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle4(
                        imageUrl:
                            'https://images.unsplash.com/photo-1542314831-c6a4d14b837c?auto=format&fit=crop&w=600&q=80',
                        category: 'Deluxe Room',
                        title: 'Sao Pulo Hotel',
                        location: 'Ubud, Bali, Indonesia',
                        rating: 4.9,
                        reviewText: '1,092 Reviews',
                        onTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle4(
                        isLoading: true,
                        imageUrl: '-',
                        category: '----------',
                        title: '----------------',
                        location: '------------------------',
                        rating: 5.0,
                        reviewText: '----------',
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 14: Cards Style 5
                      Text(
                        'Cards (Style 5)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle5(
                        imageUrl:
                            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80',
                        title: 'Sam Rivers',
                        subtitle: 'Photographer',
                        description:
                            'Based in Sydney, I capture breathtaking landscapes and cultural moments across the globe.',
                        stats: [
                          AppCardStyle5Stat(
                            title: 'Countries Visited',
                            value: '28',
                          ),
                          AppCardStyle5Stat(
                            title: 'Exhibitions Held',
                            value: '10',
                          ),
                          AppCardStyle5Stat(title: 'Rating', value: '4.9'),
                        ],
                        primaryButtonText: 'Explore Portfolio',
                        secondaryButtonText: 'Message',
                        onPrimaryButtonTap: () {},
                        onSecondaryButtonTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle5(
                        isLoading: true,
                        imageUrl: '-',
                        title: '----------------',
                        subtitle: '------------',
                        description:
                            '--------------------------------------------------------------',
                        stats: [
                          AppCardStyle5Stat(title: '----------', value: '--'),
                          AppCardStyle5Stat(title: '----------', value: '--'),
                          AppCardStyle5Stat(title: '------', value: '---'),
                        ],
                        primaryButtonText: '----------',
                        secondaryButtonText: '-------',
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 15: Cards Style 6
                      Text(
                        'Cards (Style 6)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle6(
                        imageUrl:
                            'https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&w=600&q=80',
                        title:
                            'Film Coverage — A Step-By-Step Guide To Shot Listing Efficiently',
                        author: 'By Cameron P. West',
                        date: 'April 10, 2020',
                        tagText: 'Production',
                        onPlayTap: () {},
                        onTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle6(
                        isLoading: true,
                        imageUrl: '-',
                        title: '----------------------------------------',
                        author: '------------------',
                        date: '----------------',
                        tagText: '----------',
                        onPlayTap: () {},
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 16: Cards Style 7
                      Text(
                        'Cards (Style 7)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle7(
                        imageUrl:
                            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=200&q=80',
                        title: 'Richard Wyatt',
                        subtitle: 'Director, Producer',
                        badgeText: 'Mentor',
                        onTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle7(
                        isLoading: true,
                        imageUrl: '-',
                        title: '----------------',
                        subtitle: '------------------',
                        badgeText: '------',
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 17: Cards Style 8
                      Text(
                        'Cards (Style 8)',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppCardStyle8(
                              isMax: true,
                              imageUrl:
                                  'https://logo.clearbit.com/hunter.io',
                              title: 'Hunter',
                              subtitle: 'Data access',
                              description:
                                  'Hunter API makes it easy to find or verify professional email addresses.',
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: AppScale.w(12)),
                          Expanded(
                            child: AppCardStyle8(
                              isMax: true,
                              imageUrl:
                                  'https://logo.clearbit.com/twilio.com',
                              title: 'Twilio',
                              subtitle: 'Data access',
                              description:
                                  'Send and receive SMS and MMS messages as well as query meta-data about text messages.',
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppScale.h(12)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppCardStyle8(
                              isMax: true,
                              imageUrl:
                                  'https://logo.clearbit.com/stripe.com',
                              title: 'Stripe',
                              subtitle: 'Data access',
                              description:
                                  'A suite of payment APIs that powers commerce for online businesses of all sizes.',
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: AppScale.w(12)),
                          Expanded(
                            child: AppCardStyle8(
                              isMax: true,
                              imageUrl:
                                  'https://logo.clearbit.com/typeform.com',
                              title: 'Typeform',
                              subtitle: 'Data access',
                              description:
                                  'Create, retrieve, update, and delete your typeforms, themes, and images.',
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardStyle8(
                        isLoading: true,
                        isMax: true,
                        imageUrl: '-',
                        title: '----------',
                        subtitle: '------------',
                        description:
                            '--------------------------------------------------------------',
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 18: Card Detail 1
                      Text(
                        'Card Detail 1',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardDetail1(
                        imageUrl:
                            'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=800&q=80',
                        title: 'Help Children for Better Education',
                        avatarUrls: [
                          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80',
                          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=100&q=80',
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
                          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=80',
                        ],
                        donorTotalCount: 345,
                        donorText: '345+ people donated',
                        progressLabel: 'Statistic Progress',
                        timeLeftText: '6 hrs left',
                        progress: 0.62,
                        raisedAmount: '\$47,650',
                        description:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                        onTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppCardDetail1(
                        isLoading: true,
                        imageUrl: '-',
                        title: '----------------------------------------',
                        avatarUrls: ['-', '-', '-', '-'],
                        donorText: '----------------------',
                        progressLabel: '------------------',
                        timeLeftText: '----------',
                        progress: 0.5,
                        raisedAmount: '--------',
                        description:
                            '--------------------------------------------------------------',
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 19: Stats Overview 1
                      Text(
                        'Stats Overview 1',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppStatsOverview1(
                        title: 'Hey, Sandro',
                        subtitle: 'Balance',
                        value: '\$23,540.00',
                        onTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppStatsOverview1(
                        gradientColors: const [
                          Color(0xFF0F766E),
                          Color(0xFF14B8A6),
                          Color(0xFF2DD4BF),
                        ],
                        title: 'Hey, Alex',
                        subtitle: 'Total Savings',
                        value: '\$8,420.50',
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppStatsOverview1(
                        isLoading: true,
                        title: '------------',
                        subtitle: '-------',
                        value: '-----------',
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 20: Stats Glassy Style
                      Text(
                        'Stats Glassy Style',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppStatsGlassyStyle(
                        title: 'Membership',
                        icon: HeroIcons.link,
                        value: 'James Appleseed',
                        label: 'uxmisfit.tools',
                        onTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppStatsGlassyStyle(
                        gradientColors: const [
                          Color(0xFF3B82F6),
                          Color(0xFF06B6D4),
                          Color(0xFF8B5CF6),
                        ],
                        title: 'Premium',
                        icon: HeroIcons.sparkles,
                        value: 'Sandro Wijaya',
                        label: 'annual.plan',
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppStatsGlassyStyle(
                        isLoading: true,
                        title: '----------',
                        icon: HeroIcons.link,
                        value: '----------------',
                        label: '-------------',
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 21: Profile Card 1
                      Text(
                        'Profile Card 1',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppProfileCard1(
                        imageUrl:
                            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
                        actionIcon1: HeroIcons.magnifyingGlass,
                        onActionIcon1Tap: () {},
                        actionIcon2: HeroIcons.userPlus,
                        onActionIcon2Tap: () {},
                        title: 'Tobias Whetton',
                        subtitle: '@tobias',
                        description:
                            'Engineer, designer & developer. Building products that make a difference.',
                        footerItem1: const AppProfileCard1FooterItem(
                          value: '321',
                          label: 'Points',
                        ),
                        footerItem2: const AppProfileCard1FooterItem(
                          value: '30',
                          label: 'Friends',
                        ),
                        footerItem3: const AppProfileCard1FooterItem(
                          text: 'Joined Apr 2020',
                        ),
                        onTap: () {},
                      ),
                      SizedBox(height: AppScale.h(16)),
                      AppProfileCard1(
                        isLoading: true,
                        imageUrl: '-',
                        actionIcon1: HeroIcons.magnifyingGlass,
                        actionIcon2: HeroIcons.userPlus,
                        title: '----------------',
                        subtitle: '--------',
                        description:
                            '--------------------------------------------------------------',
                        footerItem1: const AppProfileCard1FooterItem(
                          value: '---',
                          label: '------',
                        ),
                        footerItem2: const AppProfileCard1FooterItem(
                          value: '--',
                          label: '-------',
                        ),
                        footerItem3: const AppProfileCard1FooterItem(
                          text: '----------------',
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 21b: Profile Card 2
                      Text(
                        'Profile Card 2',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Center(
                        child: AppProfileCard2.network(
                          imageUrl:
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
                          name: 'Sarah Johnson',
                          email: 'sarah.j@email.com',
                          badgeText: 'Premium Member',
                          badgeIcon: HeroIcons.sparkles,
                          badgeBackgroundColor: AppColors.primary,
                          onBadgeTap: () {},
                          onTap: () {},
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Center(
                        child: AppProfileCard2.network(
                          isLoading: true,
                          imageUrl: '-',
                          name: '----------------',
                          email: '--------------------',
                          badgeText: '----------------',
                          onBadgeTap: () {},
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 22: Welcome App Bar
                      Text(
                        'Welcome App Bar',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.neutral800.withValues(alpha: 0.35)
                              : const Color(0xFFE8EEF5),
                          borderRadius: BorderRadius.circular(AppScale.r(16)),
                        ),
                        child: AppWelcomeAppBar(
                          imageUrl:
                              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=200&q=80',
                          greeting: 'Hi, Welcome Back,',
                          title: 'Pankaj Sharma',
                          isVerified: true,
                          notificationCount: 3,
                          onNotificationTap: () {},
                          onProfileTap: () {},
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.neutral800.withValues(alpha: 0.35)
                              : const Color(0xFFE8EEF5),
                          borderRadius: BorderRadius.circular(AppScale.r(16)),
                        ),
                        child: AppWelcomeAppBar(
                          isLoading: true,
                          imageUrl: '-',
                          greeting: '------------------',
                          title: '----------------',
                          isVerified: true,
                          notificationCount: 3,
                          onNotificationTap: () {},
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 23: OTP Form
                      Text(
                        'OTP Form',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Center(
                        child: AppOtpForm(
                          title: 'Mobile Phone Verification',
                          description:
                              'Enter the 4-digit verification code that was sent to your phone number.',
                          codeLength: 4,
                          buttonText: 'Verify Account',
                          footerText: "Didn't receive code? ",
                          footerActionText: 'Resend',
                          onVerify: () {},
                          onFooterActionTap: () {},
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Center(
                        child: AppOtpForm(
                          title: 'Email Verification',
                          description:
                              'Enter the 6-digit verification code sent to your email.',
                          codeLength: 6,
                          buttonText: 'Verify',
                          onVerify: () {},
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Center(
                        child: AppOtpForm(
                          isLoading: true,
                          title: '--------------------',
                          description: '----------------------------------------',
                          codeLength: 4,
                          buttonText: '----------------',
                          footerText: '---------------- ',
                          footerActionText: '------',
                          onVerify: () {},
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 24: Circular Percent
                      Text(
                        'Circular Percent',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          children: [
                            AppCircularPercent(
                              progress: 0.30,
                              gradientColors: AppCircularPercent.blueGradient,
                              label: 'Label',
                              title: 'Your Score',
                              subtitle: 'as on 15 April 2025 6:18 pm',
                            ),
                            SizedBox(width: AppScale.w(16)),
                            AppCircularPercent(
                              progress: 0.50,
                              gradientColors:
                                  AppCircularPercent.greenPurpleGradient,
                              label: 'Label',
                              title: 'Your Score',
                              subtitle: 'as on 15 April 2025 6:18 pm',
                            ),
                            SizedBox(width: AppScale.w(16)),
                            AppCircularPercent(
                              progress: 0.70,
                              gradientColors:
                                  AppCircularPercent.purplePinkGradient,
                              label: 'Label',
                              title: 'Your Score',
                              subtitle: 'as on 15 April 2025 6:18 pm',
                            ),
                            SizedBox(width: AppScale.w(16)),
                            AppCircularPercent(
                              isLoading: true,
                              progress: 0.45,
                              label: '------',
                              title: '----------',
                              subtitle: '------------------------',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 25: Glassy Extension
                      Text(
                        'Glassy Extension',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Container(
                        width: double.infinity,
                        height: AppScale.h(120),
                        padding: EdgeInsets.all(AppScale.w(12)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppScale.r(20)),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF4A3AFF),
                              Color(0xFFE843AD),
                              Color(0xFFFF6B4A),
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(AppScale.w(12)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Default Glassy',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: AppScale.sp(14),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    SizedBox(height: AppScale.h(4)),
                                    Text(
                                      'Theme-aware blur',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: AppScale.sp(11),
                                        color: AppColors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ).glassy(blurred: 30),
                            ),
                            SizedBox(width: AppScale.w(12)),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(AppScale.w(12)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Custom Gradient',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: AppScale.sp(14),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    SizedBox(height: AppScale.h(4)),
                                    Text(
                                      'Purple frost overlay',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: AppScale.sp(11),
                                        color: AppColors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ).glassy(
                                blurred: 30,
                                gradientColors: [
                                  const Color(0x66FFFFFF),
                                  const Color(0x334A3AFF),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),

                      // SECTION 26: Animated Extension
                      Text(
                        'Animated Extension',
                        style: TextStyle(
                          fontSize: AppScale.sp(18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppScale.h(16)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppScale.w(16),
                          vertical: AppScale.h(24),
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.neutral800.withValues(alpha: 0.35)
                              : AppColors.neutral100,
                          borderRadius: BorderRadius.circular(AppScale.r(16)),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          spacing: AppScale.w(16),
                          runSpacing: AppScale.h(16),
                          children: [
                            _buildAnimatedDemoItem(
                              label: 'Float Vertical',
                              child: Container(
                                width: AppScale.w(56),
                                height: AppScale.w(56),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius:
                                      BorderRadius.circular(AppScale.r(12)),
                                ),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: AppColors.white,
                                  size: AppScale.w(28),
                                ),
                              ).animated(
                                variant: AppAnimationVariant.floatVertical,
                                intensity: 0.7,
                              ),
                            ),
                            _buildAnimatedDemoItem(
                              label: 'Float Horizontal',
                              child: Container(
                                width: AppScale.w(56),
                                height: AppScale.w(56),
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius:
                                      BorderRadius.circular(AppScale.r(12)),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.white,
                                  size: AppScale.w(28),
                                ),
                              ).animated(
                                variant: AppAnimationVariant.floatHorizontal,
                                intensity: 0.7,
                              ),
                            ),
                            _buildAnimatedDemoItem(
                              label: 'Shake',
                              child: Container(
                                width: AppScale.w(56),
                                height: AppScale.w(56),
                                decoration: BoxDecoration(
                                  color: AppColors.warning,
                                  borderRadius:
                                      BorderRadius.circular(AppScale.r(12)),
                                ),
                                child: Icon(
                                  Icons.notifications,
                                  color: AppColors.white,
                                  size: AppScale.w(28),
                                ),
                              ).animated(
                                variant: AppAnimationVariant.shake,
                                intensity: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppScale.h(40)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAnimatedDemoItem({
    required String label,
    required Widget child,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppScale.w(72),
          height: AppScale.h(72),
          child: Center(child: child),
        ),
        SizedBox(height: AppScale.h(8)),
        Text(
          label,
          style: TextStyle(
            fontSize: AppScale.sp(11),
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDialogButton(String text, VoidCallback onTap, Color color) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: AppScale.w(16),
          vertical: AppScale.h(12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
