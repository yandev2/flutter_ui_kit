import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Konfigurasi skala responsif untuk seluruh komponen package.
class AppScaleConfig {
  /// Ukuran desain referensi (default: iPhone X).
  final Size designSize;

  /// Opsi [ScreenUtilInit].
  final bool minTextAdapt;
  final bool splitScreenMode;

  /// Pengali global di atas skala ScreenUtil.
  final double scaleFactor;

  /// Batas bawah dan atas skala setelah dihitung.
  final double minScale;
  final double maxScale;

  /// Aktifkan pembatasan skala agar UI tidak membesar tanpa batas di layar lebar.
  final bool enableScaleCap;

  /// Terapkan cap otomatis saat berjalan di web.
  final bool autoCapOnWeb;

  /// Terapkan cap otomatis saat lebar layar melebihi nilai ini.
  final double? autoCapBreakpoint;

  const AppScaleConfig({
    this.designSize = const Size(375, 812),
    this.minTextAdapt = true,
    this.splitScreenMode = true,
    this.scaleFactor = 1.0,
    this.minScale = 0.8,
    this.maxScale = 1.25,
    this.enableScaleCap = true,
    this.autoCapOnWeb = true,
    this.autoCapBreakpoint = 600,
  });

  /// Skala penuh seperti desain mobile (cocok untuk app native).
  const AppScaleConfig.mobile({
    this.designSize = const Size(375, 812),
    this.minTextAdapt = true,
    this.splitScreenMode = true,
    this.scaleFactor = 1.0,
    this.minScale = 0.85,
    this.maxScale = 1.5,
    this.enableScaleCap = true,
    this.autoCapOnWeb = false,
  }) : autoCapBreakpoint = null;

  /// Skala lebih ketat untuk web / layar lebar agar komponen tidak terlalu besar.
  const AppScaleConfig.web({
    this.designSize = const Size(375, 812),
    this.minTextAdapt = true,
    this.splitScreenMode = true,
    this.scaleFactor = 1.0,
    this.minScale = 0.85,
    this.maxScale = 1.0,
    this.enableScaleCap = true,
    this.autoCapOnWeb = true,
    this.autoCapBreakpoint = 480,
  });

  /// Otomatis pilih preset web atau mobile berdasarkan platform.
  factory AppScaleConfig.adaptive({
    Size designSize = const Size(375, 812),
    double scaleFactor = 1.0,
  }) {
    if (kIsWeb) {
      return AppScaleConfig.web(
        designSize: designSize,
        scaleFactor: scaleFactor,
      );
    }
    return AppScaleConfig.mobile(
      designSize: designSize,
      scaleFactor: scaleFactor,
    );
  }

  AppScaleConfig copyWith({
    Size? designSize,
    bool? minTextAdapt,
    bool? splitScreenMode,
    double? scaleFactor,
    double? minScale,
    double? maxScale,
    bool? enableScaleCap,
    bool? autoCapOnWeb,
    double? autoCapBreakpoint,
    bool clearAutoCapBreakpoint = false,
  }) {
    return AppScaleConfig(
      designSize: designSize ?? this.designSize,
      minTextAdapt: minTextAdapt ?? this.minTextAdapt,
      splitScreenMode: splitScreenMode ?? this.splitScreenMode,
      scaleFactor: scaleFactor ?? this.scaleFactor,
      minScale: minScale ?? this.minScale,
      maxScale: maxScale ?? this.maxScale,
      enableScaleCap: enableScaleCap ?? this.enableScaleCap,
      autoCapOnWeb: autoCapOnWeb ?? this.autoCapOnWeb,
      autoCapBreakpoint: clearAutoCapBreakpoint
          ? null
          : (autoCapBreakpoint ?? this.autoCapBreakpoint),
    );
  }
}

/// Scope konfigurasi skala. Bisa di-override di subtree jika diperlukan.
class AppScaleScope extends InheritedWidget {
  final AppScaleConfig config;

  const AppScaleScope({
    super.key,
    required this.config,
    required super.child,
  });

  static AppScaleConfig? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppScaleScope>()
        ?.config;
  }

  static AppScaleConfig of(BuildContext context) {
    final config = maybeOf(context);
    assert(config != null, 'AppScaleScope not found in widget tree.');
    return config!;
  }

  @override
  bool updateShouldNotify(AppScaleScope oldWidget) {
    return oldWidget.config != config;
  }
}

