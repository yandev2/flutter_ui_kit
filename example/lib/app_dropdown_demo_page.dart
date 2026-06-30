import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppDropdownDemoPage extends StatefulWidget {
  const AppDropdownDemoPage({super.key});

  @override
  State<AppDropdownDemoPage> createState() => _AppDropdownDemoPageState();
}

class _AppDropdownDemoPageState extends State<AppDropdownDemoPage> {
  String? _singleValue;
  List<String> _multiValues = [];
  bool _tileSelected = false;
  bool _pillSelected = false;
  String _radioValue = 'option_1';

  final List<String> _items = [
    'Flutter',
    'React Native',
    'Swift',
    'Kotlin',
    'Go',
    'Python',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dropdown & Selection',
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
          _buildSectionTitle('1. Single Dropdown'),
          AppDropdown(
            title: 'Pilih Framework',
            hint: 'Pilih satu',
            prefixIcon: HeroIcons.codeBracket,
            items: _items,
            value: _singleValue,
            onChanged: (val) => setState(() => _singleValue = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('2. Multiple Dropdown'),
          AppDropdown(
            title: 'Pilih Skill',
            hint: 'Pilih beberapa',
            isMultiSelect: true,
            prefixIcon: HeroIcons.briefcase,
            items: _items,
            selectedValues: _multiValues,
            onMultiChanged: (val) => setState(() => _multiValues = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('3. Selection Tile'),
          AppSelectionTile(
            control: Checkbox(
              value: _tileSelected,
              onChanged: (_) {},
              activeColor: context.uiTheme.primary,
            ),
            title: 'Setuju Syarat & Ketentuan',
            description: 'Baca secara detail sebelum menyetujui perjanjian',
            isSelected: _tileSelected,
            onChanged: (val) => setState(() => _tileSelected = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('4. Selection Pill'),
          Wrap(
            spacing: 8,
            children: [
              AppSelectionPill(
                text: 'Label Filter',
                control: const SizedBox.shrink(),
                isSelected: _pillSelected,
                onChanged: (val) => setState(() => _pillSelected = val),
              ),
            ],
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('5. Radio Button Selection'),
          AppRadio<String>(
            value: 'option_1',
            groupValue: _radioValue,
            title: 'Opsi Pertama',
            onChanged: (val) {
              if (val != null) setState(() => _radioValue = val);
            },
          ).paddingOnly(bottom: AppSpacing.md),
          AppRadio<String>(
            value: 'option_2',
            groupValue: _radioValue,
            variant: AppRadioVariant.solid,
            title: 'Opsi Kedua (Solid)',
            description: 'Menggunakan varian solid',
            onChanged: (val) {
              if (val != null) setState(() => _radioValue = val);
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
