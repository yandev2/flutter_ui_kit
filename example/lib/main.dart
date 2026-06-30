import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui_component_flutter/theme/theme.dart';
import 'typography_demo_page.dart';
import 'animation_demo_page.dart';
import 'date_extension_demo_page.dart';
import 'num_extension_demo_page.dart';
import 'currency_extension_demo_page.dart';
import 'string_extension_demo_page.dart';
import 'widget_extension_demo_page.dart';
import 'glassy_extension_demo_page.dart';
import 'currency_formatter_demo_page.dart';
import 'generic_formatters_demo_page.dart';
import 'app_button_demo_page.dart';
import 'app_dialog_demo_page.dart';
import 'app_bottom_navigation_demo_page.dart';
import 'app_segmented_switch_demo_page.dart';
import 'app_switch_button_demo_page.dart';
import 'app_date_picker_demo_page.dart';
import 'app_year_picker_demo_page.dart';
import 'app_time_picker_demo_page.dart';
import 'app_month_picker_demo_page.dart';
import 'app_dropdown_demo_page.dart';
import 'app_text_field_demo_page.dart';
import 'app_otp_demo_page.dart';
import 'app_image_upload_demo_page.dart';
import 'app_file_upload_demo_page.dart';
import 'app_snackbar_demo_page.dart';
import 'app_dashboard_appbar_demo_page.dart';
import 'app_main_appbar_demo_page.dart';
import 'app_detail_appbar_demo_page.dart';
import 'app_timeline_demo_page.dart';
import 'app_progress_bar_demo_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Membungkus MaterialApp dengan ScreenUtilInit
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'UI Component Example',
          // Penggunaan default:
          // theme: AppTheme.lightTheme,

          // Contoh penggunaan jika User ingin meng-custom warnanya:
          theme: AppTheme.lightTheme.copyWith(
            extensions: <ThemeExtension<dynamic>>[
              AppTheme.defaultUIComponentThemeLight.copyWith(
                primary: Colors.indigo, // User mengubah primary
                success: Colors.teal, // User mengubah success
              ),
            ],
          ),
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UI Component',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: context.uiTheme.onPrimary,
            fontSize: size(20),
          ),
        ),
        backgroundColor: context.uiTheme.primary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        children: [
          _buildMenuCard(
            context,
            title: 'Typography',
            description: 'Semua text styles bawaan Flutter TextTheme',
            icon: Icons.text_fields,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TypographyDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'Animations',
            description: 'Widget extension untuk float & shake animasi',
            icon: Icons.animation,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnimationDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'Date Extension',
            description: 'Format Date ke String dan sebaliknya',
            icon: Icons.date_range,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DateExtensionDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'Number Extension',
            description: 'Format Persentase & Ribuan',
            icon: Icons.numbers,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NumExtensionDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'Currency Extension',
            description: 'Format Uang Lengkap (Rupiah, Dollar)',
            icon: Icons.attach_money,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CurrencyExtensionDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'String Extension',
            description: 'Manipulasi String, Validator, Parsing',
            icon: Icons.text_format,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StringExtensionDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'Widget Extension',
            description: 'UI Deklaratif (No Nesting Hell)',
            icon: Icons.widgets,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WidgetExtensionDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'Glassy Extension',
            description: 'Efek Glassmorphism Modern',
            icon: Icons.blur_on,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GlassyExtensionDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'Currency Formatter',
            description: 'Input TextField Mata Uang',
            icon: Icons.input,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CurrencyFormatterDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'Generic Formatters',
            description: 'Masking, Anti-Spasi, Kapitalisasi',
            icon: Icons.auto_fix_high,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GenericFormattersDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Button Component',
            description: 'Tombol Fleksibel (Solid, Outline, dll)',
            icon: Icons.smart_button,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppButtonDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Dialog Component',
            description: 'Dialog Dinamis (Success, Error, dll)',
            icon: Icons.window,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppDialogDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Bottom Navigation',
            description: 'Navigasi Bawah Animatif',
            icon: Icons.horizontal_split,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppBottomNavigationDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Segmented Switch',
            description: 'Pilihan opsi beranimasi (Sliding)',
            icon: Icons.toggle_on,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppSegmentedSwitchDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Switch Button',
            description: 'Tombol Switch (Toggle) dengan Judul & Deskripsi',
            icon: Icons.toggle_on_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppSwitchButtonDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Date Picker',
            description: 'Pemilih Tanggal dengan Popup Interaktif',
            icon: Icons.calendar_month,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppDatePickerDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Year Picker',
            description: 'Pemilih Tahun dengan Scroll Wheel (3D)',
            icon: Icons.access_time_filled,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppYearPickerDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Time Picker',
            description: 'Pemilih Waktu (Jam, Menit, Detik) dengan popup',
            icon: Icons.access_time,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppTimePickerDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Month Picker',
            description: 'Pemilih Bulan dengan Scroll Wheel (3D)',
            icon: Icons.calendar_view_month,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppMonthPickerDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Dropdown & Selection',
            description: 'Dropdown (Single/Multi) & Selection Components',
            icon: Icons.arrow_drop_down_circle,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppDropdownDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Text & Password Field',
            description: 'Input teks dan password dengan strength indicator',
            icon: Icons.text_fields,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppTextFieldDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App OTP Form',
            description:
                'Form Input OTP Animatif dengan Fitur Auto-focus & Skeletonizer',
            icon: Icons.password,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppOtpDemoPage()),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Image Upload',
            description: 'Komponen Upload Gambar (Kamera & Galeri)',
            icon: Icons.image,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppImageUploadDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App File Upload',
            description: 'Komponen Upload File Serbaguna',
            icon: Icons.file_upload,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppFileUploadDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Snackbar',
            description: 'Notifikasi Snackbar Dinamis (Success, Error)',
            icon: Icons.notifications,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppSnackbarDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Dashboard Appbar',
            description: 'Sliver Appbar bergaya Dashboard (Avatar & Tema)',
            icon: Icons.dashboard,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppDashboardAppbarDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Main Appbar',
            description: 'Sliver Appbar dengan Pencarian Parallax',
            icon: Icons.view_day,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppMainAppbarDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Detail Appbar',
            description: 'Sliver Appbar bergaya kartu (Meringkuk di bawah)',
            icon: Icons.article,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppDetailAppbarDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Timeline',
            description: 'Komponen status/progress (Vertical & Horizontal)',
            icon: Icons.timeline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppTimelineDemoPage(),
                ),
              );
            },
          ),
          _buildMenuCard(
            context,
            title: 'App Progress Bar',
            description: 'Bar persentase animasi dengan ikon opsional',
            icon: Icons.data_usage,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppProgressBarDemoPage(),
                ),
              );
            },
          ),
          // Tambahkan komponen lain di sini nantinya (misal: Colors, Buttons, dll)
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      color: context.uiTheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: context.uiTheme.borderColor),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        leading: Container(
          padding: EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: context.uiTheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: context.uiTheme.primary),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(
          description,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: context.uiTheme.hintColor),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: context.uiTheme.disabledColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
