# UI Component Flutter

A highly customizable and fully responsive Flutter UI Component package. Built with modern design system principles, providing seamless support for Light and Dark modes using Flutter's native `ThemeExtension`.

## Features
- **Responsive by Default**: All components, paddings, and font sizes scale perfectly across devices using `flutter_screenutil`.
- **First-class Dark Mode**: Semantic colors and backgrounds are optimized for dark mode to prevent eye strain.
- **Fully Customizable**: Override any color, spacing, or typography easily using `copyWith` without messy inheritance trees.

---

## 🚀 Getting Started

### 1. Initialization
Because this package is strictly responsive based on a design scale, you **must** wrap your `MaterialApp` with `ScreenUtilInit`. 

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui_component_flutter/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Set to your design draft size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'My App',
          // 2. Set the default theme here
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

---

## 🎨 How to Customize the Theme

This package uses Flutter's `ThemeExtension`, meaning you are not locked into our default "Sky Blue" primary color. You can override **any** base color, semantic color, or component color.

### Customizing Colors (Light Mode)

To customize the colors, you copy the default `lightTheme` and inject your own color preferences into `defaultUIComponentThemeLight`:

```dart
MaterialApp(
  title: 'My Custom App',
  theme: AppTheme.lightTheme.copyWith(
    extensions: <ThemeExtension<dynamic>>[
      // Override properties here!
      AppTheme.defaultUIComponentThemeLight.copyWith(
        primary: const Color(0xFF6200EE), // Custom Primary Color
        secondary: Colors.amber,          // Custom Secondary Color
        success: Colors.teal,             // Custom Semantic Color
        cardColor: Colors.white,          // Custom Card Color
        disabledColor: Colors.grey[300],  // Custom Component Color
      ),
    ],
  ),
  home: const MyHomePage(),
);
```

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
```

### AppDialog
Sebuah helper dan komponen untuk memunculkan modal dialog dinamis. Terintegrasi mulus dengan `showDialog` murni bawaan Flutter dan mewarisi properti tema aplikasi (sehingga anti repot saat pindah mode Terang/Gelap). Komponen ini juga memakai ukuran responsif secara menyeluruh!

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

// 3. Dialog dengan Gambar dan Konten Custom
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

// 2. Tampilkan Gambar dari Storage Device (Memakai dart:io dengan Fallback otomatis di Web)
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

### AppTextField & AppPasswordField
Komponen input teks yang interaktif dan *theme-aware*, lengkap dengan dukungan *error state*, *helper text*, serta *password strength indicator* untuk pengalaman keamanan pengguna yang lebih baik.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:heroicons/heroicons.dart';

// 1. Text Field Basic
AppTextField(
  title: 'Username',
  hint: 'Masukkan username',
  prefixIcon: HeroIcons.user,
  onChanged: (val) => print(val),
)

// 2. Text Field Email (Error State & Formatter)
AppTextField(
  title: 'Email',
  hint: 'email@domain.com',
  errorText: 'Format email tidak valid!',
  keyboardType: TextInputType.emailAddress,
  inputFormatters: [NoSpaceFormatter()], // Cegah spasi di input email
)

// 3. Password Field dengan Indikator Kekuatan
AppPasswordField(
  title: 'Password Baru',
  hint: 'Minimal 8 karakter',
  showStrengthIndicator: true, // Akan memunculkan bar indikator kekuatan password
  onChanged: (val) => print('Password diubah'),
)

// 4. Currency Field (Rupiah)
AppCurrencyField(
  title: 'Nominal Transfer',
  hint: '0',
  // Secara otomatis memakai format "Rp 1.000.000" dan merubah keyboard menjadi Number
  onChanged: (val) => print('Nominal: $val'),
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
Komponen `SliverPersistentHeader` untuk halaman utama dengan judul berefek parallax dan kotak pencarian (atau filter tab) yang menempel (pinned) di bagian bawah. Dirancang untuk tampil dinamis saat di-scroll.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

CustomScrollView(
  slivers: [
    AppMainAppbar(
      title: 'Daftar Produk',
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
Komponen untuk menampilkan riwayat status atau progres (seperti pelacakan pesanan atau *stepper*). Mendukung tata letak vertikal maupun horizontal, memiliki *Skeletonizer* bawaan untuk status *loading*, dan 4 *state* titik status (`completed`, `active`, `inactive`, `disabled`).

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

AppTimeline(
  direction: Axis.vertical, // Atau Axis.horizontal
  isLoading: false,         // Jika true, komponen berubah jadi skeleton otomatis
  nodes: [
    const AppTimelineNode(
      title: 'Pesanan Dibuat',
      subtitle: '12 Agt 2026',
      status: TimelineStatus.completed,
    ),
    AppTimelineNode(
      title: 'Pesanan Diproses',
      status: TimelineStatus.active,
      isHighlighted: true, // Memberi kotak sorotan pada konten
      content: AppButton(
        text: 'Lacak Lokasi',
        onPressed: () {},
      ),
    ),
    const AppTimelineNode(
      title: 'Selesai',
      status: TimelineStatus.inactive,
    ),
  ],
)
```

### AppProgressBar
Komponen batang progres dinamis dengan dukungan judul, sub-judul, ikon awalan (opsional), dan *Skeletonizer*. Lebar batang fleksibel dan bertransisi secara mulus ketika nilai `progress` (0.0 sampai 1.0) berubah.

```dart
import 'package:ui_component_flutter/ui_component_flutter.dart';

AppProgressBar(
  progress: 0.75, // 75%
  title: 'Mengunggah Data',
  subtitle: '75%',
  icon: HeroIcons.cloudArrowUp, // Opsional
  color: context.uiTheme.primary, // Bisa diganti warnanya
  isLoading: false,
)
```
