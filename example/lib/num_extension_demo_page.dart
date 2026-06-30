import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class NumExtensionDemoPage extends StatefulWidget {
  const NumExtensionDemoPage({super.key});

  @override
  State<NumExtensionDemoPage> createState() => _NumExtensionDemoPageState();
}

class _NumExtensionDemoPageState extends State<NumExtensionDemoPage> {
  final double _fraction = 0.556;
  final double _percentRaw = 75;
  final num _largeNumber = 12500000;
  final String _stringPercent = "85.5%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Number Extension',
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
          _buildSectionTitle(context, '1. Format to Percentage'),
          _buildFormatDemo(
            context,
            'Fraction (0.0 to 1.0) -> "$_fraction"',
            _fraction.toPercent(),
          ),
          _buildFormatDemo(
            context,
            'With Comma (useComma: true)',
            _fraction.toPercent(fractionDigits: 1, useComma: true),
          ),
          _buildFormatDemo(
            context,
            'Raw Percentage (>1.0) -> "$_percentRaw"',
            _percentRaw.toPercent(),
          ),
          _buildFormatDemo(
            context,
            'Force Fraction (isFraction: true) -> "1.5"',
            1.5.toPercent(isFraction: true), // Will be 150%
          ),
          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '2. Thousand Separator'),
          _buildFormatDemo(
            context,
            'Large Number -> "$_largeNumber"',
            _largeNumber.toThousandFormat(),
          ),
          _buildFormatDemo(
            context,
            'Custom Separator (comma)',
            _largeNumber.toThousandFormat(separator: ','),
          ),
          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '3. String to Percent (Reverse Parse)'),
          _buildFormatDemo(
            context,
            'Input String -> "$_stringPercent"',
            _stringPercent.toPercentFraction()?.toString() ?? 'Invalid',
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
