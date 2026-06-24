# flutter_ui_kit

Package Flutter UI reusable: theme system, 39+ widget, extension, dan formatter. Dirancang untuk aplikasi modern dengan dukungan light/dark mode, responsif, dan pola **null → hidden**.

> **Import tunggal untuk semua API publik:**
> ```dart
> import 'package:flutter_ui_kit/flutter_ui_kit.dart';
> ```

---

## Daftar Isi

1. [Instalasi](#1-instalasi)
2. [Setup Wajib](#2-setup-wajib)
3. [Konsep & Aturan Desain](#3-konsep--aturan-desain)
4. [Theme System](#4-theme-system)
5. [Extensions](#5-extensions)
6. [Formatters](#6-formatters)
7. [Buttons](#7-buttons)
8. [Inputs](#8-inputs)
9. [Dialogs](#9-dialogs)
10. [Image](#10-image)
11. [Navigation](#11-navigation)
12. [Profile](#12-profile)
13. [Data Display — Cards](#13-data-display--cards)
14. [Card Detail](#14-card-detail)
15. [Stats Overview](#15-stats-overview)
16. [Status](#16-status)
17. [Referensi Enum & Helper Types](#17-referensi-enum--helper-types)
18. [Dependencies](#18-dependencies)
19. [Demo App](#19-demo-app)

---

## 1. Instalasi

Tambahkan ke `pubspec.yaml` (private GitHub):

```yaml
dependencies:
  flutter_ui_kit:
    git:
      url: git@github.com:USERNAME/flutter_ui_kit.git
      ref: v1.0.0   # atau branch main
```

Jalankan:

```bash
flutter pub get
```

---

## 2. Setup Wajib

Package ini **bergantung pada GetX** dan **flutter_screenutil**. Tanpa setup ini, `AppScale`, `AppColors` (responsive), `AppDialog`, dan `AppSnackbar` tidak berfungsi dengan benar.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui_kit/flutter_ui_kit.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // basis desain mobile
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => GetMaterialApp(
        title: 'My App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
```

| Komponen | Ketergantungan |
|----------|----------------|
| `AppScale.w/h/sp/r` | `ScreenUtilInit` + `Get.width` |
| `AppColors.background`, `textPrimary`, dll. | `Get.isDarkMode` |
| `AppDialog.show()` | `Get.dialog` |
| `AppSnackbar.show()` | `Get.snackbar` |

---

## 3. Konsep & Aturan Desain

### 3.1 Null → Hidden

Hampir semua widget mengikuti aturan: **jika parameter `null` atau kosong, bagian UI tersebut tidak dirender** (termasuk spacing di sekitarnya).

```dart
// Hanya judul — subtitle & tombol tidak muncul
AppCardStyle3(
  title: 'Produk A',
  // subtitle: null  → tidak ditampilkan
  // buttonText: null → tombol tidak ditampilkan
)
```

### 3.2 isLoading

| Tipe komponen | Perilaku loading |
|---------------|------------------|
| Card, profile, stats, data display | `Skeletonizer` / `Skeleton.replace` |
| Input interaktif (dropdown, picker, OTP) | `CircularProgressIndicator` + disable interaksi |
| `AppButton` | Spinner di dalam tombol, tap dinonaktifkan |

### 3.3 isMax

Banyak card menerima `isMax: true` agar lebar mengisi parent (`double.infinity`). Default menggunakan `width` atau ukuran bawaan responsif.

### 3.4 Responsivitas

`AppScale` memakai `flutter_screenutil` di mobile/tablet. Di desktop (lebar ≥ 1024px), nilai dikembalikan apa adanya tanpa scaling agar tidak membesar berlebihan.

---

## 4. Theme System

### 4.1 AppColors

Token warna statis dan getter responsif (otomatis light/dark via GetX). Semua warna statis (Brand, Status, Neutral) dapat dioverride melalui `AppColors.overrideColors({...})` saat inisialisasi aplikasi.

#### Brand

| Token | Hex | Keterangan |
|-------|-----|------------|
| `AppColors.primary` | `#4A3AFF` | Ungu brand utama |
| `AppColors.primaryDark` | `#3829E0` | Ungu lebih gelap |

#### Status

| Token | Hex |
|-------|-----|
| `AppColors.success` | `#22C55E` |
| `AppColors.error` | `#EF4444` |
| `AppColors.warning` | `#F59E0B` |
| `AppColors.info` | `#3B82F6` |

#### Neutral

`white`, `black`, `neutral100` … `neutral900` — skala abu-abu Tailwind-style.

#### Responsive getters

| Getter | Light | Dark |
|--------|-------|------|
| `background` | `#FFFFFF` | `#111827` |
| `surface` | `#F3F4F6` | `#1F2937` |
| `textPrimary` | `#111827` | `#F9FAFB` |
| `textSecondary` | `#6B7280` | `#9CA3AF` |
| `border` | `#E5E7EB` | `#374151` |
| `divider` | `#F3F4F6` | `#1F2937` |

```dart
Scaffold(
  backgroundColor: AppColors.background,
  body: Text('Judul', style: TextStyle(color: AppColors.textPrimary)),
)
```

---

### 4.2 AppScale

| Konstanta / Getter | Nilai | Keterangan |
|--------------------|-------|------------|
| `mobileBreakpoint` | `600` | Batas mobile |
| `tabletBreakpoint` | `1024` | Batas desktop |
| `maxDesktopWidth` | `1200` | Lebar maks konten desktop |
| `isMobile` | — | `Get.width < 600` |
| `isTablet` | — | `600 ≤ width < 1024` |
| `isDesktop` | — | `width ≥ 1024` |
| `responsiveMaxWidth` | — | `1200` di desktop, else `Get.width` |

| Method | Fungsi |
|--------|--------|
| `AppScale.w(size)` | Lebar responsif |
| `AppScale.h(size)` | Tinggi responsif |
| `AppScale.sp(size)` | Font size responsif |
| `AppScale.r(size)` | Border radius responsif |

```dart
Container(
  width: AppScale.w(360),
  padding: EdgeInsets.all(AppScale.w(16)),
  child: Text('Halo', style: TextStyle(fontSize: AppScale.sp(16))),
)
```

---

### 4.3 AppTheme

| Getter | Keterangan |
|--------|------------|
| `AppTheme.lightTheme` | `ThemeData` Material 3, scaffold putih, font `Inter` |
| `AppTheme.darkTheme` | `ThemeData` Material 3, scaffold `#111827` |

Keduanya mengatur `primaryColor`, `colorScheme.primary/secondary/error`, dan `appBarTheme.elevation: 0`.

---

## 5. Extensions

### 5.1 DateTime & String — Format Tanggal

**Enum `AppDateTimeFormat`**

| Nilai | Output contoh |
|-------|---------------|
| `dmyNumeric` | `15 12 2002` |
| `dmyShortMonth` | `15 Des 2002` |
| `dmyFullMonth` | `15 Desember 2002` |
| `monthYear` | `Desember 2002` |
| `timeHm` | `14:24` |

**Extension `DateTime`**

| Method | Keterangan |
|--------|------------|
| `formatted([style])` | Format dengan enum, default `dmyNumeric` |
| `toDmyNumeric()` | `15 12 2002` |
| `toDmyShortMonth()` | Bulan singkat Indonesia |
| `toDmyFullMonth()` | Bulan penuh Indonesia |
| `toMonthYear()` | Bulan + tahun |
| `toTimeHm()` | Jam:menit zero-padded |

**Extension `String`**

| Method | Keterangan |
|--------|------------|
| `toFormattedDate([style])` | Parse ISO/date string; gagal → kembalikan string asli |

```dart
final dt = DateTime(2002, 12, 15, 14, 24);

dt.formatted();                                    // '15 12 2002'
dt.formatted(AppDateTimeFormat.dmyShortMonth);     // '15 Des 2002'
dt.toTimeHm();                                     // '14:24'

'2002-12-15'.toFormattedDate(AppDateTimeFormat.dmyFullMonth);
// '15 Desember 2002'
```

---

### 5.2 int & num — Format Mata Uang

**Enum `AppCurrencyType`**: `rupiah`, `dollar`

| Method (`int`) | Output contoh |
|----------------|---------------|
| `toCurrency([type])` | Default `rupiah` |
| `toRupiah()` | `Rp.5.000` |
| `toDollar()` | `$.5.000` |

| Method (`num`) | Keterangan |
|----------------|------------|
| `toCurrency()`, `toRupiah()`, `toDollar()` | Memanggil `round()` dulu |

```dart
5000.toRupiah();                              // 'Rp.5.000'
5000.toCurrency(AppCurrencyType.dollar);      // '$.5.000'
4999.7.toRupiah();                            // 'Rp.5.000'
```

---

### 5.3 double & num — Format Persen

| Method | Keterangan |
|--------|------------|
| `toPercent({fractionDigits})` | `0.0–1.0` = fraksi (0.5 → `50%`); `>1` = sudah persen |

```dart
0.5.toPercent();                    // '50%'
0.333.toPercent();                  // '33.3%'
50.0.toPercent();                   // '50%'
0.756.toPercent(fractionDigits: 2); // '75.60%'
```

---

### 5.4 Widget — Glassmorphism (`.glassy()`)

```dart
Widget glassy({
  double blurred = 30,
  List<Color>? gradientColors,
  BorderRadius? borderRadius,       // default AppScale.r(16)
  double opacity = 1.0,
  bool forceBlur = false,           // blur di light mode
  Border? border,
})
```

| Perilaku | Detail |
|----------|--------|
| Blur | Aktif di dark mode; light mode hanya jika `forceBlur: true` |
| Gradient default | Putih transparan (dark) / putih→hitam transparan (light) |
| Border default | Putih semi-transparan, theme-aware |

```dart
Container(
  padding: EdgeInsets.all(AppScale.w(16)),
  child: Text('Glass card'),
).glassy(blurred: 30)

// Custom gradient
).glassy(
  blurred: 30,
  gradientColors: [Color(0x66FFFFFF), Color(0x334A3AFF)],
)
```

---

### 5.5 Widget — Animasi (`.animated()`)

**Enum `AppAnimationVariant`**: `floatVertical`, `floatHorizontal`, `shake`

```dart
Widget animated({
  AppAnimationVariant variant = AppAnimationVariant.floatVertical,
  double intensity = 0.5,    // 0.0–1.0; ≤0 = tanpa animasi
  Duration? duration,        // default: 2200ms float, 600ms shake
})
```

```dart
Icon(Icons.star).animated(
  variant: AppAnimationVariant.floatVertical,
  intensity: 0.7,
)

Icon(Icons.notifications).animated(
  variant: AppAnimationVariant.shake,
  intensity: 0.8,
)
```

---

## 6. Formatters

### CurrencyInputFormatter

`TextInputFormatter` untuk input angka dengan pemisah ribuan. **Simbol tidak disisipkan ke teks** — gunakan `prefixWidget` di `AppTextField`.

```dart
CurrencyInputFormatter({
  String symbol = '',       // 'Rp' → locale id_ID; lainnya → en_US
  int decimalDigits = 0,    // >0 → bagi input 100 (format sen)
})
```

```dart
AppTextField(
  keyboardType: TextInputType.number,
  inputFormatters: [CurrencyInputFormatter(symbol: 'Rp', decimalDigits: 0)],
  prefixWidget: Text('Rp '),
)
```

---

## 7. Buttons

### AppButton

Tombol multi-variant dengan dukungan ikon, gradient, loading, dan berbagai bentuk.

#### Enum

| Enum | Nilai |
|------|-------|
| `AppButtonVariant` | `solid`, `outline`, `dashed`, `smooth`, `gradient`, `raised`, `text` |
| `AppButtonShape` | `rounded`, `pill`, `circle`, `square` |
| `AppButtonSize` | `small`, `medium`, `large` |
| `IconPosition` | `left`, `right`, `top` |

#### Constructor utama

| Parameter | Tipe | Default | Keterangan |
|-----------|------|---------|------------|
| `text` | `String?` | — | Label tombol |
| `icon` | `IconData?` | — | Ikon Material |
| `customIcon` | `Widget?` | — | Ikon kustom (mis. HeroIcon) |
| `onPressed` | `VoidCallback?` | **required** | Callback tap |
| `variant` | `AppButtonVariant` | `solid` | Gaya tombol |
| `shape` | `AppButtonShape` | `rounded` | Bentuk |
| `size` | `AppButtonSize` | `medium` | Ukuran |
| `iconPosition` | `IconPosition` | `left` | Posisi ikon |
| `color` | `Color?` | — | Warna latar/aksen |
| `textColor` | `Color?` | — | Warna teks |
| `gradientColors` | `List<Color>?` | — | Untuk variant `gradient` |
| `isFullWidth` | `bool` | `false` | Lebar penuh |
| `isLoading` | `bool` | `false` | Spinner + disable tap |
| `iconSize` | `double?` | — | Kustom ukuran ikon |
| `textSize` | `double?` | — | Kustom ukuran teks |

> **Assert:** minimal satu dari `text`, `icon`, atau `customIcon` harus ada.

#### Named constructors

| Constructor | Keterangan |
|-------------|------------|
| `AppButton.icon({required icon, required onPressed, ...})` | Ikon saja; default `shape: circle` |
| `AppButton.text({required text, required onPressed, ...})` | Teks saja; `variant: text` |

```dart
// Solid + ikon
AppButton(
  text: 'Simpan',
  icon: Icons.save,
  onPressed: () {},
)

// Loading
AppButton(
  text: 'Memproses...',
  isLoading: true,
  onPressed: () {},
)

// Gradient full-width
AppButton(
  text: 'Upgrade',
  variant: AppButtonVariant.gradient,
  gradientColors: [AppColors.primary, AppColors.primaryDark],
  isFullWidth: true,
  onPressed: () {},
)

// Icon only
AppButton.icon(
  icon: Icons.add,
  onPressed: () {},
)
```

---

## 8. Inputs

### 8.1 AppTextField

Field teks dasar dengan label, helper, error, dan prefix/suffix.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `title` | `String?` | — |
| `hint` | `String?` | — |
| `helperText` | `String?` | — |
| `errorText` | `String?` | — |
| `prefixWidget` / `suffixWidget` | `Widget?` | — |
| `prefixIcon` / `suffixIcon` | `IconData?` | — |
| `controller` | `TextEditingController?` | — |
| `keyboardType` | `TextInputType` | `text` |
| `obscureText` | `bool` | `false` |
| `onChanged` | `ValueChanged<String>?` | — |
| `inputFormatters` | `List<TextInputFormatter>?` | — |

**Null → hidden:** `title`; `helperText` disembunyikan jika `errorText` ada.

---

### 8.2 AppPasswordField

Wrapper `AppTextField` dengan toggle visibility dan indikator kekuatan password.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `title` | `String?` | `'Password'` |
| `hint` | `String?` | `'••••••••'` |
| `helperText` | `String?` | — |
| `errorText` | `String?` | — |
| `prefixIcon` | `IconData?` | `Icons.lock_outline` |
| `showStrengthIndicator` | `bool` | `true` |
| `onChanged` | `ValueChanged<String>?` | — |

**Kekuatan password:** 0 segmen = kosong; 1–7 karakter = 2 segmen amber; ≥8 = 4 segmen hijau.

---

### 8.3 AppCheckbox

| Parameter | Tipe | Default |
|-----------|------|---------|
| `value` | `bool` | **required** |
| `onChanged` | `ValueChanged<bool?>?` | **required** |
| `variant` | `AppCheckboxVariant` | `solid` |
| `activeColor` | `Color?` | — |
| `checkColor` | `Color?` | — |
| `size` | `double?` | — |

**Enum `AppCheckboxVariant`:** `solid`, `outline`, `checkOnly`

---

### 8.4 AppRadio\<T\>

| Parameter | Tipe | Default |
|-----------|------|---------|
| `value` | `T` | **required** |
| `groupValue` | `T?` | **required** |
| `onChanged` | `ValueChanged<T?>?` | **required** |
| `variant` | `AppRadioVariant` | `outline` |
| `activeColor` | `Color?` | — |
| `dotColor` | `Color?` | — |
| `size` | `double?` | — |

**Enum `AppRadioVariant`:** `solid`, `outline`, `dotOnly`

```dart
AppRadio<String>(
  value: 'a',
  groupValue: selected,
  onChanged: (v) => setState(() => selected = v),
)
```

---

### 8.5 AppSwitch

| Parameter | Tipe | Default |
|-----------|------|---------|
| `value` | `bool` | **required** |
| `onChanged` | `ValueChanged<bool>` | **required** |
| `textOn` | `String?` | `'ON'` |
| `textOff` | `String?` | `'OFF'` |
| `activeColor` | `Color?` | — |
| `inactiveColor` | `Color?` | — |

---

### 8.6 AppSegmentedSwitch

| Parameter | Tipe | Default |
|-----------|------|---------|
| `options` | `List<String>` | **required** (min 2) |
| `selectedIndex` | `int` | **required** |
| `onChanged` | `ValueChanged<int>` | **required** |
| `activeColor` | `Color?` | — |
| `borderRadius` | `BorderRadiusGeometry?` | — |
| `mainAxisSize` | `MainAxisSize` | `max` |

---

### 8.7 AppSelectionPill

Pill selectable dengan kontrol kustom (checkbox/radio) di dalamnya.

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `text` | `String` | **required** |
| `isSelected` | `bool` | **required** |
| `onChanged` | `ValueChanged<bool>` | **required** |
| `control` | `Widget` | **required** — checkbox/radio widget |
| `activeColor` | `Color?` | — |

---

### 8.8 AppSelectionTile

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `control` | `Widget` | **required** |
| `title` | `String` | **required** |
| `description` | `String?` | Null → hidden |
| `isSelected` | `bool` | **required** |
| `onChanged` | `ValueChanged<bool>` | **required** |

---

### 8.9 AppDropdown

Dropdown single-select atau multi-select dengan chip.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `title` | `String?` | — |
| `items` | `List<String>` | **required** |
| `isMultiSelect` | `bool` | `false` |
| `value` | `String?` | — (single) |
| `selectedValues` | `List<String>?` | — (multi) |
| `onChanged` | `ValueChanged<String?>?` | Wajib jika single |
| `onMultiChanged` | `ValueChanged<List<String>>?` | Wajib jika multi |
| `hint` | `String?` | — |
| `prefixIcon` | `IconData?` | — |
| `isLoading` | `bool` | `false` |
| `showClearButton` | `bool` | `true` |

**Multi-select:** item terpilih ditampilkan sebagai chip; hapus per-item; tombol clear-all jika ada seleksi.

```dart
// Single
AppDropdown(
  title: 'Kota',
  items: ['Jakarta', 'Bandung', 'Surabaya'],
  value: selectedCity,
  onChanged: (v) => setState(() => selectedCity = v),
)

// Multi
AppDropdown(
  title: 'Skills',
  items: ['Flutter', 'Dart', 'Firebase'],
  isMultiSelect: true,
  selectedValues: selectedSkills,
  onMultiChanged: (list) => setState(() => selectedSkills = list),
)
```

---

### 8.10 AppDatePicker

| Parameter | Tipe | Default |
|-----------|------|---------|
| `title` | `String?` | — |
| `value` | `DateTime?` | — |
| `onChanged` | `ValueChanged<DateTime?>` | **required** |
| `hint` | `String?` | — |
| `prefixIcon` | `IconData?` | — |
| `isLoading` | `bool` | `false` |

Popup kalender inline. Static: `AppDatePicker.monthNames` (12 nama bulan Inggris).

---

### 8.11 AppTimePicker

**Helper `AppTimeData`**

| Field | Tipe |
|-------|------|
| `hour`, `minute`, `second` | `int` |
| `isAm` | `bool` |
| `formatted` | getter `String` |

| Parameter | Tipe | Default |
|-----------|------|---------|
| `title` | `String?` | — |
| `value` | `AppTimeData?` | — |
| `onChanged` | `ValueChanged<AppTimeData?>` | **required** |
| `hint` | `String?` | — |
| `prefixIcon` | `IconData?` | — |
| `isLoading` | `bool` | `false` |

Popup stepper jam/menit/detik + toggle AM/PM.

---

### 8.12 AppYearPicker

| Parameter | Tipe | Default |
|-----------|------|---------|
| `title` | `String?` | — |
| `value` | `int?` | — |
| `onChanged` | `ValueChanged<int?>` | **required** |
| `hint` | `String?` | — |
| `prefixIcon` | `IconData?` | — |
| `isLoading` | `bool` | `false` |

Wheel picker tahun 1900–2100.

---

### 8.13 AppMonthPicker

| Parameter | Tipe | Default |
|-----------|------|---------|
| `title` | `String?` | — |
| `value` | `int?` | 1–12 |
| `onChanged` | `ValueChanged<int?>` | **required** |
| `hint` | `String?` | — |
| `prefixIcon` | `IconData?` | — |
| `isLoading` | `bool` | `false` |

Static: `AppMonthPicker.monthNames`.

---

### 8.14 AppOtpForm

Form OTP dengan kotak digit, verifikasi, dan footer opsional.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `title` | `String?` | — |
| `description` | `String?` | — |
| `codeLength` | `int` | `4` |
| `value` | `String?` | — |
| `buttonText` | `String?` | — |
| `footerText` | `String?` | — |
| `footerActionText` | `String?` | — |
| `onChanged` | `ValueChanged<String>?` | — |
| `onCompleted` | `ValueChanged<String>?` | — |
| `onVerify` | `VoidCallback?` | — |
| `onFooterActionTap` | `VoidCallback?` | — |
| `isLoading` | `bool` | `false` |
| `autofocus` | `bool` | `false` |
| `width` | `double?` | — |
| `padding` | `EdgeInsetsGeometry?` | — |

**Null → hidden:** tombol verify hanya jika `buttonText` + `onVerify` ada; footer jika `footerText` atau `footerActionText` ada.

**Fitur:** paste multi-digit, ukuran kotak dinamis (no overflow), dark mode fix.

```dart
AppOtpForm(
  title: 'Verifikasi OTP',
  description: 'Masukkan kode 6 digit',
  codeLength: 6,
  buttonText: 'Verifikasi',
  onVerify: () => verifyOtp(),
  onCompleted: (code) => print(code),
)
```

---

## 9. Dialogs

### 9.1 AppDialog

Dialog modal dengan variant warna dan tombol kiri/kanan.

**Enum `AppDialogVariant`:** `success`, `error`, `info`, `warning`

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `variant` | `AppDialogVariant` | Default `info` |
| `title` | `String` | **required** |
| `description` | `String` | **required** |
| `textLeft` | `String?` | Tombol kiri |
| `textRight` | `String?` | Tombol kanan |
| `onLeft` | `VoidCallback?` | Default `Get.back()` |
| `onRight` | `VoidCallback?` | — |
| `content` | `Widget?` | Konten kustom |
| `imageUrl` | `String?` | Gambar header |

**Static `AppDialog.show({...})`**

| Parameter | Default |
|-----------|---------|
| `barrierDismissible` | `false` |

```dart
AppDialog.show(
  variant: AppDialogVariant.success,
  title: 'Berhasil!',
  description: 'Data telah disimpan.',
  textRight: 'OK',
  onRight: () => Get.back(),
);
```

---

### 9.2 AppImageViewerDialog

Viewer gambar full-screen dengan zoom/pan.

| Constructor | Keterangan |
|-------------|------------|
| `AppImageViewerDialog.online({required imageUrl})` | URL online |
| `AppImageViewerDialog.offline({required imagePath})` | File lokal |

| Static method | Keterangan |
|---------------|------------|
| `showOnline<T>({required imageUrl, barrierDismissible: true})` | `Get.dialog` |
| `showOffline<T>({required imagePath, barrierDismissible: true})` | `Get.dialog` |

**Fitur:** `InteractiveViewer` (zoom 0.8×–5×), loading spinner, error state, tombol close.

```dart
AppImageViewerDialog.showOnline(imageUrl: 'https://example.com/photo.jpg');
AppImageViewerDialog.showOffline(imagePath: '/path/to/local.jpg');
```

---

## 10. Image

### AppImage

Gambar dari URL dengan placeholder skeleton dan error state.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `imageUrl` | `String?` | **required** (nullable) |
| `width` / `height` | `double?` | — |
| `fit` | `BoxFit` | `cover` |
| `borderRadius` | `BorderRadius?` | — |
| `errorIconSize` | `double?` | — |
| `errorBackgroundColor` | `Color?` | — |
| `errorIconColor` | `Color?` | — |

URL kosong/invalid → placeholder ikon kamera. URL valid → `CachedNetworkImage` + skeleton bone.

```dart
AppImage(
  imageUrl: 'https://example.com/avatar.jpg',
  width: AppScale.w(80),
  height: AppScale.w(80),
  borderRadius: BorderRadius.circular(AppScale.r(40)),
)
```

---

## 11. Navigation

### 11.1 AppNavigationBar

Bottom navigation bar dengan berbagai variant visual.

**Enum `AppNavigationBarVariant`**

| Nilai | Perilaku label |
|-------|----------------|
| `textOnSelected` | Label hanya pada item aktif |
| `textAlways` | Label selalu tampil |
| `topIndicator` | Garis indikator di atas ikon |
| `circleBackground` | Lingkaran latar pada item aktif |
| `pillBackground` | Pill latar pada item aktif |

**Helper `AppNavigationBarItem`**

| Field | Tipe |
|-------|------|
| `icon` | `HeroIcons` **required** |
| `activeIcon` | `HeroIcons?` |
| `label` | `String` **required** |

| Parameter | Tipe | Default |
|-----------|------|---------|
| `items` | `List<AppNavigationBarItem>` | **required** |
| `selectedIndex` | `int` | **required** |
| `onChanged` | `ValueChanged<int>` | **required** |
| `variant` | `AppNavigationBarVariant` | `textOnSelected` |
| `prominentCenterIndex` | `int?` | — |
| `isCenterFloating` | `bool` | `false` |
| `backgroundColor` | `Color?` | — |
| `selectedItemColor` | `Color?` | — |

---

### 11.2 AppWelcomeAppBar

App bar sambutan dengan avatar, greeting, dan notifikasi. Cocok untuk `SliverAppBar` atau container biasa.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `leadingWidget` | `Widget?` | Mengganti avatar |
| `imageUrl` | `String?` | Avatar |
| `greeting` | `String?` | Teks kecil atas |
| `title` | `String?` | Nama/judul |
| `isVerified` | `bool` | `false` |
| `notificationIcon` | `HeroIcons?` | — |
| `notificationCount` | `int?` | Badge count |
| `onNotificationTap` | `VoidCallback?` | Null → tombol notif hidden |
| `notificationBackgroundColor` | `Color?` | — |
| `actionIcon` | `HeroIcons?` | Ikon ekstra |
| `actionCount` | `int?` | Badge count aksi |
| `onActionTap` | `VoidCallback?` | Null → hidden |
| `actionBackgroundColor` | `Color?` | — |
| `onProfileTap` | `VoidCallback?` | — |
| `backgroundColor` | `Color?` | — |
| `padding` | `EdgeInsetsGeometry?` | — |
| `avatarSize` | `double?` | — |
| `isLoading` | `bool` | `false` |

**Named Constructor**: `AppWelcomeAppBar.sliver(...)` membungkus otomatis dengan `SliverToBoxAdapter`.

**Null → hidden:** badge hanya jika `count > 0`; verified badge hanya jika `isVerified`.

---

## 12. Profile

### 12.1 AppProfileCard1

Kartu profil horizontal dengan avatar, aksi, dan footer statistik.

**Helper `AppProfileCard1FooterItem`**

| Field | Tipe |
|-------|------|
| `value` | `String?` |
| `label` | `String?` |
| `text` | `String?` |

Getter: `isEmpty`, `hasValueLabel`

| Parameter | Tipe | Default |
|-----------|------|---------|
| `imageUrl` | `String?` | — |
| `actionIcon1/2` | `HeroIcons?` | — |
| `onActionIcon1/2Tap` | `VoidCallback?` | — |
| `title` / `subtitle` / `description` | `String?` | — |
| `footerItem1/2/3` | `AppProfileCard1FooterItem?` | — |
| `onTap` | `VoidCallback?` | — |
| `width` | `double?` | — |
| `avatarSize` | `double?` | — |
| `isMax` | `bool` | `false` |
| `isLoading` | `bool` | `false` |

---

### 12.2 AppProfileCard2

Kartu profil centered dengan badge dan konten kustom.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `imageUrl` | `String?` | *salah satu wajib* |
| `image` | `Widget?` | *dengan imageUrl* |
| `name` / `email` | `String?` | — |
| `badgeText` | `String?` | — |
| `badgeIcon` | `HeroIcons?` | — |
| `onBadgeTap` | `VoidCallback?` | — |
| `badge` | `Widget?` | Widget badge kustom |
| `badgeBackgroundColor` | `Color?` | — |
| `badgeForegroundColor` | `Color?` | — |
| `content` | `Widget?` | Konten bawah badge |
| `width` | `double?` | — |
| `margin` | `EdgeInsetsGeometry?` | — |
| `onTap` | `VoidCallback?` | — |
| `avatarSize` | `double?` | — |
| `isMax` | `bool` | `false` |
| `isLoading` | `bool` | `false` |

**Factory:** `AppProfileCard2.network({required imageUrl, ...})`

```dart
AppProfileCard2.network(
  imageUrl: 'https://example.com/avatar.jpg',
  name: 'John Doe',
  email: 'john@example.com',
  badgeText: 'Pro Member',
)
```

---

## 13. Data Display — Cards

Semua card mendukung `isLoading` (Skeletonizer) dan `isMax`.

### AppCardStyle1

Kartu vertikal dengan gambar, verifikasi, footer ikon, dan tombol.

**Enum `AppCardStyle1Variant`:** `solid`, `glassy`

| Parameter | Tipe |
|-----------|------|
| `variant` | `AppCardStyle1Variant` |
| `imageUrl`, `title`, `subtitle` | `String?` |
| `isVerified` | `bool` |
| `footerItem1/2Icon` | `HeroIcons?` |
| `footerItem1/2Text` | `String?` |
| `buttonText` | `String?` |
| `onButtonTap` | `VoidCallback?` |
| `width`, `isMax`, `isLoading` | — |

`glassy` → tinggi ~420, overlay blur di bagian bawah.

---

### AppCardStyle2

Mirip Style1 + favorite + progress bar opsional.

**Enum `AppCardStyle2Variant`:** `solid`, `glassy`

| Parameter tambahan | Tipe |
|--------------------|------|
| `isFavorite` | `bool` |
| `onFavoriteTap` | `VoidCallback?` |
| `imageHeight` | `double?` |
| `progress` | `double?` (0–1) → `AppProgressBar` |

---

### AppCardStyle3

Kartu produk: harga, rating, tags, bookmark.

| Parameter | Tipe |
|-----------|------|
| `imageUrl`, `title`, `price`, `description` | `String?` |
| `rating` | `double?` |
| `tags` | `List<String>?` |
| `buttonText`, `onButtonTap` | — |
| `isBookmarked`, `onBookmarkTap` | — |
| `width`, `isMax`, `isLoading` | — |

---

### AppCardStyle4

Kartu listing: kategori, lokasi, rating, review.

| Parameter | Tipe |
|-----------|------|
| `imageUrl`, `category`, `title` | `String?` |
| `location` | `String?` |
| `rating` | `double?` |
| `reviewText` | `String?` |
| `onTap` | `VoidCallback?` |
| `width`, `isMax`, `isLoading` | — |

---

### AppCardStyle5

Kartu dengan statistik dan dua tombol aksi.

**Helper `AppCardStyle5Stat`:** `title` + `value` (keduanya required)

| Parameter | Tipe |
|-----------|------|
| `imageUrl`, `title`, `subtitle`, `description` | `String?` |
| `stats` | `List<AppCardStyle5Stat>?` |
| `primaryButtonText`, `onPrimaryButtonTap` | — |
| `secondaryButtonText`, `onSecondaryButtonTap` | — |
| `width`, `isMax`, `isLoading` | — |

```dart
AppCardStyle5(
  title: 'Campaign',
  stats: [
    AppCardStyle5Stat(title: 'Donasi', value: 'Rp 50jt'),
    AppCardStyle5Stat(title: 'Donatur', value: '1.2k'),
    AppCardStyle5Stat(title: 'Rating', value: '4.9'),
  ],
  primaryButtonText: 'Donasi Sekarang',
  onPrimaryButtonTap: () {},
)
```

---

### AppCardStyle6

Kartu media dengan tombol play overlay.

| Parameter | Tipe |
|-----------|------|
| `imageUrl`, `title`, `author`, `date` | `String?` |
| `tagText` | `String?` |
| `tagColor`, `playRingColor` | `Color?` |
| `onPlayTap` | `VoidCallback?` (null → play hidden) |
| `onTap` | `VoidCallback?` |
| `width`, `imageHeight`, `isMax`, `isLoading` | — |

---

### AppCardStyle7

Kartu horizontal kompak: avatar + teks + badge.

| Parameter | Tipe |
|-----------|------|
| `imageUrl`, `title`, `subtitle` | `String?` |
| `badgeText` | `String?` |
| `badgeColor` | `Color?` |
| `onTap` | `VoidCallback?` |
| `width`, `avatarSize`, `isMax`, `isLoading` | — |

---

### AppCardStyle8

Kartu brand/logo dengan deskripsi.

| Parameter | Tipe |
|-----------|------|
| `imageUrl`, `title`, `subtitle`, `description` | `String?` |
| `subtitleColor` | `Color?` |
| `onTap` | `VoidCallback?` |
| `width`, `logoSize`, `isMax`, `isLoading` | — |

---

### AppAvatarStack

Tumpukan avatar dengan overflow counter.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `imageUrls` | `List<String>` | **required** |
| `totalCount` | `int?` | — |
| `maxDisplay` | `int` | `5` |
| `size` | `double` | `40` |
| `overlap` | `double` | `12` |
| `borderWidth` | `double` | `2` |
| `borderColor` | `Color?` | — |
| `showOnlineIndicator` | `bool` | `false` |

Menampilkan `+N` jika total melebihi `maxDisplay`. Kosong → `SizedBox.shrink()`.

---

### AppTimeline

Timeline vertikal atau horizontal.

**Enum `AppTimelineStatus`:** `completed`, `active`, `inactive`, `disabled`

**Helper `AppTimelineNode`**

| Field | Tipe | Default |
|-------|------|---------|
| `title` | `String` | **required** |
| `subtitle` | `String?` | — |
| `status` | `AppTimelineStatus` | `inactive` |
| `isHighlighted` | `bool` | `false` |
| `content` | `Widget?` | — |

| Parameter | Tipe | Default |
|-----------|------|---------|
| `nodes` | `List<AppTimelineNode>` | **required** |
| `direction` | `Axis` | `vertical` |
| `activeColor` | `Color?` | — |
| `itemWidth` | `double?` | horizontal scroll |

```dart
AppTimeline(
  nodes: [
    AppTimelineNode(title: 'Order placed', status: AppTimelineStatus.completed),
    AppTimelineNode(title: 'Processing', status: AppTimelineStatus.active),
    AppTimelineNode(title: 'Delivered', status: AppTimelineStatus.inactive),
  ],
)
```

---

## 14. Card Detail

### AppCardDetail1

Kartu detail kampanye/donasi dengan progress, donor stack, dan statistik.

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `imageUrl` | `String?` | — |
| `title` | `String?` | — |
| `avatarUrls` | `List<String>?` | Avatar donor |
| `donorTotalCount` | `int?` | — |
| `donorText` | `String?` | — |
| `progressLabel` | `String?` | — |
| `timeLeftText` | `String?` | — |
| `progress` | `double?` | 0–1 |
| `progressColor` | `Color?` | — |
| `raisedAmount` | `String?` | — |
| `raisedLabel` | `String?` | Default `'raised'` |
| `progressPercentText` | `String?` | Auto dari `progress` |
| `description` | `String?` | — |
| `onTap` | `VoidCallback?` | — |
| `width`, `imageHeight` | `double?` | — |
| `isMax`, `isLoading` | `bool` | — |

---

## 15. Stats Overview

### AppStatsOverview1

Kartu statistik dengan gradient background.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `gradientColors` | `List<Color>?` | `defaultGradientColors` |
| `gradientBegin` / `gradientEnd` | `AlignmentGeometry` | `centerLeft` / `centerRight` |
| `title`, `subtitle`, `value` | `String?` | — |
| `onTap` | `VoidCallback?` | — |
| `width`, `height` | `double?` | — |
| `isMax`, `isLoading` | `bool` | — |

---

### AppStatsGlassyStyle

Kartu statistik glassmorphism dengan noise texture.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `gradientColors` | `List<Color>?` | `defaultGradientColors` |
| `title`, `label`, `value` | `String?` | — |
| `icon` | `HeroIcons?` | — |
| `child` | `Widget?` | Jika diisi, menimpa seluruh konten text/icon default |
| `onTap` | `VoidCallback?` | — |
| `width`, `height` | `double?` | — |
| `isMax`, `isLoading` | `bool` | — |

---

## 16. Status

### AppCircularPercent

Progress ring melingkar dengan gradient, knob, dan label.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `progress` | `double` | **required** (0–1) |
| `gradientColors` | `List<Color>?` | `defaultGradientColors` |
| `label`, `value`, `title`, `subtitle` | `String?` | — |
| `labelColor` | `Color?` | — |
| `showPercentSign` | `bool` | `false` |
| `size`, `strokeWidth` | `double?` | — |
| `trackColor` | `Color?` | — |
| `isLoading` | `bool` | `false` |
| `onTap` | `VoidCallback?` | — |

**Preset gradient:** `defaultGradientColors`, `blueGradient`, `greenPurpleGradient`, `purplePinkGradient`

```dart
AppCircularPercent(
  progress: 0.75,
  title: 'Progress',
  subtitle: 'Target bulan ini',
  gradientColors: AppCircularPercent.blueGradient,
)
```

---

### AppEmptyState

State kosong dengan gambar/ikon dan aksi opsional.

| Parameter | Tipe | Keterangan |
|-----------|------|------------|
| `title` | `String` | **required** |
| `description` | `String` | **required** |
| `imageUrl` | `String?` | — |
| `customImageWidget` | `Widget?` | Prioritas tertinggi |
| `actionLabel` | `String?` | Butuh `onAction` juga |
| `onAction` | `VoidCallback?` | — |

Prioritas gambar: `customImageWidget` → `imageUrl` → ikon default (kaca pembesar).

---

### AppProgressBar

Bar progress linear dengan ikon dan teks opsional.

| Parameter | Tipe | Default |
|-----------|------|---------|
| `progress` | `double` | **required** (0–1) |
| `title`, `subtitle` | `String?` | — |
| `icon` | `HeroIcons?` | — |
| `color`, `backgroundColor` | `Color?` | — |
| `width` | `double?` | — |
| `height` | `double` | `8.0` |
| `mainAxisSize` | `MainAxisSize` | `max` |
| `iconSize` | `double` | `24.0` |

---

### AppSnackbar

Utility snackbar via GetX (bukan widget).

**Enum `AppSnackbarType`:** `normal`, `success`, `error`, `warning`

| Method | Parameter utama |
|--------|-----------------|
| `AppSnackbar.show({title, subtitle?, icon?, type, actionLabel?, onAction?, duration})` | Umum |
| `AppSnackbar.success({title, subtitle?, duration?})` | Hijau + ikon centang |
| `AppSnackbar.error({title, subtitle?, duration?})` | Merah + ikon error |
| `AppSnackbar.warning({title, subtitle?, duration?})` | Kuning + ikon warning |
| `AppSnackbar.info({title, subtitle?, duration?})` | Biru + ikon info |

Default `duration`: 3 detik. Posisi: atas layar.

```dart
AppSnackbar.success(title: 'Berhasil', subtitle: 'Data tersimpan.');
AppSnackbar.error(title: 'Gagal', subtitle: 'Coba lagi nanti.');

AppSnackbar.show(
  title: 'Pesan baru',
  type: AppSnackbarType.normal,
  actionLabel: 'Lihat',
  onAction: () => openInbox(),
);
```

---

## 17. Referensi Enum & Helper Types

| Type | File | Keterangan |
|------|------|------------|
| `AppButtonVariant`, `AppButtonShape`, `AppButtonSize`, `IconPosition` | `app_button.dart` | Button |
| `AppCheckboxVariant` | `app_checkbox.dart` | Checkbox |
| `AppRadioVariant` | `app_radio.dart` | Radio |
| `AppDialogVariant` | `app_dialog.dart` | Dialog |
| `AppNavigationBarVariant`, `AppNavigationBarItem` | `app_navigation_bar.dart` | Nav bar |
| `AppSnackbarType` | `app_snackbar.dart` | Snackbar |
| `AppCardStyle1Variant` | `app_card_style1.dart` | Card 1 |
| `AppCardStyle2Variant` | `app_card_style2.dart` | Card 2 |
| `AppCardStyle5Stat` | `app_card_style5.dart` | Card 5 stat |
| `AppTimelineStatus`, `AppTimelineNode` | `app_timeline.dart` | Timeline |
| `AppProfileCard1FooterItem` | `app_profile_card1.dart` | Profile footer |
| `AppTimeData` | `app_time_picker.dart` | Time picker |
| `AppDateTimeFormat` | `datetime_format_extension.dart` | Format tanggal |
| `AppCurrencyType` | `int_currency_format_extension.dart` | Format mata uang |
| `AppAnimationVariant` | `animated_extension.dart` | Animasi widget |

---

## 18. Dependencies

| Package | Digunakan oleh |
|---------|----------------|
| `get` | `AppScale`, `AppColors`, `AppDialog`, `AppSnackbar` |
| `flutter_screenutil` | `AppScale` |
| `skeletonizer` | Loading state cards & inputs |
| `cached_network_image` | `AppImage`, cards, dialogs |
| `heroicons` | Ikon di banyak komponen |
| `dotted_border` | `AppButton` variant dashed |
| `intl` | `CurrencyInputFormatter`, format currency |

Consumer app juga perlu menambahkan `get` dan `flutter_screenutil` secara eksplisit jika belum transitif.

---

## 19. Demo App

Living catalog semua komponen tersedia di folder `example/`:

```bash
cd example
flutter run
```

Demo mencakup light/dark toggle, semua variant widget, extension glassy & animated, dan smoke test otomatis.

---

## License

Private — all rights reserved unless otherwise specified.
