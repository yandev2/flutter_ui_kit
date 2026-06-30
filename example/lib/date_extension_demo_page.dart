import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class DateExtensionDemoPage extends StatefulWidget {
  const DateExtensionDemoPage({super.key});

  @override
  State<DateExtensionDemoPage> createState() => _DateExtensionDemoPageState();
}

class _DateExtensionDemoPageState extends State<DateExtensionDemoPage> {
  final DateTime _sampleDate = DateTime(2023, 8, 17, 10, 30);
  final String _customStringInput = "17 Agustus 2023";
  final String _isoStringInput = "2023-08-17T10:30:00.000Z";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Date Extension',
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
          _buildSectionTitle(context, '1. Format Date to String'),
          Text(
            'Raw Date: $_sampleDate',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: context.uiTheme.hintColor),
          ),
          SizedBox(height: AppSpacing.sm),
          _buildFormatDemo(
            context,
            'AppDateTimeFormat.dmyNumeric',
            _sampleDate.formatted(AppDateTimeFormat.dmyNumeric),
          ),
          _buildFormatDemo(
            context,
            'AppDateTimeFormat.dmyShortMonth',
            _sampleDate.formatted(AppDateTimeFormat.dmyShortMonth),
          ),
          _buildFormatDemo(
            context,
            'AppDateTimeFormat.dmyFullMonth',
            _sampleDate.formatted(AppDateTimeFormat.dmyFullMonth),
          ),
          _buildFormatDemo(
            context,
            'AppDateTimeFormat.monthYear',
            _sampleDate.formatted(AppDateTimeFormat.monthYear),
          ),
          _buildFormatDemo(
            context,
            'AppDateTimeFormat.timeHm',
            _sampleDate.formatted(AppDateTimeFormat.timeHm),
          ),
          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '2. String to Date (Reverse)'),
          Text(
            'Input String: "$_customStringInput"',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: context.uiTheme.hintColor),
          ),
          SizedBox(height: AppSpacing.sm),
          _buildFormatDemo(
            context,
            'Parsed with dmyFullMonth',
            _customStringInput
                    .toDate(AppDateTimeFormat.dmyFullMonth)
                    ?.toString() ??
                'Invalid',
          ),
          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '3. ISO String to Formatted Date'),
          Text(
            'Input ISO String: "$_isoStringInput"',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: context.uiTheme.hintColor),
          ),
          SizedBox(height: AppSpacing.sm),
          _buildFormatDemo(
            context,
            'Formatted as dmyShortMonth',
            _isoStringInput.toFormattedDate(AppDateTimeFormat.dmyShortMonth),
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
