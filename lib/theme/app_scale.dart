import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

// Kita membatasi scale maksimal menjadi 1.2 (atau sesuai selera)
// Tujuannya agar ketika dibuka di Web, Desktop, atau Tablet (layar lebar),
// komponen UI tidak ikut membesar menjadi raksasa, melainkan mentok di skala wajar.
double _getScale(double currentScale) {
  return min(currentScale, 1.4);
}

double size(num size) {
  return size * _getScale(ScreenUtil().scaleWidth);
}

double scale() {
  return _getScale(ScreenUtil().scaleWidth);
}

double sizeHeight(num size) {
  return size * _getScale(ScreenUtil().scaleHeight);
}
