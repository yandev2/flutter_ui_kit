import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class CurrencyExtensionDemoPage extends StatefulWidget {
  const CurrencyExtensionDemoPage({super.key});

  @override
  State<CurrencyExtensionDemoPage> createState() =>
      _CurrencyExtensionDemoPageState();
}

class _CurrencyExtensionDemoPageState extends State<CurrencyExtensionDemoPage> {
  final num _smallValue = 15000;
  final num _valueWithDecimals = 15000.75;
  final num _largeValue = 25000000;
  final num _negativeValue = -5000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Extension',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: context.uiTheme.onPrimary),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        children: [
          _buildSectionTitle(context, '1. Standard Rupiah'),
          _buildFormatDemo(
            context,
            '$_smallValue (no decimals)',
            _smallValue.toRupiah(),
          ),
          _buildFormatDemo(
            context,
            '$_valueWithDecimals (2 decimals)',
            _valueWithDecimals.toRupiah(decimalDigits: 2),
          ),
          _buildFormatDemo(
            context,
            '$_negativeValue (Negative)',
            _negativeValue.toRupiah(),
          ),
          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '2. Other Currencies (Dollar, Euro)'),
          _buildFormatDemo(
            context,
            '$_valueWithDecimals to Dollar',
            _valueWithDecimals.toDollar(),
          ),
          _buildFormatDemo(
            context,
            '$_valueWithDecimals to Euro',
            _valueWithDecimals.toCurrency(
              type: AppCurrencyType.euro,
              decimalDigits: 2,
              symbolSeparator: ' ',
            ),
          ),
          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '3. Compact Format (Large Numbers)'),
          _buildFormatDemo(
            context,
            '$_largeValue (Rupiah Compact)',
            _largeValue.toRupiah(compact: true),
          ),
          _buildFormatDemo(
            context,
            '$_largeValue (Dollar Compact)',
            _largeValue.toDollar(compact: true),
          ),
          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '4. Reverse Parse (String to Num)'),
          _buildFormatDemo(
            context,
            '"Rp 1.500.000,50" -> Number',
            "Rp 1.500.000,50"
                    .toCurrencyFraction(AppCurrencyType.rupiah)
                    ?.toString() ??
                'Invalid',
          ),
          _buildFormatDemo(
            context,
            '"\$1,500.50" -> Number',
            "\$1,500.50"
                    .toCurrencyFraction(AppCurrencyType.dollar)
                    ?.toString() ??
                'Invalid',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: context.uiTheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFormatDemo(BuildContext context, String label, String value) {
    return Card(
      color: context.uiTheme.surface,
      elevation: 0,
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: context.uiTheme.borderColor),
      ),
      child: ListTile(
        title: Text(label, style: Theme.of(context).textTheme.labelMedium),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: context.uiTheme.success,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
