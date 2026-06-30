import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class GenericFormattersDemoPage extends StatelessWidget {
  const GenericFormattersDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generic Formatters',
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
          Text(
            'Utility Input Formatters',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ).paddingOnly(bottom: AppSpacing.sm),
          Text(
            'Cobalah mengetik di dalam field berikut untuk melihat efek pemformatan otomatis.',
            style: TextStyle(color: context.uiTheme.hintColor),
          ).paddingOnly(bottom: AppSpacing.xl),

          // 1. Text Case
          _buildSubtitle('1. UpperCase & LowerCase'),
          _buildTextField(
            context,
            hint: 'Ketik apa saja (Otomatis Kapital)',
            formatters: [UpperCaseTextFormatter()],
          ),
          SizedBox(height: AppSpacing.sm),
          _buildTextField(
            context,
            hint: 'KETIK APA SAJA (Otomatis Kecil)',
            formatters: [LowerCaseTextFormatter()],
          ),
          SizedBox(height: AppSpacing.xl),

          // 2. Anti Spasi
          _buildSubtitle('2. No-Space Formatter (Email/Username)'),
          _buildTextField(
            context,
            hint: 'Coba ketik pakai spasi (Ditolak)',
            formatters: [NoSpaceFormatter()],
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: AppSpacing.xl),

          // 3. Masking - NPWP
          _buildSubtitle('3. Generic Masking (NPWP)'),
          _buildTextField(
            context,
            hint: '12.345.678.9-012.000',
            formatters: [MaskInputFormatter(mask: '##.###.###.#-###.###')],
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppSpacing.xl),

          // 4. Masking - Phone
          _buildSubtitle('4. Generic Masking (Nomor HP)'),
          _buildTextField(
            context,
            hint: '0812-3456-7890',
            formatters: [MaskInputFormatter(mask: '####-####-####-####')],
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: AppSpacing.xl),

          // 5. Card Number
          _buildSubtitle('5. Generic Masking (Kartu Kredit)'),
          _buildTextField(
            context,
            hint: '1234 5678 9012 3456',
            formatters: [MaskInputFormatter(mask: '#### #### #### ####')],
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppSpacing.xl),

          // 6. Card Expiry
          _buildSubtitle('6. Card Expiry Formatter'),
          _buildTextField(
            context,
            hint: 'MM/YY (Coba ketik angka > 12)',
            formatters: [CardExpiryFormatter()],
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ).paddingOnly(bottom: AppSpacing.xs);
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hint,
    required List<TextInputFormatter> formatters,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      keyboardType: keyboardType,
      inputFormatters: formatters,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        filled: true,
        fillColor: context.uiTheme.surface,
      ),
    );
  }
}
