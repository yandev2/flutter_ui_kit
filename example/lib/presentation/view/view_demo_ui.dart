import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/view_demo_ui_controller.dart';
import '../widgets/demo_sidebar.dart';
import '../widgets/demo_section.dart';

// Import all UI Kit components
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
import 'package:flutter_ui_kit/ui/inputs/app_otp_form.dart';
import 'package:flutter_ui_kit/ui/inputs/app_image_upload.dart';
import 'package:flutter_ui_kit/ui/status/app_empty_state.dart';
import 'package:flutter_ui_kit/ui/navigation/app_navigation_bar.dart';
import 'package:flutter_ui_kit/ui/navigation/app_welcome_app_bar.dart';
import 'package:flutter_ui_kit/ui/navigation/app_main_app_bar.dart';
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
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:flutter_ui_kit/ui/stats_overview/app_stats_overview1.dart';
import 'package:flutter_ui_kit/ui/stats_overview/app_stats_glassy_style.dart';
import 'package:flutter_ui_kit/ui/profile/app_profile_card1.dart';
import 'package:flutter_ui_kit/ui/profile/app_profile_card2.dart';
import 'package:flutter_ui_kit/core/formatters/currency_input_formatter.dart';
import 'package:flutter_ui_kit/core/extensions/extensions.dart';

class ViewDemoUi extends StatelessWidget {
  ViewDemoUi({super.key});

