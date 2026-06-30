import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppMonthPickerDemoPage extends StatefulWidget {
  const AppMonthPickerDemoPage({super.key});

  @override
  State<AppMonthPickerDemoPage> createState() => _AppMonthPickerDemoPageState();
}

class _AppMonthPickerDemoPageState extends State<AppMonthPickerDemoPage> {
  int? _selectedMonth1;
  int? _selectedMonth2;
  int? _selectedMonth3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppMonthPicker Demo',
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
          _buildSectionTitle('1. Basic Month Picker'),
          AppMonthPicker(
            hint: 'Pilih bulan',
            value: _selectedMonth1,
            onChanged: (val) => setState(() => _selectedMonth1 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('2. With Title & Prefix Icon'),
          AppMonthPicker(
            title: 'Bulan Kedatangan',
            hint: 'Pilih bulan',
            prefixIcon: HeroIcons.calendar,
            value: _selectedMonth2,
            onChanged: (val) => setState(() => _selectedMonth2 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('3. Loading State'),
          AppMonthPicker(
            title: 'Bulan Sinkronisasi',
            hint: 'Sedang memuat data...',
            isLoading: true,
            value: _selectedMonth3,
            onChanged: (val) => setState(() => _selectedMonth3 = val),
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
