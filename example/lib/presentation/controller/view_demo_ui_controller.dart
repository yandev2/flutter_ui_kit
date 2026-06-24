import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_ui_kit/ui/inputs/app_time_picker.dart';

class DemoCategory {
  final String title;
  final GlobalKey key;

  DemoCategory(this.title) : key = GlobalKey();
}

class ViewDemoUiController extends GetxController {
  // Theme state
  RxBool isDarkMode = false.obs;

  // Sidebar & Scrolling State
  final ScrollController scrollController = ScrollController();
  RxInt selectedCategoryIndex = 0.obs;

  final List<DemoCategory> categories = [
    DemoCategory('Dialogs'),
    DemoCategory('Buttons'),
    DemoCategory('Inputs (Selection)'),
    DemoCategory('Switches & Segmented'),
    DemoCategory('Dropdowns'),
    DemoCategory('TextFields & Forms'),
    DemoCategory('Navigation Bars'),
    DemoCategory('Date & Time Pickers'),
    DemoCategory('Status & Empty States'),
    DemoCategory('Snackbars (Toasts)'),
    DemoCategory('Avatar Stack & Timeline'),
    DemoCategory('Progress & Percent'),
    DemoCategory('Data Cards'),
    DemoCategory('Profile Cards'),
    DemoCategory('Stats Overview'),
    DemoCategory('Extensions'),
  ];

  void scrollToCategory(int index) {
    selectedCategoryIndex.value = index;
    final context = categories[index].key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    // Note: On mobile, we might want to close the drawer here.
    // Note: On mobile, we close the drawer.
    if (Get.width < 800) {
      Get.back();
    }
  }

  // Input states
  RxBool checkPill1 = true.obs;
  RxBool checkPill2 = false.obs;
  RxString radioPillGroup = 'yes'.obs;

  RxBool check1 = true.obs;
  RxBool check2 = false.obs;
  RxString radioGroup1 = 'opt1'.obs;

  RxBool checkTile1 = true.obs;
  RxBool checkTile2 = false.obs;

  // Switch states
  RxBool switchVal = true.obs;
  RxInt segmentedVal = 0.obs;

  RxBool isSwitchOn = false.obs;
  var selectedRadio = ''.obs;

  // Picker States
  var selectedDate = Rxn<DateTime>();
  var selectedTime = Rxn<AppTimeData>();
  var selectedYear = Rxn<int>();
  var selectedMonth = Rxn<int>();

  // Input lists
  RxnString dropdownVal = RxnString(null);
  RxList<String> dropdownMultiVal = <String>[].obs;

  // Image Upload State
  RxnString uploadedImagePath = RxnString(null);

  // Currency state
  RxString currencyType = 'Rp'.obs; // 'Rp' or 'USD'

  // Navigation Bar state
  RxInt navIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isPlatformDarkMode;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
