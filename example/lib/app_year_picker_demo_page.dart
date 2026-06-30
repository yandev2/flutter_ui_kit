import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppYearPickerDemoPage extends StatefulWidget {
  const AppYearPickerDemoPage({super.key});

  @override
  State<AppYearPickerDemoPage> createState() => _AppYearPickerDemoPageState();
}

class _AppYearPickerDemoPageState extends State<AppYearPickerDemoPage> {
  int? _selectedYear1;
  int? _selectedYear2;
  int? _selectedYear3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppYearPicker Demo',
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
          _buildSectionTitle('1. Basic Year Picker'),
          AppYearPicker(
            hint: 'Pilih tahun',
            value: _selectedYear1,
            onChanged: (val) => setState(() => _selectedYear1 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('2. With Title & Prefix Icon'),
          AppYearPicker(
            title: 'Tahun Kendaraan',
            hint: 'Pilih tahun perakitan kendaraan',
            prefixIcon: HeroIcons.truck,
            value: _selectedYear2,
            onChanged: (val) => setState(() => _selectedYear2 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('3. Loading State'),
          AppYearPicker(
            title: 'Tahun Lulus',
            hint: 'Sedang memuat data...',
            isLoading: true,
            value: _selectedYear3,
            onChanged: (val) => setState(() => _selectedYear3 = val),
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
