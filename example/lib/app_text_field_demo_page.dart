import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppTextFieldDemoPage extends StatefulWidget {
  const AppTextFieldDemoPage({super.key});

  @override
  State<AppTextFieldDemoPage> createState() => _AppTextFieldDemoPageState();
}

class _AppTextFieldDemoPageState extends State<AppTextFieldDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text & Password Field',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: context.uiTheme.onPrimary),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.xl),
        children: [
          _buildSectionTitle('1. Basic Text Field'),
          AppTextField(
            title: 'Username',
            hint: 'Masukkan username',
            prefixIcon: HeroIcons.user,
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('2. Error State Text Field'),
          AppTextField(
            title: 'Email Address',
            hint: 'johndoe@example.com',
            prefixIcon: HeroIcons.envelope,
            errorText: 'Format email tidak valid',
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [NoSpaceFormatter()],
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('3. Helper Text Field'),
          AppTextField(
            title: 'Nomor Telepon',
            hint: '0812-3456-7890',
            prefixIcon: HeroIcons.phone,
            helperText: 'Nomor telepon akan digunakan untuk OTP',
            keyboardType: TextInputType.phone,
            inputFormatters: [MaskInputFormatter(mask: '####-####-####-####')],
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('4. Password Field (Strength Indicator)'),
          AppPasswordField(
            title: 'Password Baru',
            hint: 'Minimal 8 karakter',
            onChanged: (val) {
              // indikator sudah bekerja internal
            },
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('5. Currency Field (Rupiah)'),
          AppCurrencyField(
            title: 'Nominal Transfer',
            hint: '0',
            onChanged: (val) {
              // val akan berisi format 'Rp 10.000'
            },
          ).paddingOnly(bottom: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ).paddingOnly(bottom: AppSpacing.sm);
  }
}
