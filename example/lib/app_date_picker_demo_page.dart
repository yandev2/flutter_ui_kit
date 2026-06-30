import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppDatePickerDemoPage extends StatefulWidget {
  const AppDatePickerDemoPage({super.key});

  @override
  State<AppDatePickerDemoPage> createState() => _AppDatePickerDemoPageState();
}

class _AppDatePickerDemoPageState extends State<AppDatePickerDemoPage> {
  DateTime? _selectedDate1;
  DateTime? _selectedDate2;
  DateTime? _selectedDate3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppDatePicker Demo',
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
          _buildSectionTitle('1. Basic Date Picker'),
          AppDatePicker(
            hint: 'Pilih tanggal',
            value: _selectedDate1,
            onChanged: (val) => setState(() => _selectedDate1 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('2. With Title & Prefix Icon'),
          AppDatePicker(
            title: 'Tanggal Lahir',
            hint: 'Pilih tanggal lahir Anda',
            prefixIcon: HeroIcons.calendarDays,
            value: _selectedDate2,
            onChanged: (val) => setState(() => _selectedDate2 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('3. Loading State'),
          AppDatePicker(
            title: 'Tanggal Keberangkatan',
            hint: 'Sedang memuat tanggal...',
            isLoading: true,
            value: _selectedDate3,
            onChanged: (val) => setState(() => _selectedDate3 = val),
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
