# UI Component Flutter

A highly customizable and fully responsive Flutter UI Component package. Built with modern design system principles (Material 3), providing seamless support for Light and Dark modes using Flutter's native `ThemeExtension`.

## Requirements

| | Minimum |
|---|---|
| Flutter | `>=3.44.0` |
| Dart | `^3.12.0` |

## Installation

```yaml
dependencies:
  ui_component_flutter:
    path: ../ui_component_flutter   # ganti dengan git URL atau pub.dev jika sudah publish
```

```bash
flutter pub get
```

## Table of Contents

- [Features](#features)
- [Getting Started — Initialization](#-getting-started)
- [Responsive Scale (`AppScale`)](#-responsive-scale-appscale)
- [Customize Theme](#-how-to-customize-the-theme)
- [Extensions](#-extensions)
- [Components](#-components)
- [Dependencies](#-dependencies)
- [Component Index](#-component-index)

## Features
- **Responsive by Default**: All components scale via `AppScaleInit` (built on `flutter_screenutil`) with web-friendly scale capping — no more oversized UI on Flutter Web.
- **Material 3 Theme**: `ColorScheme`, `InputDecorationTheme`, button themes, and complete on-colors (`onPrimary`, `onSurface`, etc.).
- **Modern Input APIs**: Autofill, `textInputAction`, `onSubmitted`, `onEditingComplete`, `onTapOutside`, and `maxLength` support across text input components.
- **First-class Dark Mode**: Semantic colors and backgrounds optimized for dark mode to prevent eye strain.
- **Web-ready**: Conditional imports for offline images, WASM-safe paths, and capped responsive scale on wide viewports.
- **Fully Customizable**: Override colors, spacing, typography, form fill colors, timeline indicators, or responsive scale using `copyWith` without messy inheritance trees.

---

## 🚀 Getting Started

### 1. Initialization

Because this package is responsive based on a design scale, you **must** wrap your `MaterialApp` with [`AppScaleInit`](lib/theme/app_scale.dart). It replaces direct usage of `ScreenUtilInit` and prevents oversized UI on web / wide screens.

```dart
import 'package:flutter/material.dart';
import 'package:ui_component_flutter/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaleInit(
      // Recommended: auto-select preset for web vs native mobile
      config: AppScaleConfig.adaptive(
        designSize: const Size(375, 812),
      ),
      builder: (context, child) {
        return MaterialApp(
          title: 'My App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const MyHomePage(),
        );
      },
    );
  }
}
```

> **Note:** You no longer need to import `flutter_screenutil` in your app root. `AppScaleInit` handles `ScreenUtilInit` internally.

---

## 📐 Responsive Scale (`AppScale`)

All components in this package use global helpers from [`lib/theme/app_scale.dart`](lib/theme/app_scale.dart):

| Function | Description |
|----------|-------------|
| `size(16)` | Scale horizontal values (padding, width, font size, icon size) |
| `sizeHeight(12)` | Scale vertical values (height, vertical padding) |
| `scale()` | Current width scale factor |

### Why `AppScaleInit`?

On wide screens (especially **Flutter Web**), raw `ScreenUtil` scale can grow very large (`screenWidth / designWidth`). For example, at 1440px width with design 375px, scale ≈ **3.84×** — buttons, inputs, and text become huge.

`AppScaleInit` applies configurable **scale caps** so UI stays readable on desktop/web while remaining responsive on phones.

### Presets

| Preset | Best for | Default `maxScale` | Web cap |
|--------|----------|-------------------|---------|
| `AppScaleConfig.adaptive()` | Most apps (recommended) | web: `1.0`, mobile: `1.5` | Auto on web |
| `AppScaleConfig.web()` | Web / desktop / wide layout | `1.0` | Always capped on web |
| `AppScaleConfig.mobile()` | Native mobile apps | `1.5` | No web-specific cap |
| `AppScaleConfig(...)` | Full manual control | `1.25` (default) | Configurable |

```dart
// Web-first app
AppScaleInit(
  config: AppScaleConfig.web(
    designSize: const Size(375, 812),
  ),
  builder: (context, child) => MaterialApp(...),
)

// Native mobile app (more scaling room on tablets)
AppScaleInit(
  config: AppScaleConfig.mobile(
    designSize: const Size(375, 812),
  ),
  builder: (context, child) => MaterialApp(...),
)
```

### `AppScaleConfig` properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `designSize` | `Size` | `375 × 812` | Design draft reference size |
| `minTextAdapt` | `bool` | `true` | Passed to `ScreenUtilInit` |
| `splitScreenMode` | `bool` | `true` | Passed to `ScreenUtilInit` |
| `scaleFactor` | `double` | `1.0` | Global multiplier applied after ScreenUtil scale |
| `minScale` | `double` | `0.8` – `0.85` | Minimum allowed scale when cap is active |
| `maxScale` | `double` | `1.0` – `1.5` | Maximum allowed scale when cap is active |
| `enableScaleCap` | `bool` | `true` | Enable min/max scale clamping |
| `autoCapOnWeb` | `bool` | `true` (web preset) | Apply cap automatically on web |
| `autoCapBreakpoint` | `double?` | `600` / `480` | Apply cap when screen width exceeds this value |

### Custom configuration

```dart
AppScaleInit(
  config: AppScaleConfig(
    designSize: const Size(390, 844),
    scaleFactor: 1.0,
    minScale: 0.85,
    maxScale: 1.1,           // Tight cap for dashboard-style web UI
    enableScaleCap: true,
    autoCapOnWeb: true,
    autoCapBreakpoint: 768,  // Cap when width > 768px
  ),
  builder: (context, child) => MaterialApp(...),
)
```

Disable capping entirely (legacy ScreenUtil-like behavior):

```dart
AppScaleInit(
  config: const AppScaleConfig(
    enableScaleCap: false,
  ),
  builder: (context, child) => MaterialApp(...),
)
```

### Override scale in a subtree

Use `AppScaleScope` when a specific screen needs different scale rules (e.g. a wide admin panel):

```dart
AppScaleScope(
  config: AppScaleConfig.web(maxScale: 0.95),
  child: AdminDashboardPage(),
)
```

### Using scale in your own widgets

```dart
import 'package:ui_component_flutter/theme/theme.dart';

Container(
  padding: EdgeInsets.all(size(16)),
  height: sizeHeight(48),
  child: Text(
    'Hello',
    style: TextStyle(fontSize: size(14)),
  ),
)
```

Optional: pass `BuildContext` to respect a scoped `AppScaleScope`:

```dart
padding: EdgeInsets.all(size(16, context)),
fontSize: context.appSize(14),
height: context.appSizeHeight(48),
final factor = context.appScale;
final config = context.appScaleConfig;
```

### Testing

Wrap your widget under test with `AppScaleInit`:

```dart
await tester.pumpWidget(
  AppScaleInit(
    config: const AppScaleConfig(designSize: Size(375, 812)),
    child: const MyApp(),
  ),
);
```

If your `MyApp` already includes `AppScaleInit`, pump it directly:

```dart
await tester.pumpWidget(const MyApp());
```

### Migration from `ScreenUtilInit`

| Before | After |
|--------|-------|
| `ScreenUtilInit(designSize: ..., builder: ...)` | `AppScaleInit(config: AppScaleConfig(...), builder: ...)` |
| `import 'package:flutter_screenutil/flutter_screenutil.dart';` | `import 'package:ui_component_flutter/theme/theme.dart';` |
| Manual scale via `ScreenUtil().scaleWidth` | `size()`, `sizeHeight()`, or `scale()` |

---

## 🎨 How to Customize the Theme

This package uses Flutter's `ThemeExtension` and Material 3 `ThemeData`, meaning you are not locked into our default "Sky Blue" primary color. You can override **any** base color, semantic color, or component color.

`AppTheme.lightTheme` / `AppTheme.darkTheme` already include:

- `ColorScheme` with full on-colors (`onPrimary`, `onSecondary`, `onError`, `onSurface`, …)
- `appBarTheme` — primary background, foreground, icon theme
- `inputDecorationTheme` — filled inputs, dense layout, borderless style
- `elevatedButtonTheme`, `outlinedButtonTheme`, `textButtonTheme`
- `UIComponentTheme` extension via `context.uiTheme`

### Customizing Colors (Light Mode)

To customize the colors, you copy the default `lightTheme` and inject your own color preferences into `defaultUIComponentThemeLight`:

```dart
MaterialApp(
  title: 'My Custom App',
  theme: AppTheme.lightTheme.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6200EE),
      foregroundColor: Colors.white,
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppTheme.defaultUIComponentThemeLight.copyWith(
        primary: const Color(0xFF6200EE),
        secondary: Colors.amber,
        success: Colors.teal,
        cardColor: Colors.white,
        disabledColor: Colors.grey,
      ),
    ],
  ),
  home: const MyHomePage(),
);
```

> Wrap `MaterialApp` inside `AppScaleInit` at the root (see [Getting Started](#-getting-started)).

### Customizing Colors (Dark Mode)

You can apply the same logic to `darkTheme` if you want to tweak how your custom colors look in dark mode (e.g. lowering the saturation):

```dart
MaterialApp(
  // ...
  darkTheme: AppTheme.darkTheme.copyWith(
    extensions: <ThemeExtension<dynamic>>[
      AppTheme.defaultUIComponentThemeDark.copyWith(
        primary: const Color(0xFFBB86FC), // Lighter custom primary for Dark Mode
        success: Colors.tealAccent,
      ),
    ],
  ),
  // ...
)
```

### Available Color Properties
You can customize all of the following properties inside the `copyWith`:

**Base Colors:**
- `primary`, `secondary`, `background`, `surface`, `cardColor`, `error`

**Semantic Colors:**
- `success`, `info`, `warning`, `danger`

**Component Specific Colors:**
- `borderColor`, `disabledColor`, `hintColor`, `shadowColor`

**On-Colors (Text/Icons on top of base colors):**
- `onPrimary`, `onSecondary`, `onBackground`, `onSurface`, `onError`

---

## 💡 Usage in UI

To use these colors in your own widgets, simply call the `context.uiTheme` extension:

```dart
Container(
  color: context.uiTheme.primary,
  padding: EdgeInsets.all(AppSpacing.md),
  child: Text(
    'Hello World',
    style: context.uiTheme.bodyStyle.copyWith(
      color: context.uiTheme.onPrimary,
    ),
  ),
)
```

---

## 🛠️ Extensions

This package provides a set of highly useful extensions to speed up UI development and formatting.

### Date Extensions
Format your `DateTime` objects into readable strings easily, or parse custom date strings back into `DateTime`.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Format Date to String
final date = DateTime(2023, 8, 17);
print(date.formatted(AppDateTimeFormat.dmyFullMonth)); // "17 Agustus 2023"

// 2. Parse String back to Date (Reverse Parse)
final parsed = "17 Agustus 2023".toDate(AppDateTimeFormat.dmyFullMonth);
print(parsed); // DateTime(2023, 8, 17)
```

### Number Extensions
Format your numbers into percentages or apply thousand separators. 

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Percentage
0.55.toPercent(); // "55%"
0.556.toPercent(fractionDigits: 1, useComma: true); // "55,6%"
1.5.toPercent(isFraction: true); // "150%" 

// 2. Thousand Separator
12500000.toThousandFormat(); // "12.500.000"
12500000.toThousandFormat(separator: ','); // "12,500,000"

// 3. String to Percent Fraction (Reverse Parse)
"85.5%".toPercentFraction(); // 0.855
```

### Animated Widget Extension
Easily add looping micro-animations to any widget without boilerplate `AnimationController` code. Perfect for drawing user attention.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// Make a widget float up and down
Icon(Icons.arrow_upward).animated(
  variant: AppAnimationVariant.floatVertical,
  intensity: 0.8,
);

// Make a widget shake
Container(
  child: Text("Error!"),
).animated(
  variant: AppAnimationVariant.shake,
);
```

### Currency Extensions
A comprehensive and robust currency formatter that uses the `intl` package underneath.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Basic Currency Formatting (Rupiah & Dollar)
50000.toRupiah(); // "Rp 50.000"
50.75.toDollar(); // "$50.75"

// 2. Custom Formatting (Other Currencies, Decimal Digits)
15000.75.toCurrency(
  type: AppCurrencyType.euro, 
  decimalDigits: 2, 
  symbolSeparator: ' '
); // "€ 15.000,75" (Depends on European locale)

// 3. Compact Formatting (Thousands, Millions, Billions)
1500000.toRupiah(compact: true); // "Rp 1,5 jt"

// 4. String to Currency Number (Reverse Parse)
"Rp 15.000,50".toCurrencyFraction(); // 15000.5
```

### String Extensions
Supercharge your standard `String` type with parsers, validators, and formatters.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Parsing Safely
"15".toIntOrNull(); // 15
"abc".toInt(defaultValue: 0); // 0

// 2. Case Manipulators
"hello world".toTitleCase(); // "Hello World"
"hello world".toCamelCase(); // "helloWorld"
"HelloWorld".toSnakeCase(); // "hello_world"
"HelloWorld".toKebabCase(); // "hello-world"

// 3. UI Helpers
"A very long text".truncate(10); // "A very lon..."
"#FF5733".toColor(); // Returns Color(0xFFFF5733)

// 4. Built-in Validators
"user@email.com".isEmail; // true
"https://flutter.dev".isUrl; // true
"HelloWorld123".isAlphabet; // false
"StrongP@ssw0rd".isStrongPassword; // true

// 5. Extract Pure Data (Very useful after MaskInputFormatter)
"12.345.678.9-012.000".toNumericOnly(); // "123456789012000"
"ID-1234 A".toAlphaNumericOnly(); // "ID1234A"
```

### Widget Extensions
Say goodbye to the "Nesting Hell". Write cleaner, declarative Flutter UI code without wrapping everything in structural widgets manually.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// ❌ Traditional Nesting
Padding(
  padding: const EdgeInsets.all(16.0),
  child: Center(
    child: Expanded(
      child: Text('Hello Flutter'),
    ),
  ),
);

// ✅ Clean Declarative UI (Using WidgetExtension)
Text('Hello Flutter')
  .expanded()
  .center()
  .paddingAll(16)
  .backgroundColor(Colors.blue)
  .clipRRect(radius: 8)
  .onInkTap(() {
    print('Tapped!');
  });
```

### Glassy Extension (Glassmorphism)
Instantly apply a beautiful, modern glassmorphism effect to any widget. Perfect for modals, floating cards, or modern UI overlays.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// Apply default frosted glass effect
Container(
  padding: EdgeInsets.all(20),
  child: Text('Glassy Card'),
).glassy();

// Use different presets
Container(...).glassy(variant: AppGlassyVariant.smooth);
Container(...).glassy(variant: AppGlassyVariant.dew);
Container(...).glassy(variant: AppGlassyVariant.heavy);
```

### Currency Input Formatter
Format input `TextField` secara otomatis menjadi mata uang (Rupiah, Dollar, dll.) secara *real-time* dengan memanipulasi posisi desimal saat pengetikan dari kanan ke kiri.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

TextField(
  keyboardType: TextInputType.number,
  inputFormatters: [
    CurrencyInputFormatter(
      type: AppCurrencyType.rupiah,
      showSymbol: true, // "Rp 15.000"
    ),
  ],
)

TextField(
  keyboardType: TextInputType.number,
  inputFormatters: [
    CurrencyInputFormatter(
      type: AppCurrencyType.dollar,
      decimalDigits: 2, 
      showSymbol: true,
      symbolSeparator: '', // "$15.00"
    ),
  ],
)
```

### Generic & Utility Formatters
Kumpulan *formatter* siap pakai untuk mempercepat *development* komponen input data penting.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Text Case Formatter (Misal untuk Kode Promo / NIK KTP)
TextField(
  inputFormatters: [
    UpperCaseTextFormatter(), // "HELLO WORLD"
    // LowerCaseTextFormatter(), // "hello world"
  ],
)

// 2. Anti-Spasi (Untuk Email / Username)
TextField(
  inputFormatters: [
    NoSpaceFormatter(), // "user@email.com"
  ],
)

// 3. Mask Input Formatter (KTP, NPWP, Nomor HP, Kartu Kredit)
TextField(
  inputFormatters: [
    // Kartu Kredit
    MaskInputFormatter(mask: '#### #### #### ####'),
    // NPWP
    MaskInputFormatter(mask: '##.###.###.#-###.###'),
    // Nomor HP
    MaskInputFormatter(mask: '####-####-####-####'),
  ],
)

// 4. Card Expiry Formatter (Otomatis sisipkan slash dan batasi max bulan 12)
TextField(
  inputFormatters: [
    CardExpiryFormatter(), // ketik "1225" otomatis jadi "12/25"
  ],
)
```

## 🔘 Components

### AppButton
Sebuah komponen tombol super fleksibel yang sudah mengikuti standar desain *scale* (responsif). Anda tidak perlu lagi repot membuat berbagai jenis tombol secara manual. Mendukung berbagai *variant*, ukuran, bentuk, dan posisi ikon!

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Tombol Biasa (Solid)
AppButton(
  text: 'Submit Data',
  onPressed: () => print('Tapped!'),
)

// 2. Tombol dengan Variant & Shape Berbeda
AppButton(
  text: 'Cancel',
  variant: AppButtonVariant.outline, // outline, dashed, smooth, gradient, raised, text
  shape: AppButtonShape.pill,        // rounded, pill, circle, square
  color: context.uiTheme.danger,
  onPressed: () {},
)

// 3. Tombol dengan Ikon
AppButton(
  text: 'Checkout',
  icon: Icons.shopping_cart,
  iconPosition: IconPosition.right, // Kiri, Kanan, atau Atas
  size: AppButtonSize.large,
  isMax: true,
  onPressed: () {},
)

// 4. Tombol Khusus Ikon (Icon-Only)
AppButton.icon(
  icon: Icons.add,
  shape: AppButtonShape.circle,
  onPressed: () {},
)

// 5. Loading State Otomatis
AppButton(
  text: 'Save',
  isLoading: true, // Akan otomatis merender CircularProgressIndicator
  onPressed: () {},
)

// 6. Custom Text Style
AppButton(
  text: 'Subscribe',
  textStyle: const TextStyle(
    letterSpacing: 1.2,
    fontWeight: FontWeight.w600,
  ),
  onPressed: () {},
)
```

| Property | Type | Description |
|----------|------|-------------|
| `textStyle` | `TextStyle?` | Gaya teks custom (fontFamily, letterSpacing, dll.) |
| `textColor` | `Color?` | Override warna teks (prioritas di atas `textStyle.color`) |
| `textSize` | `double?` | Override ukuran font (prioritas di atas `textStyle.fontSize`) |

### AppDialog
Sebuah helper dan komponen untuk memunculkan modal dialog dinamis. Terintegrasi mulus dengan `showDialog` murni bawaan Flutter dan mewarisi properti tema aplikasi (sehingga anti repot saat pindah mode Terang/Gelap). Komponen ini juga memakai ukuran responsif secara menyeluruh!

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `description` | `String?` | Teks deskripsi; jika `null`, widget deskripsi disembunyikan |
| `titleSize` | `double?` | Ukuran font title (default `20`, diskalakan via `size()`) |

Gunakan `AppDialog.show(...)` atau top-level `showAppDialog(...)` — keduanya setara.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Tampilkan Dialog Sederhana
AppDialog.show(
  context,
  title: 'Transaksi Berhasil',
  description: 'Pembayaran sebesar Rp 150.000 telah diterima.',
  variant: AppDialogVariant.success, // success, error, info, warning
  textRight: 'Tutup',
  onRight: () => print('Closed'),
);

// 2. Dialog dengan Tombol Kiri & Kanan
AppDialog.show(
  context,
  title: 'Hapus Data?',
  description: 'Data yang telah dihapus tidak dapat dikembalikan.',
  variant: AppDialogVariant.error,
  textLeft: 'Batal',
  textRight: 'Hapus',
  onRight: () => hapusData(), // onLeft otomatis melakukan Navigator.pop(context) jika tidak diisi
);

// 3. Dialog tanpa deskripsi + title custom size
showAppDialog(
  context,
  title: 'Konfirmasi',
  titleSize: 22,
  variant: AppDialogVariant.info,
  textRight: 'OK',
);

// 4. Dialog dengan Gambar dan Konten Custom
AppDialog.show(
  context,
  title: 'Promo Spesial',
  description: 'Dapatkan diskon 50%',
  imageUrl: 'https://domain.com/promo.png',
  imageHeight: 180, // Bisa set custom tinggi!
  imageFit: BoxFit.cover, // Atur fit gambar
  content: Row(children: [ /* Bintang-bintang dsb */ ]),
  textRight: 'Klaim',
);
```

### AppImageViewerDialog
Komponen mutakhir untuk menampilkan gambar dalam mode *fullscreen* (layar penuh) dengan dukungan *Interactive Viewer* (bisa di-zoom/pan dengan dua jari). Mendukung pemuatan gambar dari *Online* maupun *Offline* dengan aman dan responsif.

```dart
// 1. Tampilkan Gambar dari Internet (Otomatis dilindungi CachedNetworkImage & Skeleton)
AppImageViewerDialog.showOnline(
  context,
  imageUrl: 'https://domain.com/photo.jpg',
);

// 2. Tampilkan Gambar dari Storage Device (Aman di Web via conditional import)
AppImageViewerDialog.showOffline(
  context,
  imagePath: '/storage/emulated/0/DCIM/photo.jpg',
);
```

### AppBottomNavigation
Komponen navigasi bagian bawah layar yang animatif dan responsif. Mendukung penskalaan sempurna, tema dinamis (Mode Terang/Gelap), serta dilengkapi dengan animasi sentuhan (skala membesar, teks menebal, dan *indicator bar* menawan).

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

int _currentIndex = 0;

final List<AppBottomNavItem> _navItems = [
  AppBottomNavItem(label: 'Home', icon: HeroIcons.home),
  AppBottomNavItem(label: 'Explore', icon: HeroIcons.magnifyingGlass),
  AppBottomNavItem(label: 'Profile', icon: HeroIcons.user),
];

// Gunakan pada Scaffold Anda
Scaffold(
  body: Center(child: Text('Tampilan Halaman')),
  bottomNavigationBar: AppBottomNavigation(
    currentIndex: _currentIndex,
    onTap: (index) {
      setState(() {
        _currentIndex = index;
      });
    },
    items: _navItems,
    
    // Pilih Varian Navigasi!
    variant: AppBottomNavigationVariant.shift, 
    // Tersedia: indicator (default), pill, dot, dan shift
    
    // Kustomisasi Opsional Lengkap
    selectedItemColor: Colors.purpleAccent, // Warna saat aktif
    unselectedItemColor: Colors.grey, // Warna saat tidak aktif
    backgroundColor: Colors.white, // Warna background bar
    shadowColor: Colors.black12, // Warna bayangan (shadow)
    iconSize: 28, // Ukuran ikon (akan diskala otomatis)
    selectedFontSize: 14, // Ukuran teks aktif
    unselectedFontSize: 12, // Ukuran teks non-aktif
    indicatorWidth: 40, // Lebar garis indikator
    indicatorHeight: 4, // Tinggi garis indikator
    elevation: 10, // Ketinggian shadow/blur radius
  ),
);
```

### AppSegmentedSwitch
Komponen switch (tab/segmen) interaktif dengan animasi slide untuk memilih satu opsi dari sekumpulan opsi. Mendukung tipe data generik (`String`, `int`, `bool`, dll) dan sangat mudah dikustomisasi (warna, padding, dan ukuran font otomatis responsif).

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Penggunaan Dasar (Tipe String)
AppSegmentedSwitch<String>(
  options: const {
    'day': 'Harian',
    'week': 'Mingguan',
    'month': 'Bulanan',
  },
  selectedValue: 'day',
  onChanged: (val) {
    print('Terpilih: $val');
  },
)

// 2. Kustomisasi Lanjutan (Tipe Integer & Warna Custom)
AppSegmentedSwitch<int>(
  options: const {
    1: 'Satu',
    2: 'Dua',
    3: 'Tiga',
  },
  selectedValue: 2,
  activeColor: context.uiTheme.success,
  backgroundColor: context.uiTheme.surface,
  activeTextColor: Colors.white,
  inactiveColor: context.uiTheme.hintColor,
  onChanged: (val) {
    print('Angka $val');
  },
)
```

### AppSwitchButton
Komponen switch (toggle) bergaya modern yang sudah sepaket dengan dukungan `title` dan `description`. Bebas dari "Nesting Hell" karena Anda tidak perlu lagi membungkus Switch dengan Row/Column secara manual!

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Switch Sederhana
AppSwitchButton(
  value: _isOn,
  onChanged: (val) => setState(() => _isOn = val),
)

// 2. Switch Lengkap dengan Judul dan Deskripsi
AppSwitchButton(
  value: _isBluetoothOn,
  title: 'Bluetooth',
  description: 'Izinkan aplikasi terhubung ke perangkat terdekat.',
  activeColor: context.uiTheme.success,
  leading: Icon(Icons.bluetooth, color: context.uiTheme.success),
  controlPosition: AppSwitchControlPosition.start, // Switch di sebelah kiri teks!
  onChanged: (val) => setState(() => _isBluetoothOn = val),
)

// 3. Switch dalam Kondisi Error/Disabled
AppSwitchButton(
  value: false,
  title: 'Lokasi (GPS)',
  description: 'Akses lokasi diperlukan untuk fitur ini.',
  enabled: false,
  errorText: 'Mohon aktifkan GPS di pengaturan.',
  onChanged: null,
)
```

### AppDatePicker
Komponen pemilih tanggal (Date Picker) dengan popup interaktif. Desain *calendar* yang *clean*, lengkap dengan animasi seleksi, status *loading*, dan warna yang sepenuhnya mengikuti `uiTheme` secara dinamis.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:heroicons/heroicons.dart';

// 1. Date Picker Sederhana
AppDatePicker(
  hint: 'Pilih Tanggal',
  value: _selectedDate,
  onChanged: (val) => setState(() => _selectedDate = val),
)

// 2. Date Picker dengan Judul dan Ikon
AppDatePicker(
  title: 'Tanggal Lahir',
  hint: 'Kapan Anda lahir?',
  prefixIcon: HeroIcons.calendarDays,
  value: _selectedDate,
  onChanged: (val) => setState(() => _selectedDate = val),
)
```

### AppYearPicker
Komponen pemilih tahun dengan popup yang menggunakan *Scroll Wheel* 3D bergaya modern. Sangat mudah digunakan untuk kasus-kasus spesifik seperti memilih Tahun Kendaraan atau Tahun Kelahiran. Warna dan ukuran sudah sepenuhnya *auto-adaptive* mengikuti *theme*.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:heroicons/heroicons.dart';

// 1. Year Picker Basic
AppYearPicker(
  hint: 'Pilih Tahun',
  value: _selectedYear, // int (contoh: 2024)
  onChanged: (val) => setState(() => _selectedYear = val),
)

// 2. Year Picker dengan Ikon dan Judul
AppYearPicker(
  title: 'Tahun Perakitan Kendaraan',
  hint: 'Pilih tahun',
  prefixIcon: HeroIcons.truck,
  value: _selectedYear,
  onChanged: (val) => setState(() => _selectedYear = val),
)
```

### AppTimePicker
Komponen pemilih waktu lengkap dengan pengaturan jam (hour), menit (minute), detik (second), serta penanda AM/PM. Menggunakan desain kolom angka yang intuitif dan elegan dengan _drop shadow_ halus dan _border_ yang interaktif terhadap status terbuka.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:heroicons/heroicons.dart';

// 1. Time Picker Basic
AppTimePicker(
  hint: 'Pilih Waktu',
  value: _selectedTime, // Objek: AppTimeData
  onChanged: (val) => setState(() => _selectedTime = val),
)

// 2. Time Picker dengan Ikon dan Judul
AppTimePicker(
  title: 'Waktu Absen',
  hint: 'Kapan Anda absen?',
  prefixIcon: HeroIcons.clock,
  value: _selectedTime,
  onChanged: (val) => setState(() => _selectedTime = val),
)
```

### AppMonthPicker
Komponen pemilih bulan dengan popup yang menggunakan *Scroll Wheel* 3D bergaya modern. Menggunakan daftar bulan standar dan mendukung semua kostumisasi tema dari komponen *picker* lainnya.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:heroicons/heroicons.dart';

// 1. Month Picker Basic
AppMonthPicker(
  hint: 'Pilih Bulan',
  value: _selectedMonth, // int (1 - 12)
  onChanged: (val) => setState(() => _selectedMonth = val),
)

// 2. Month Picker dengan Ikon dan Judul
AppMonthPicker(
  title: 'Bulan Kedatangan',
  hint: 'Pilih bulan',
  prefixIcon: HeroIcons.calendar,
  value: _selectedMonth,
  onChanged: (val) => setState(() => _selectedMonth = val),
)
```

### AppDropdown & Selection
Komponen Dropdown modern dengan dukungan *Single Select* dan *Multi Select* (berbentuk Chip), serta *Selection Tile* dan *Selection Pill* yang *composable* dan bebas dikustomisasi.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:heroicons/heroicons.dart';

// 1. Single Dropdown
AppDropdown(
  title: 'Pilih Framework',
  hint: 'Pilih satu',
  prefixIcon: HeroIcons.codeBracket,
  items: const ['Flutter', 'React Native', 'Swift'],
  value: _singleValue,
  onChanged: (val) => setState(() => _singleValue = val),
)

// 2. Multi Dropdown (dengan Chip terpilih)
AppDropdown(
  title: 'Pilih Skill',
  hint: 'Pilih beberapa',
  isMultiSelect: true,
  items: const ['Flutter', 'React Native', 'Swift'],
  selectedValues: _multiValues,
  onMultiChanged: (val) => setState(() => _multiValues = val),
)

// 3. Selection Tile
AppSelectionTile(
  control: Checkbox(value: _isSelected, onChanged: (_) {}), // Bebas menggunakan Widget control apapun
  title: 'Setuju Syarat & Ketentuan',
  description: 'Baca secara detail sebelum menyetujui',
  isSelected: _isSelected,
  onChanged: (val) => setState(() => _isSelected = val),
)

// 4. Selection Pill
AppSelectionPill(
  text: 'Label Filter',
  control: const SizedBox.shrink(), // Dapat diisi Radio/Checkbox
  isSelected: _isPillSelected,
  onChanged: (val) => setState(() => _isPillSelected = val),
)

// 5. Radio Selection
AppRadio<String>(
  value: 'A',
  groupValue: _radioValue,
  title: 'Pilihan A',
  description: 'Deskripsi untuk opsi ini',
  variant: AppRadioVariant.outline, // bisa solid, outline, atau dotOnly
  onChanged: (val) => setState(() => _radioValue = val!),
)
```

### AppTextField, AppPasswordField & AppCurrencyField
Komponen input teks modern yang *theme-aware*, dengan layout prefix/suffix yang konsisten, `fillColor` custom, dan dukungan API input Flutter terbaru.

**Fitur `AppTextField`:**
- Prefix icon (`HeroIcons`) dan suffix widget opsional — container prefix/suffix **benar-benar dihilangkan** saat null (bukan hanya icon yang disembunyikan), sehingga warna background seragam
- `fillColor` — warna background field (default: `uiTheme.background`)
- `onEditingComplete` — callback saat editing selesai, mengembalikan **nilai field saat ini**
- `onSubmitted`, `onChanged`, `autofillHints`, `textInputAction`, `maxLength`, `readOnly`, `enabled`
- Tap di luar field otomatis unfocus (`onTapOutside`)

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:heroicons/heroicons.dart';

// 1. Text Field Basic
AppTextField(
  title: 'Username',
  hint: 'Masukkan username',
  prefixIcon: HeroIcons.user,
  onChanged: (val) => print(val),
  onEditingComplete: (val) => print('Selesai: $val'),
)

// 2. Text Field dengan fillColor custom & suffix
AppTextField(
  title: 'Cari Produk',
  hint: 'Ketik nama produk...',
  prefixIcon: HeroIcons.magnifyingGlass,
  fillColor: context.uiTheme.surface,
  suffixWidget: IconButton(
    icon: HeroIcon(HeroIcons.xMark),
    onPressed: () => _controller.clear(),
  ),
  controller: _controller,
  textInputAction: TextInputAction.search,
  onSubmitted: (val) => search(val),
)

// 3. Text Field Email (Error State & Formatter)
AppTextField(
  title: 'Email',
  hint: 'email@domain.com',
  errorText: 'Format email tidak valid!',
  keyboardType: TextInputType.emailAddress,
  autofillHints: const [AutofillHints.email],
  inputFormatters: [NoSpaceFormatter()],
)

// 4. Password Field dengan Indikator Kekuatan
AppPasswordField(
  title: 'Password Baru',
  hint: 'Minimal 8 karakter',
  showStrengthIndicator: true,
  autofillHints: const [AutofillHints.newPassword],
  fillColor: context.uiTheme.background,
  onChanged: (val) => print('Password diubah'),
)

// 5. Currency Field (Rupiah)
AppCurrencyField(
  title: 'Nominal Transfer',
  hint: '0',
  prefixIcon: HeroIcons.banknotes,
  // Otomatis format "Rp 1.000.000" dan keyboard Number
  onChanged: (val) => print('Nominal: $val'),
)
```

| Property | Type | Description |
|----------|------|-------------|
| `prefixIcon` | `HeroIcons?` | Ikon kiri; seluruh segmen prefix dihilangkan jika null |
| `suffixWidget` | `Widget?` | Widget kanan; seluruh segmen suffix dihilangkan jika null |
| `fillColor` | `Color?` | Background field (seragam di prefix, input, suffix) |
| `onEditingComplete` | `ValueChanged<String>?` | Dipanggil saat editing selesai, return nilai field |
| `onSubmitted` | `ValueChanged<String>?` | Dipanggil saat user submit (mis. tombol Done keyboard) |
| `autofillHints` | `Iterable<String>?` | Hint autofill sistem (email, password, dll.) |
| `textInputAction` | `TextInputAction?` | Aksi tombol keyboard (next, done, search, …) |
| `maxLength` | `int?` | Batas panjang karakter |
| `helperText` / `errorText` | `String?` | Teks bantuan atau error di bawah field |

### AppOtpForm
Komponen form OTP multi-digit dengan navigasi fokus otomatis, `AutofillGroup`, dan skeleton loading.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

AppOtpForm(
  title: 'Verifikasi OTP',
  description: 'Masukkan kode 6 digit yang dikirim ke email Anda',
  codeLength: 6,
  buttonText: 'Verifikasi',
  footerText: 'Belum menerima kode?',
  footerActionText: 'Kirim Ulang',
  onCompleted: (code) => print('OTP lengkap: $code'),
  onVerify: () => verifyOtp(),
  onFooterActionTap: () => resendOtp(),
  isLoading: false,
  fieldBackgroundColor: context.uiTheme.background,
)
```

### AppImageUpload
Komponen unggah gambar dari kamera atau galeri dengan area drag-and-drop bergaya modern. Mendukung preview offline yang aman di web.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

AppImageUpload(
  title: 'Upload Foto KTP',
  subtitle: 'Format JPG atau PNG, maks. 5MB',
  localImagePath: _imagePath,
  sourceCamera: true,
  sourceGallery: true,
  onImageSelected: (path) => setState(() => _imagePath = path),
  onCancel: () => setState(() => _imagePath = null),
  backgroundColor: context.uiTheme.surface,
)
```

### AppFileUpload
Komponen unggah file (Upload File) serbaguna. Terintegrasi dengan *File Picker*, mendukung filter jenis ekstensi file (seperti PDF, DOCX), serta animasi dan styling interaktif ala Drag-and-Drop.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Upload Segala Jenis File
AppFileUpload(
  title: 'Upload Lampiran',
  subtitle: 'Pilih file apapun',
  onFileSelected: (path) => print('File terpilih: $path'),
)

// 2. Upload Dokumen Spesifik
AppFileUpload(
  title: 'Upload KTP',
  subtitle: 'Hanya file PDF atau Image',
  allowedExtensions: const ['pdf', 'jpg', 'png'],
  onFileSelected: (path) => print('Dokumen: $path'),
)
```

### AppSnackbar
Komponen pemanggil notifikasi dinamis (Snackbar) yang ditulis murni menggunakan Flutter (`ScaffoldMessenger`), *theme-aware*, dan tidak bergantung pada package State Management (seperti GetX).

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// 1. Success Snackbar
AppSnackbar.success(
  context,
  title: 'Berhasil',
  subtitle: 'Data telah disimpan',
);

// 2. Error Snackbar di Posisi Atas (Top)
AppSnackbar.error(
  context,
  title: 'Gagal',
  subtitle: 'Koneksi terputus',
  positionTop: true, // Akan diletakkan di atas layar
);

// 3. Snackbar Kustom dengan Action
AppSnackbar.show(
  context,
  title: 'Item Dihapus',
  type: AppSnackbarType.info,
  actionLabel: 'BATALKAN',
  onAction: () => print('Aksi dibatalkan'),
);
```

### AppDashboardAppbar
Komponen `SliverAppBar` interaktif bergaya Dashboard modern. Digunakan di dalam `CustomScrollView`, dilengkapi dengan slot Avatar (bisa pakai gambar atau bawaan), teks judul, subjudul, serta fitur *Toggle Theme* Terang/Gelap bawaan.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// Harus dibungkus di dalam CustomScrollView > slivers
CustomScrollView(
  slivers: [
    AppDashboardAppbar(
      title: 'Halo, Ryan!',
      subtitle: 'Selamat datang kembali',
      // Jika onThemeToggle diset, tombol bulan/matahari akan muncul
      onThemeToggle: () {
        print('Toggle theme diklik!');
      },
      isDarkMode: false, // Beritahu AppBar status tema saat ini
      trailingWidget: HeroIcon(
        HeroIcons.bell,
        color: context.uiTheme.primary,
      ),
    ),
    // ... SliverList atau SliverGrid di sini
  ],
)
```

### AppMainAppbar
Komponen `SliverPersistentHeader` untuk halaman utama dengan judul berefek parallax dan kotak pencarian (atau filter tab) yang menempel (pinned) di bagian bawah. Search field memakai `AppTextField` dengan `fillColor: uiTheme.surface` agar kontras dengan background app bar.

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `titleStyle` | `TextStyle?` | Style kustom untuk judul (font, ukuran, letter spacing, dll.) |
| `appBarHeight` | `double?` | Tinggi area appbar saat collapsed/search (default `70`, diskalakan via `sizeHeight()`) |
| `titleBottomPadding` | `double?` | Padding bawah pada area judul (diskalakan via `sizeHeight()`) |
| `pinned` | `bool` | App bar tetap di atas saat scroll (default `true`) |
| `floating` | `bool` | App bar muncul kembali saat scroll ke atas (default `false`) |

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

CustomScrollView(
  slivers: [
    AppMainAppbar(
      title: 'Daftar Produk',
      titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      appBarHeight: 76,
      titleBottomPadding: 6,
      pinned: true,
      floating: false,
      searchHint: 'Cari nama produk...',
      onBack: () => Navigator.pop(context),
      onSearch: (val) {
        print('Mencari: $val');
      },
      onReset: () {
        print('Pencarian di-reset');
      },
      actions: [
        IconButton(
          icon: HeroIcon(HeroIcons.funnel, color: context.uiTheme.onPrimary),
          onPressed: () {},
        ),
      ],
    ),
    // ... Konten list di bawahnya
  ],
)
```

### AppDetailAppbar
Komponen `SliverAppBar` khusus untuk halaman detail yang memberikan efek lengkungan (border radius) di bagian bawahnya seolah-olah konten menggulung di atas kartu. Bebas dari GetX dan otomatis mengikuti pewarnaan `context.uiTheme`.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

CustomScrollView(
  slivers: [
    AppDetailAppbar(
      title: 'Detail Pembayaran',
      isBack: true,
      // onBack: () => Navigator.pop(context), // otomatis terpanggil jika null
    ),
    // ... Konten halaman detail di bawahnya
  ],
)
```

### AppTimeline
Komponen untuk menampilkan riwayat status atau progres (pelacakan pesanan, stepper, dll.). Mendukung layout vertikal/horizontal, skeleton loading, 4 status node, **ukuran lingkaran custom**, **warna active/inactive custom**, dan **animasi glow pulse** saat `isHighlighted = true`.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

AppTimeline(
  direction: Axis.vertical,       // atau Axis.horizontal
  isLoading: false,
  indicatorSize: size(28),        // ukuran lingkaran default (semua node)
  activeColor: context.uiTheme.primary,
  inactiveColor: context.uiTheme.hintColor,
  highlightGlowColor: context.uiTheme.success, // warna glow pulse
  itemWidth: size(140),           // hanya untuk direction horizontal
  nodes: [
    const AppTimelineNode(
      title: 'Pesanan Dibuat',
      subtitle: '12 Agt 2026',
      status: TimelineStatus.completed,
    ),
    AppTimelineNode(
      title: 'Pesanan Diproses',
      subtitle: 'Sedang dikemas',
      status: TimelineStatus.active,
      isHighlighted: true,         // glow pulse + kartu sorotan konten
      indicatorSize: size(32),      // override ukuran per node (opsional)
      content: AppButton(
        text: 'Lacak Lokasi',
        size: AppButtonSize.small,
        onPressed: () {},
      ),
    ),
    const AppTimelineNode(
      title: 'Dalam Pengiriman',
      status: TimelineStatus.inactive,
    ),
    const AppTimelineNode(
      title: 'Pesanan Diterima',
      status: TimelineStatus.disabled,
    ),
  ],
)
```

| Property | Level | Description |
|----------|-------|-------------|
| `indicatorSize` | Timeline / Node | Ukuran lingkaran indikator |
| `activeColor` | Timeline | Warna node `completed` & `active` + garis connector |
| `inactiveColor` | Timeline | Warna node `inactive` + garis belum selesai |
| `highlightGlowColor` | Timeline | Warna animasi glow pulse (default: `activeColor`) |
| `isHighlighted` | Node | Aktifkan glow pada lingkaran + kartu highlight konten |
| `status` | Node | `completed`, `active`, `inactive`, `disabled` |
| `content` | Node | Widget custom di bawah title/subtitle |
| `direction` | Timeline | `Axis.vertical` (default) atau `Axis.horizontal` |
| `isLoading` | Timeline | Tampilkan skeleton placeholder |

### AppProgressBar
Komponen batang progres dinamis dengan dukungan judul, sub-judul, ikon awalan (opsional), dan *Skeletonizer*. Lebar batang fleksibel dan bertransisi secara mulus ketika nilai `progress` (0.0 sampai 1.0) berubah.

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `titleSize` | `double?` | Ukuran font title (diskalakan via `size()`) |
| `subtitleSize` | `double?` | Ukuran font subtitle (diskalakan via `size()`) |

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

AppProgressBar(
  progress: 0.75, // 75%
  title: 'Mengunggah Data',
  subtitle: '75%',
  titleSize: 18,
  subtitleSize: 12,
  icon: HeroIcons.cloudArrowUp, // Opsional
  color: context.uiTheme.primary, // Bisa diganti warnanya
  isLoading: false,
)
```

### AppProgressCircle
Komponen progress lingkaran dengan arc gradient/solid, thumb di ujung arc, teks tengah (label, value, title, description), animasi entrance saat pertama muncul, dan *Skeletonizer*.

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `progress` | `double` | Nilai 0.0–1.0 |
| `color` | `Color?` | Warna solid arc (jika `gradientColors` null) |
| `gradientColors` | `List<Color>?` | 2+ warna untuk gradient sweep |
| `diameter` | `double?` | Diameter lingkaran (diskalakan via `size()`, default `160`) |
| `strokeWidth` | `double?` | Ketebalan arc (default `12`) |
| `label` / `value` / `title` / `description` | `String?` | Teks tengah; `value` default otomatis dari persentase |
| `labelStyle` / `valueStyle` / `titleStyle` / `descriptionStyle` | `TextStyle?` | Override style penuh per field |
| `labelSize` / `valueSize` / `titleSize` / `descriptionSize` | `double?` | Shortcut ukuran font |
| `labelBackgroundColor` | `Color?` | Background pill label |
| `showThumb` | `bool` | Tampilkan dot di ujung arc (default `true`) |
| `animateOnAppear` | `bool` | Animasi 0 → progress saat pertama render |
| `isLoading` | `bool` | Skeleton shimmer |

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

// Solid color
AppProgressCircle(
  progress: 0.65,
  label: 'Storage',
  title: 'Used Space',
  description: '65 GB of 100 GB',
  color: context.uiTheme.warning,
)

// Gradient (seperti mockup)
AppProgressCircle(
  progress: 0.5,
  label: 'Label',
  title: 'Your Score',
  description: 'as on 15 April 2025 6:18 pm',
  gradientColors: const [
    Color(0xFF10B981),
    Color(0xFF8B5CF6),
  ],
  diameter: 160,
  valueSize: 36,
  isLoading: false,
)
```

---

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_screenutil` | Base responsive scaling (wrapped by `AppScaleInit`) |
| `heroicons` | Icon set for form fields, navigation, pickers |
| `skeletonizer` | Loading skeleton for timeline, OTP, progress bar, etc. |
| `intl` | Currency and date formatting |
| `cached_network_image` | Online image loading & caching |
| `image_picker` | Camera/gallery image selection |
| `file_picker` | Document/file upload |
| `dotted_border` | Drag-and-drop upload area styling |

---

## 📋 Component Index

| Component | Description |
|-----------|-------------|
| `AppButton` | Flexible button with variants, shapes, icons, loading |
| `AppDialog` | Themed modal dialogs |
| `AppImageViewerDialog` | Fullscreen image viewer (online/offline) |
| `AppBottomNavigation` | Animated bottom navigation bar |
| `AppSegmentedSwitch` | Segmented control / tab switcher |
| `AppSwitchButton` | Toggle switch with title & description |
| `AppDatePicker` | Calendar date picker |
| `AppYearPicker` | 3D scroll wheel year picker |
| `AppTimePicker` | Hour/minute/second time picker |
| `AppMonthPicker` | Month scroll wheel picker |
| `AppDropdown` | Single & multi select dropdown |
| `AppSelectionTile` / `AppSelectionPill` / `AppRadio` | Selection controls |
| `AppTextField` | Text input with prefix/suffix & modern APIs |
| `AppPasswordField` | Password input with strength indicator |
| `AppCurrencyField` | Currency-formatted text input |
| `AppOtpForm` | Multi-digit OTP verification form |
| `AppImageUpload` | Camera/gallery image upload |
| `AppFileUpload` | Document/file upload |
| `AppSnackbar` | Themed snackbar notifications |
| `AppDashboardAppbar` | Dashboard sliver app bar |
| `AppMainAppbar` | Main page app bar with search |
| `AppDetailAppbar` | Detail page curved app bar |
| `AppTimeline` | Vertical/horizontal status timeline |
| `AppProgressBar` | Animated progress bar |
| `AppProgressCircle` | Circular progress with gradient, thumb, skeleton |
