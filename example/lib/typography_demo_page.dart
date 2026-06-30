import 'package:flutter/material.dart';
import 'package:ui_component_flutter/theme/theme.dart';

class TypographyDemoPage extends StatelessWidget {
  const TypographyDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Typography Demo'),
        backgroundColor: context.uiTheme.primary,
        foregroundColor: context.uiTheme.onPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        children: [
          _buildTypographyItem('Display Large', textTheme.displayLarge),
          _buildTypographyItem('Display Medium', textTheme.displayMedium),
          _buildTypographyItem('Display Small', textTheme.displaySmall),
          const Divider(),
          _buildTypographyItem('Headline Large', textTheme.headlineLarge),
          _buildTypographyItem('Headline Medium', textTheme.headlineMedium),
          _buildTypographyItem('Headline Small', textTheme.headlineSmall),
          const Divider(),
          _buildTypographyItem('Title Large', textTheme.titleLarge),
          _buildTypographyItem('Title Medium', textTheme.titleMedium),
          _buildTypographyItem('Title Small', textTheme.titleSmall),
          const Divider(),
          _buildTypographyItem('Body Large', textTheme.bodyLarge),
          _buildTypographyItem('Body Medium', textTheme.bodyMedium),
          _buildTypographyItem('Body Small', textTheme.bodySmall),
          const Divider(),
          _buildTypographyItem('Label Large', textTheme.labelLarge),
          _buildTypographyItem('Label Medium', textTheme.labelMedium),
          _buildTypographyItem('Label Small', textTheme.labelSmall),
        ],
      ),
    );
  }

  Widget _buildTypographyItem(String name, TextStyle? style) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: style),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Size: ${style?.fontSize?.toStringAsFixed(1)} | Weight: ${style?.fontWeight.toString().replaceAll('FontWeight.', '')}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
