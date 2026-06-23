import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_ui_kit/ui/inputs/app_time_picker.dart';

class ViewDemoUiController extends GetxController {
  // Theme state
  RxBool isDarkMode = false.obs;

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

  // Currency state
  RxString currencyType = 'Rp'.obs; // 'Rp' or 'USD'

  // Navigation Bar state
  RxInt navIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi status dark mode berdasarkan tema sistem saat ini
    isDarkMode.value = Get.isPlatformDarkMode;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