  final ViewDemoUiController controller = Get.put(ViewDemoUiController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDark = controller.isDarkMode.value;
      bool isMobile = Get.width < 800; // Responsive breakpoint for sidebar

      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Flutter UI Kit Demo',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppScale.sp(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.surface,
          elevation: 1,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: AppColors.textPrimary,
              ),
              onPressed: controller.toggleTheme,
              tooltip: 'Toggle Theme',
            ),
          ],
        ),
        drawer: isMobile ? Drawer(child: const DemoSidebar()) : null,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile) const DemoSidebar(),
            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Center(
                  child: Container(
                    width: AppScale.responsiveMaxWidth,
                    padding: EdgeInsets.all(AppScale.w(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 0: Dialogs
                        _buildDialogsSection(),
                        // 1: Buttons
                        _buildButtonsSection(),
                        // 2: Inputs Selection
                        _buildInputsSelectionSection(),
                        // 3: Switches
                        _buildSwitchesSection(),
                        // 4: Dropdowns
                        _buildDropdownsSection(),
                        // 5: TextFields
                        _buildTextFieldsSection(context),
                        // 6: Navigation Bars
                        _buildNavigationBarsSection(),
                        // 7: Date Pickers
                        _buildDatePickersSection(context),
                        // 8: Status Empty States
                        _buildEmptyStatesSection(context),
                        // 9: Snackbars
                        _buildSnackbarsSection(),
                        // 10: Avatar Stack Timeline
                        _buildAvatarTimelineSection(context),
                        // 11: Progress Percent
                        _buildProgressSection(context),
                        // 12: Data Cards
                        _buildDataCardsSection(),
                        // 13: Profile Cards
                        _buildProfileCardsSection(),
                        // 14: Stats Overview
                        _buildStatsOverviewSection(),
                        // 15: Extensions
                        _buildExtensionsSection(context),

                        SizedBox(height: AppScale.h(100)), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ==========================================
  // SECTIONS
  // ==========================================

  Widget _buildDialogsSection() {
    return DemoSection(
      sectionKey: controller.categories[0].key,
      title: 'Dialogs',
      description:
          'Dialog modal interaktif dengan berbagai variant warna dan fungsi, termasuk Image Viewer zoomable.',
      rules: const [
        'Dialog menggunakan variant: success, error, info, warning',
        'Parameter textLeft/textRight untuk menampilkan tombol aksi',
        'ImageViewerDialog mendukung zoom 0.8x hingga 5x',
      ],
      codeSnippet:
          "AppDialog.show(\n  variant: AppDialogVariant.success,\n  title: 'Berhasil!',\n  description: 'Data disimpan.',\n  textRight: 'OK',\n  onRight: () => Get.back(),\n);",
      child: Wrap(
        spacing: AppScale.w(12),
        runSpacing: AppScale.h(12),
        children: [
          _buildDialogButton(
            'Success Dialog',
            () => AppDialog.show(
              variant: AppDialogVariant.success,
              title: 'Payment Successful',
              description: 'Your subscription has been renewed successfully.',
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
              description: 'Are you sure you want to remove this content?',
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
            'Info Dialog',
            () => AppDialog.show(
              variant: AppDialogVariant.info,
              title: 'Unlock Features',
              description: 'Discover the amazing features we designed.',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/3565/3565099.png',
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
              description: 'Your session is about to expire.',
              textLeft: 'Log Out',
              textRight: 'Stay',
              onRight: () => Get.back(),
            ),
            AppColors.warning,
          ),
          _buildDialogButton(
            'Image Viewer',
            () => AppImageViewerDialog.showOnline(
              imageUrl:
                  'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=1200&q=80',
            ),
            AppColors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return DemoSection(
      sectionKey: controller.categories[1].key,
      title: 'Buttons',
      description:
          'Tombol serbaguna dengan berbagai style (solid, outline, dashed, dll) dan dukungan loading otomatis.',
      rules: const [
        'Gunakan AppButtonVariant untuk mengubah style',
        'Gunakan AppButtonShape untuk mengubah bentuk (rounded, pill, square)',
        'Set isLoading: true untuk menonaktifkan tap dan menampilkan spinner',
      ],
      codeSnippet:
          "AppButton(\n  text: 'Submit',\n  variant: AppButtonVariant.gradient,\n  isLoading: false,\n  onPressed: () {},\n)",
      child: Wrap(
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
            gradientColors: const [Color(0xFF8B5CF6), Color(0xFFEC4899)],
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
            text: 'Text',
            icon: Icons.grid_view,
            variant: AppButtonVariant.text,
            onPressed: () {},
          ),
          AppButton(text: 'Loading', isLoading: true, onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildInputsSelectionSection() {
    return DemoSection(
      sectionKey: controller.categories[2].key,
      title: 'Inputs (Selection)',
      description:
          'Komponen seleksi seperti Checkbox, Radio, Pill, dan Tile dengan dukungan multi-state.',
      rules: const [
        'Pill dan Tile dirancang untuk area sentuh yang lebih besar (touch-friendly)',
        'Checkbox dan Radio memiliki variant solid dan outline',
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pills
          Row(
            children: [
              AppSelectionPill(
                text: 'Yes',
                isSelected: controller.checkPill1.value,
                onChanged: (val) => controller.checkPill1.value = val,
                control: AppCheckbox(
                  value: controller.checkPill1.value,
                  onChanged: (v) => controller.checkPill1.value = v!,
                ),
              ),
              SizedBox(width: AppScale.w(16)),
              AppSelectionPill(
                text: 'No',
                isSelected: controller.checkPill2.value,
                onChanged: (val) => controller.checkPill2.value = val,
                control: AppCheckbox(
                  value: controller.checkPill2.value,
                  onChanged: (v) => controller.checkPill2.value = v!,
                  variant: AppCheckboxVariant.outline,
                  activeColor: AppColors.textSecondary,
                ),
                activeColor: AppColors.border,
              ),
            ],
          ),
          SizedBox(height: AppScale.h(16)),
          // Tiles
          AppSelectionTile(
            title: 'I agree to the terms',
            description: 'By checking this, you agree to our policies.',
            isSelected: controller.checkTile1.value,
            onChanged: (val) => controller.checkTile1.value = val,
            control: AppCheckbox(
              value: controller.checkTile1.value,
              onChanged: (v) => controller.checkTile1.value = v!,
            ),
          ),
          SizedBox(height: AppScale.h(16)),
          // Radios
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
              ),
              SizedBox(width: 8),
              AppRadio<int>(
                value: 1,
                groupValue: 1,
                onChanged: (_) {},
                variant: AppRadioVariant.dotOnly,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchesSection() {
    return DemoSection(
      sectionKey: controller.categories[3].key,
      title: 'Switches & Segmented',
      description:
          'Toggle switch dan segmented controls untuk pilihan opsi cepat.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSwitch(
                value: controller.switchVal.value,
                onChanged: (v) => controller.switchVal.value = v,
              ),
              SizedBox(width: 16),
              AppSwitch(
                value: !controller.switchVal.value,
                onChanged: (v) => controller.switchVal.value = !v,
              ),
            ],
          ),
          SizedBox(height: AppScale.h(16)),
          SizedBox(
            width: AppScale.w(370),
            child: AppSegmentedSwitch(
              options: const ['Hotels', 'Apartments', 'Villas'],
              selectedIndex: controller.segmentedVal.value,
              onChanged: (val) => controller.segmentedVal.value = val,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownsSection() {
    return DemoSection(
      sectionKey: controller.categories[4].key,
      title: 'Dropdowns',
      description:
          'Dropdown input yang mendukung Single Select maupun Multi Select.',
      rules: const [
        'Set isMultiSelect: true untuk mengaktifkan pilihan ganda berupa Chips',
        'Gunakan selectedValues untuk mem-passing list data multi-select',
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppScale.w(300),
            child: AppDropdown(
              title: 'City Location',
              hint: 'Select your city...',
              prefixIcon: Icons.search,
              value: controller.dropdownVal.value,
              items: const ['Jakarta', 'Bandung', 'Surabaya', 'Bali'],
              onChanged: (val) => controller.dropdownVal.value = val,
            ),
          ),
          SizedBox(height: AppScale.h(16)),
          SizedBox(
            width: AppScale.w(300),
            child: AppDropdown(
              title: 'Cities (Multi Select)',
              hint: 'Select cities...',
              isMultiSelect: true,
              selectedValues: controller.dropdownMultiVal.toList(),
              items: const ['Jakarta', 'Bandung', 'Surabaya', 'Bali'],
              onMultiChanged: (val) =>
                  controller.dropdownMultiVal.assignAll(val),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldsSection(BuildContext context) {
    return DemoSection(
      sectionKey: controller.categories[5].key,
      title: 'TextFields & Forms',
      description:
          'Kumpulan form input teks, password, OTP, dan formatting khusus (currency).',
      rules: const [
        'Konsep Null -> Hidden: Jika title/helperText bernilai null, widget spacer tidak akan dirender.',
        'AppPasswordField memiliki indikator kekuatan password built-in.',
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  title: 'Email',
                  hint: 'olivia@untitledui.com',
                  prefixIcon: Icons.mail_outline,
                ),
              ),
              SizedBox(width: AppScale.w(16)),
              Expanded(
                child: AppTextField(
                  title: 'Phone number',
                  hint: '+1 (555) 000-0000',
                  prefixWidget: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppScale.w(12)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'US',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  title: 'Sale amount',
                  hint: '1,000',
                  inputFormatters: [
                    CurrencyInputFormatter(
                      symbol: controller.currencyType.value,
                    ),
                  ],
                  prefixWidget: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'Rp ',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  suffixWidget: Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Text(
                      'IDR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppScale.w(16)),
              Expanded(
                child: AppPasswordField(
                  title: 'Password',
                  hint: '••••••••',
                  onChanged: (val) {},
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          AppTextField(
            title: 'Error State',
            hint: 'Input with error...',
            errorText: 'This field is required',
          ),
          SizedBox(height: 32),
          AppOtpForm(
            title: 'Mobile Phone Verification',
            description: 'Enter the 4-digit code sent to your phone.',
            codeLength: 4,
            buttonText: 'Verify Account',
            onVerify: () {},
          ),
          SizedBox(height: 32),
          Obx(
            () => AppImageUpload(
              localImagePath: controller.uploadedImagePath.value,
              onImageSelected: (path) {
                controller.uploadedImagePath.value = path;
              },
              onCancel: () {
                controller.uploadedImagePath.value = null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBarsSection() {
    return DemoSection(
      sectionKey: controller.categories[6].key,
      title: 'Navigation Bars',
      description:
          'Bottom navigation bar dan Sliver App Bar dengan berbagai variasi styling.',
      child: Column(
        children: [
          AppButton(
            text: 'Buka Demo AppMainAppBar (Sliver)',
            variant: AppButtonVariant.outline,
            isFullWidth: true,
            onPressed: () => Get.to(() => const DemoSliverPage()),
          ),
          SizedBox(height: AppScale.h(24)),
          AppWelcomeAppBar(
            imageUrl:
                'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=200&q=80',
            greeting: 'Hi, Welcome Back,',
            title: 'Pankaj Sharma',
            isVerified: true,
            notificationCount: 3,
            notificationBackgroundColor: AppColors.primary.withValues(
              alpha: 0.1,
            ),
            onNotificationTap: () {},
            actionIcon: HeroIcons.cog6Tooth,
            actionBackgroundColor: AppColors.primary.withValues(alpha: 0.1),
            onActionTap: () {},
            onProfileTap: () {},
          ),
          SizedBox(height: AppScale.h(24)),
          AppNavigationBar(
            items: const [
              AppNavigationBarItem(icon: HeroIcons.home, label: 'Home'),
              AppNavigationBarItem(
                icon: HeroIcons.magnifyingGlass,
                label: 'Search',
              ),
              AppNavigationBarItem(icon: HeroIcons.user, label: 'Profile'),
            ],
            selectedIndex: controller.navIndex.value,
            onChanged: (v) => controller.navIndex.value = v,
            variant: AppNavigationBarVariant.textAlways,
          ),
          SizedBox(height: AppScale.h(24)),
          AppNavigationBar(
            items: const [
              AppNavigationBarItem(icon: HeroIcons.home, label: 'Home'),
              AppNavigationBarItem(
                icon: HeroIcons.magnifyingGlass,
                label: 'Search',
              ),
              AppNavigationBarItem(icon: HeroIcons.user, label: 'Profile'),
            ],
            selectedIndex: controller.navIndex.value,
            onChanged: (v) => controller.navIndex.value = v,
            variant: AppNavigationBarVariant.topIndicator,
          ),
          SizedBox(height: AppScale.h(24)),
          AppNavigationBar(
            items: const [
              AppNavigationBarItem(icon: HeroIcons.home, label: 'Home'),
              AppNavigationBarItem(
                icon: HeroIcons.magnifyingGlass,
                label: 'Search',
              ),
              AppNavigationBarItem(icon: HeroIcons.user, label: 'Profile'),
            ],
            selectedIndex: controller.navIndex.value,
            onChanged: (v) => controller.navIndex.value = v,
            variant: AppNavigationBarVariant.circleBackground,
          ),
          SizedBox(height: AppScale.h(24)),
          AppNavigationBar(
            items: const [
              AppNavigationBarItem(icon: HeroIcons.home, label: 'Home'),
              AppNavigationBarItem(
                icon: HeroIcons.magnifyingGlass,
                label: 'Search',
              ),
              AppNavigationBarItem(icon: HeroIcons.user, label: 'Profile'),
            ],
            selectedIndex: controller.navIndex.value,
            onChanged: (v) => controller.navIndex.value = v,
            variant: AppNavigationBarVariant.pillBackground,
          ),
          SizedBox(height: AppScale.h(24)),
          AppNavigationBar(
            items: const [
              AppNavigationBarItem(icon: HeroIcons.home, label: 'Home'),
              AppNavigationBarItem(
                icon: HeroIcons.viewfinderCircle,
                label: 'Scan',
              ),
              AppNavigationBarItem(icon: HeroIcons.user, label: 'Profile'),
            ],
            selectedIndex: controller.navIndex.value,
            onChanged: (v) => controller.navIndex.value = v,
            variant: AppNavigationBarVariant.textOnSelected,
            prominentCenterIndex: 1,
            isCenterFloating: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickersSection(BuildContext context) {
    return DemoSection(
      sectionKey: controller.categories[7].key,
      title: 'Date & Time Pickers',
      description: 'Popup picker untuk tanggal, waktu, bulan, dan tahun.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppDatePicker(
                  title: 'Select Date',
                  value: controller.selectedDate.value,
                  onChanged: (val) => controller.selectedDate.value = val,
                ),
              ),
              SizedBox(width: AppScale.w(16)),
              Expanded(
                child: AppTimePicker(
                  title: 'Select Time',
                  value: controller.selectedTime.value,
                  onChanged: (val) => controller.selectedTime.value = val,
                ),
              ),
            ],
          ),
          SizedBox(height: AppScale.h(16)),
          Row(
            children: [
              Expanded(
                child: AppYearPicker(
                  title: 'Select Year',
                  value: controller.selectedYear.value,
                  onChanged: (val) => controller.selectedYear.value = val,
                ),
              ),
              SizedBox(width: AppScale.w(16)),
              Expanded(
                child: AppMonthPicker(
                  title: 'Select Month',
                  value: controller.selectedMonth.value,
                  onChanged: (val) => controller.selectedMonth.value = val,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStatesSection(BuildContext context) {
    return DemoSection(
      sectionKey: controller.categories[8].key,
      title: 'Status & Empty States',
      description:
          'Tampilan empty state dan error yang digunakan ketika data kosong.',
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: AppEmptyState(
          title: 'No connection',
          description: 'Please check your internet connection and try again.',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/2748/2748558.png',
          actionLabel: 'Retry',
          onAction: () {},
        ),
      ),
    );
  }

  Widget _buildSnackbarsSection() {
    return DemoSection(
      sectionKey: controller.categories[9].key,
      title: 'Snackbars (Toasts)',
      description:
          'Popup notifikasi atas menggunakan Get.snackbar dengan gaya kustom.',
      codeSnippet:
          "AppSnackbar.success(title: 'Berhasil', subtitle: 'Data tersimpan.');",
      child: Wrap(
        spacing: AppScale.w(12),
        runSpacing: AppScale.h(12),
        children: [
          _buildDialogButton(
            'Success',
            () => AppSnackbar.success(title: 'Payment Successful!'),
            AppColors.success,
          ),
          _buildDialogButton(
            'Error',
            () => AppSnackbar.error(title: 'Oops! Error!'),
            AppColors.error,
          ),
          _buildDialogButton(
            'Info',
            () => AppSnackbar.info(title: 'Update Available'),
            AppColors.info,
          ),
          _buildDialogButton(
            'With Action',
            () => AppSnackbar.show(
              title: 'Deleted.',
              icon: HeroIcon(HeroIcons.trash, color: AppColors.neutral400),
              actionLabel: 'Undo',
              onAction: () {},
            ),
            AppColors.neutral600,
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarTimelineSection(BuildContext context) {
    return DemoSection(
      sectionKey: controller.categories[10].key,
      title: 'Avatar Stack, Image & Timeline',
      description:
          'Komponen untuk menampilkan gambar profil, tumpukan avatar, dan urutan proses.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=100&q=80',
                width: AppScale.w(64),
                height: AppScale.w(64),
                borderRadius: BorderRadius.circular(100),
              ),
              SizedBox(width: AppScale.w(16)),
              AppImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
                width: AppScale.w(64),
                height: AppScale.w(64),
                borderRadius: BorderRadius.circular(AppScale.r(12)),
              ),
            ],
          ),
          SizedBox(height: AppScale.h(24)),
          AppAvatarStack(
            imageUrls: [
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80',
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=100&q=80',
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80',
              'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=80',
            ],
            maxDisplay: 3,
            totalCount: 12,
            size: AppScale.w(48),
          ),
          SizedBox(height: AppScale.h(24)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTimeline(
                  activeColor: AppColors.primary,
                  nodes: [
                    AppTimelineNode(
                      title: 'Ordered',
                      status: AppTimelineStatus.completed,
                    ),
                    AppTimelineNode(
                      title: 'Processing',
                      status: AppTimelineStatus.active,
                      isHighlighted: true,
                    ),
                    AppTimelineNode(
                      title: 'Delivered',
                      status: AppTimelineStatus.inactive,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AppTimeline(
                  direction: Axis.horizontal,
                  activeColor: AppColors.success,
                  itemWidth: AppScale.w(100),
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return DemoSection(
      sectionKey: controller.categories[11].key,
      title: 'Progress & Percent',
      description: 'Indikator progres melingkar dan linear.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                AppCircularPercent(
                  progress: 0.30,
                  gradientColors: AppCircularPercent.blueGradient,
                  label: 'Label',
                  title: '30',
                  subtitle: 'Your Score',
                ),
                SizedBox(width: AppScale.w(16)),
                AppCircularPercent(
                  progress: 0.50,
                  gradientColors: AppCircularPercent.greenPurpleGradient,
                  label: 'Label',
                  title: '50',
                  subtitle: 'Your Score',
                ),
                SizedBox(width: AppScale.w(16)),
                AppCircularPercent(
                  progress: 0.70,
                  gradientColors: AppCircularPercent.purplePinkGradient,
                  label: 'Label',
                  title: '70',
                  subtitle: 'Your Score',
                ),
                SizedBox(width: AppScale.w(16)),
                AppCircularPercent(
                  progress: 0.45,
                  isLoading: true, // Demo skeleton
                  label: 'Label',
                  title: 'Loading',
                  subtitle: 'as on 15 April',
                ),
              ],
            ),
          ),
          SizedBox(height: AppScale.h(24)),
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
            style: TextStyle(
              fontSize: AppScale.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppScale.h(12)),
          AppProgressBar(
            progress: 0.75,
            title: '75%',
            subtitle: 'Downloading...',
            color: AppColors.success,
            mainAxisSize: MainAxisSize.min,
          ),
        ],
      ),
    );
  }

  Widget _buildDataCardsSection() {
    return DemoSection(
      sectionKey: controller.categories[12].key,
      title: 'Data Cards & Details',
      description:
          'Beragam gaya Card untuk menampilkan data. Semua Card mendukung properti isLoading untuk auto-skeleton.',
      rules: const [
        'Gunakan isLoading: true saat memuat API untuk memunculkan efek Skeletonizer.',
        'Null -> Hidden berlaku untuk setiap atribut subtitle, badge, maupun icon di dalam card.',
      ],
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                AppCardStyle1(
                  variant: AppCardStyle1Variant.solid,
                  imageUrl:
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=600&q=80',
                  title: 'Sophie Bennett',
                  subtitle: 'Product Designer',
                  isVerified: true,
                  onButtonTap: () {},
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
                  isFavorite: true,
                  progress: 0.35,
                  onButtonTap: () {},
                ),
                SizedBox(width: AppScale.w(16)),
                AppCardStyle3(
                  imageUrl:
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=600&q=80',
                  title: 'Santorini Loft',
                  price: '\$890',
                  rating: 4.8,
                  onButtonTap: () {},
                ),
                SizedBox(width: AppScale.w(16)),
                AppCardStyle4(
                  imageUrl:
                      'https://images.unsplash.com/photo-1542314831-c6a4d14b837c?auto=format&fit=crop&w=600&q=80',
                  category: 'Deluxe Room',
                  title: 'Sao Pulo Hotel',
                  location: 'Ubud, Bali',
                  rating: 4.9,
                ),
                SizedBox(width: AppScale.w(16)),
                AppCardStyle5(
                  imageUrl:
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80',
                  title: 'Sam Rivers',
                  subtitle: 'Photographer',
                  stats: [AppCardStyle5Stat(title: 'Rating', value: '4.9')],
                  onPrimaryButtonTap: () {},
                ),
                SizedBox(width: AppScale.w(16)),
                AppCardStyle6(
                  imageUrl:
                      'https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&w=600&q=80',
                  title: 'Film Coverage Guide',
                  author: 'By Cameron',
                  tagText: 'Production',
                ),
                SizedBox(width: AppScale.w(16)),
                AppCardStyle7(
                  imageUrl:
                      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=200&q=80',
                  title: 'Richard Wyatt',
                  subtitle: 'Director',
                  badgeText: 'Mentor',
                ),
                SizedBox(width: AppScale.w(16)),
                AppCardStyle8(
                  isMax: false,
                  imageUrl: 'https://logo.clearbit.com/stripe.com',
                  title: 'Stripe',
                  subtitle: 'Payment APIs',
                  description: 'A suite of payment APIs.',
                ),
              ],
            ),
          ),
          SizedBox(height: AppScale.h(24)),
          AppCardDetail1(
            imageUrl:
                'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=800&q=80',
            title: 'Help Children for Better Education',
            avatarUrls: [
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80',
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=100&q=80',
            ],
            donorTotalCount: 345,
            progressLabel: 'Statistic Progress',
            timeLeftText: '6 hrs left',
            progress: 0.62,
            raisedAmount: '\$47,650',
            description:
                'This is a description of the card detail which supports full width and detailed data representations.',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCardsSection() {
    return DemoSection(
      sectionKey: controller.categories[13].key,
      title: 'Profile Cards',
      description: 'Kartu profil dengan badge, statistik dan avatar besar.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AppProfileCard1(
              imageUrl:
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
              title: 'Tobias Whetton',
              subtitle: '@tobias',
              footerItem1: const AppProfileCard1FooterItem(
                value: '321',
                label: 'Points',
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: AppProfileCard2.network(
              imageUrl:
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
              name: 'Sarah Johnson',
              email: 'sarah.j@email.com',
              badgeText: 'Premium Member',
              badgeBackgroundColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverviewSection() {
    return DemoSection(
      sectionKey: controller.categories[14].key,
      title: 'Stats Overview',
      description: 'Card ringkasan statistik, saldo, dan laporan.',
      child: Column(
        children: [
          AppStatsOverview1(
            title: 'Hey, Sandro',
            subtitle: 'Balance',
            value: '\$23,540.00',
            onTap: () {},
          ),
          SizedBox(height: 16),
          AppStatsGlassyStyle(
            title: 'Membership',
            icon: HeroIcons.sparkles,
            value: 'Premium Plan',
            label: 'annual.plan',
          ),
          SizedBox(height: 16),
          AppStatsGlassyStyle(
            backgroundColor: AppColors.neutral900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Custom Content',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Via child parameter',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
                AppButton.icon(
                  icon: Icons.arrow_forward,
                  onPressed: () {},
                  color: Colors.white24,
                  textColor: Colors.white,
                  size: AppButtonSize.small,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtensionsSection(BuildContext context) {
    bool isDark = controller.isDarkMode.value;
    return DemoSection(
      sectionKey: controller.categories[15].key,
      title: 'Extensions (Glassy & Animated)',
      description:
          'Widget extension khusus dari UI kit ini seperti `.glassy()` dan `.animated()`.',
      rules: const [
        'Gunakan .glassy(blurred: 30) pada widget apa saja untuk efek glassmorphism',
        'Gunakan .animated(variant: AppAnimationVariant.float) untuk micro-interactions',
      ],
      codeSnippet:
          "Container().glassy(blurred: 30);\nIcon(Icons.star).animated(variant: AppAnimationVariant.shake);",
      child: Container(
        padding: EdgeInsets.all(AppScale.w(16)),
        decoration: BoxDecoration(
          color: isDark ? AppColors.neutral800 : AppColors.neutral200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: AppScale.h(100),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A3AFF), Color(0xFFE843AD)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'I am Glassy',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).glassy(blurred: 20),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: AppColors.primary,
                  size: 32,
                ).animated(variant: AppAnimationVariant.floatVertical),
                Icon(
                  Icons.notifications,
                  color: AppColors.warning,
                  size: 32,
                ).animated(variant: AppAnimationVariant.shake),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // HELPERS
  // ==========================================

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

class DemoSliverPage extends StatelessWidget {
  const DemoSliverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          AppMainAppBar(
            title: 'Sliver Search App Bar',
            onBack: () => Get.back(),
            onSearch: (val) {
              debugPrint('Search: $val');
            },
            onReset: () {
              debugPrint('Search reset');
            },
            actions: [
              IconButton(
                icon: const HeroIcon(HeroIcons.bell, color: Colors.white),
                onPressed: () {},
              ),
            ],
            // Custom radius lengkungan yang diminta user
            borderRadius: AppScale.r(24),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppScale.w(16)),
              child: Column(
                children: List.generate(
                  20,
                  (index) => Container(
                    height: AppScale.h(80),
                    margin: EdgeInsets.only(bottom: AppScale.h(16)),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppScale.r(12)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Scroll Item ${index + 1}',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