/// Resolver skala terpusat yang dipakai oleh [size], [sizeHeight], dan [scale].
class AppScale {
  AppScale._();

  static AppScaleConfig _rootConfig = const AppScaleConfig();

  static AppScaleConfig get rootConfig => _rootConfig;

  static void install(AppScaleConfig config) {
    _rootConfig = config;
  }

  static AppScaleConfig resolve([BuildContext? context]) {
    if (context != null) {
      final scoped = AppScaleScope.maybeOf(context);
      if (scoped != null) return scoped;
    }
    return _rootConfig;
  }

  static bool _shouldCap(AppScaleConfig config) {
    if (!config.enableScaleCap) return false;
    if (config.autoCapOnWeb && kIsWeb) return true;

    final breakpoint = config.autoCapBreakpoint;
    if (breakpoint == null) return config.enableScaleCap;

    final screenWidth = _screenWidth;
    if (screenWidth <= 0) return false;
    return screenWidth > breakpoint;
  }

  static double get _screenWidth {
    try {
      return ScreenUtil().screenWidth;
    } catch (_) {
      return 0;
    }
  }

  static double _applyCap(double rawScale, AppScaleConfig config) {
    var scale = rawScale * config.scaleFactor;
    if (_shouldCap(config)) {
      final lower = config.minScale;
      final upper = config.maxScale;
      // clamp() throws ArgumentError when lower > upper (e.g. minScale: 1.4, maxScale: 1.25).
      scale = scale.clamp(
        lower <= upper ? lower : upper,
        lower <= upper ? upper : lower,
      );
    }
    return scale;
  }

  static double scaleWidth([BuildContext? context]) {
    final config = resolve(context);
    try {
      if (ScreenUtil().screenWidth <= 0) {
        return _applyCap(1.0, config);
      }
      return _applyCap(ScreenUtil().scaleWidth, config);
    } catch (_) {
      return _applyCap(1.0, config);
    }
  }

  static double scaleHeight([BuildContext? context]) {
    final config = resolve(context);
    try {
      if (ScreenUtil().screenHeight <= 0) {
        return _applyCap(1.0, config);
      }
      return _applyCap(ScreenUtil().scaleHeight, config);
    } catch (_) {
      return _applyCap(1.0, config);
    }
  }
}

/// Inisialisasi skala responsif di root app (pengganti langsung [ScreenUtilInit]).
///
/// ```dart
/// AppScaleInit(
///   config: AppScaleConfig.adaptive(),
///   builder: (context, child) => MaterialApp(...),
/// )
/// ```
class AppScaleInit extends StatelessWidget {
  final AppScaleConfig config;
  final Widget Function(BuildContext context, Widget? child)? builder;
  final Widget? child;

  AppScaleInit({
    super.key,
    AppScaleConfig? config,
    this.builder,
    this.child,
  }) : config = config ?? AppScaleConfig.adaptive();

  @override
  Widget build(BuildContext context) {
    AppScale.install(config);

    return ScreenUtilInit(
      designSize: config.designSize,
      minTextAdapt: config.minTextAdapt,
      splitScreenMode: config.splitScreenMode,
      ensureScreenSize: kIsWeb,
      builder: (context, screenUtilChild) {
        final resolvedChild = builder?.call(context, screenUtilChild) ??
            child ??
            screenUtilChild ??
            const SizedBox.shrink();

        return AppScaleScope(
          config: config,
          child: resolvedChild,
        );
      },
      child: child,
    );
  }
}

/// Skala lebar responsif untuk ukuran horizontal (padding, font, icon, dll).
double size(num value, [BuildContext? context]) {
  return value * AppScale.scaleWidth(context);
}

/// Skala tinggi responsif untuk ukuran vertikal.
double sizeHeight(num value, [BuildContext? context]) {
  return value * AppScale.scaleHeight(context);
}

/// Faktor skala lebar saat ini.
double scale([BuildContext? context]) {
  return AppScale.scaleWidth(context);
}

/// Extension agar skala bisa diakses dari [BuildContext].
extension AppScaleContextExtension on BuildContext {
  AppScaleConfig get appScaleConfig => AppScale.resolve(this);

  double appSize(num value) => size(value, this);

  double appSizeHeight(num value) => sizeHeight(value, this);

  double get appScale => scale(this);
}
