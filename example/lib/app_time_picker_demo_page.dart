import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppTimePickerDemoPage extends StatefulWidget {
  const AppTimePickerDemoPage({super.key});

  @override
  State<AppTimePickerDemoPage> createState() => _AppTimePickerDemoPageState();
}

class _AppTimePickerDemoPageState extends State<AppTimePickerDemoPage> {
  AppTimeData? _selectedTime1;
  AppTimeData? _selectedTime2;
  AppTimeData? _selectedTime3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppTimePicker Demo',
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
          _buildSectionTitle('1. Basic Time Picker'),
          AppTimePicker(
            hint: 'Pilih waktu',
            value: _selectedTime1,
            onChanged: (val) => setState(() => _selectedTime1 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('2. With Title & Prefix Icon'),
          AppTimePicker(
            title: 'Waktu Kedatangan',
            hint: 'Kapan Anda tiba?',
            prefixIcon: HeroIcons.clock,
            value: _selectedTime2,
            onChanged: (val) => setState(() => _selectedTime2 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('3. Loading State'),
          AppTimePicker(
            title: 'Waktu Sinkronisasi',
            hint: 'Sedang memuat data...',
            isLoading: true,
            value: _selectedTime3,
            onChanged: (val) => setState(() => _selectedTime3 = val),
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
