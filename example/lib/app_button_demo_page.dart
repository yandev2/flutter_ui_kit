import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppButtonDemoPage extends StatelessWidget {
  const AppButtonDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppButton Demo',
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
          _buildSectionTitle('1. Variants'),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton(
                text: 'Solid',
                onPressed: () {},
                variant: AppButtonVariant.solid,
              ),
              AppButton(
                text: 'Outline',
                onPressed: () {},
                variant: AppButtonVariant.outline,
              ),
              AppButton(
                text: 'Dashed',
                onPressed: () {},
                variant: AppButtonVariant.dashed,
              ),
              AppButton(
                text: 'Smooth',
                onPressed: () {},
                variant: AppButtonVariant.smooth,
              ),
              AppButton(
                text: 'Gradient',
                onPressed: () {},
                variant: AppButtonVariant.gradient,
              ),
              AppButton(
                text: 'Raised',
                onPressed: () {},
                variant: AppButtonVariant.raised,
              ),
              AppButton(
                text: 'Text',
                onPressed: () {},
                variant: AppButtonVariant.text,
              ),
            ],
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('2. Shapes'),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton(
                text: 'Rounded',
                onPressed: () {},
                shape: AppButtonShape.rounded,
              ),
              AppButton(
                text: 'Pill',
                onPressed: () {},
                shape: AppButtonShape.pill,
              ),
              AppButton(
                text: 'Sq',
                onPressed: () {},
                shape: AppButtonShape.square,
              ),
            ],
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('3. Sizes'),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppButton(
                text: 'Small',
                onPressed: () {},
                size: AppButtonSize.small,
              ),
              AppButton(
                text: 'Medium',
                onPressed: () {},
                size: AppButtonSize.medium,
              ),
              AppButton(
                text: 'Large',
                onPressed: () {},
                size: AppButtonSize.large,
              ),
            ],
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('4. Icon Placement'),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton(
                text: 'Left Icon',
                icon: Icons.favorite,
                iconPosition: IconPosition.left,
                onPressed: () {},
              ),
              AppButton(
                text: 'Right Icon',
                icon: Icons.arrow_forward,
                iconPosition: IconPosition.right,
                onPressed: () {},
              ),
              AppButton(
                text: 'Top Icon',
                icon: Icons.cloud_upload,
                iconPosition: IconPosition.top,
                onPressed: () {},
              ),
            ],
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('5. Icon-Only Buttons'),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton.icon(icon: Icons.add, onPressed: () {}),
              AppButton.icon(
                icon: Icons.delete,
                shape: AppButtonShape.square,
                variant: AppButtonVariant.outline,
                color: context.uiTheme.danger,
                onPressed: () {},
              ),
              AppButton.icon(
                icon: Icons.notifications,
                variant: AppButtonVariant.smooth,
                color: context.uiTheme.warning,
                onPressed: () {},
              ),
            ],
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('6. Loading State'),
          AppButton(
            text: 'Submit Data',
            isLoading: true,
            isMax: true,
            onPressed: () {},
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('7. Custom Colors'),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton(
                text: 'Success',
                color: context.uiTheme.success,
                onPressed: () {},
              ),
              AppButton(
                text: 'Danger Outline',
                color: context.uiTheme.danger,
                variant: AppButtonVariant.outline,
                onPressed: () {},
              ),
              AppButton(
                text: 'Custom Gradient',
                gradientColors: const [Colors.orange, Colors.deepOrange],
                onPressed: () {},
              ),
            ],
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
