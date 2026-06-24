import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScale {
  // Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  static const double maxDesktopWidth = 1200.0;

  // Device type checkers
  static bool get isMobile => Get.width < mobileBreakpoint;
  static bool get isTablet => Get.width >= mobileBreakpoint && Get.width < tabletBreakpoint;
  static bool get isDesktop => Get.width >= tabletBreakpoint;

  // Responsive scaling wrappers
  // Jika di desktop/web, kita kembalikan ukuran aslinya agar tidak membesar gila-gilaan.
  // Jika di mobile, gunakan ScreenUtil (.w, .h, .sp, .r).

  static double w(double size) => isDesktop ? size : size.w;
  static double h(double size) => isDesktop ? size : size.h;
  static double sp(double size) => isDesktop ? size : size.sp;
  static double r(double size) => isDesktop ? size : size.r;

  // Utility untuk constraint width maksimum di Web
  static double get responsiveMaxWidth => isDesktop ? maxDesktopWidth : Get.width;
}
