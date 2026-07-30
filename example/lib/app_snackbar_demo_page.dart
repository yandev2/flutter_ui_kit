import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppSnackbarDemoPage extends StatefulWidget {
  const AppSnackbarDemoPage({super.key});

  @override
  State<AppSnackbarDemoPage> createState() => _AppSnackbarDemoPageState();
}

class _AppSnackbarDemoPageState extends State<AppSnackbarDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Snackbar',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: size(20),
          ),
        )
      ),
      backgroundColor: context.uiTheme.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            AppButton(
              text: 'Show Success Snackbar',
              variant: AppButtonVariant.outline,
              isMax: true,
              onPressed: () {
                AppSnackbar.success(
                  context,
                  title: 'Success!',
                  subtitle: 'Your data has been saved successfully.',
                );
              },
            ),
            SizedBox(height: size(16)),
            AppButton(
              text: 'Show Error Snackbar',
              variant: AppButtonVariant.outline,
              isMax: true,
              onPressed: () {
                AppSnackbar.error(
                  context,
                  title: 'Error!',
                  subtitle: 'Failed to connect to the server.',
                );
              },
            ),
            SizedBox(height: size(16)),
            AppButton(
              text: 'Show Info Snackbar',
              variant: AppButtonVariant.outline,
              isMax: true,
              onPressed: () {
                AppSnackbar.info(
                  context,
                  title: 'Update Available',
                  subtitle: 'A new version of the app is available.',
                );
              },
            ),
            SizedBox(height: size(16)),
            AppButton(
              text: 'Show Warning Snackbar',
              variant: AppButtonVariant.outline,
              isMax: true,
              onPressed: () {
                AppSnackbar.warning(
                  context,
                  title: 'Warning!',
                  subtitle: 'Your subscription will expire in 3 days.',
                );
              },
            ),
            SizedBox(height: size(32)),
            Text(
              'Advanced Options',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: size(16)),
            AppButton(
              text: 'Snackbar with Action',
              isMax: true,
              onPressed: () {
                AppSnackbar.show(
                  context,
                  title: 'Item Deleted',
                  type: AppSnackbarType.normal,
                  actionLabel: 'UNDO',
                  onAction: () {
                    AppSnackbar.success(
                      context,
                      title: 'Restored',
                      subtitle: 'The item has been restored.',
                    );
                  },
                );
              },
            ),
            SizedBox(height: size(16)),
            AppButton(
              text: 'Show Top Snackbar',
              isMax: true,
              onPressed: () {
                AppSnackbar.info(
                  context,
                  title: 'Top Notification',
                  subtitle: 'This snackbar appears at the top of the screen.',
                  positionTop: true,
                );
              },
            ),
            SizedBox(height: size(16)),
            AppButton(
              text: 'Show Top Snackbar (Custom Offset)',
              isMax: true,
              onPressed: () {
                AppSnackbar.info(
                  context,
                  title: 'Custom Top Offset',
                  subtitle: 'Positioned below app bar area (offset: 80).',
                  positionTop: true,
                  offset: 80,
                );
              },
            ),
            SizedBox(height: size(16)),
            AppButton(
              text: 'Show Bottom Snackbar (Custom Offset)',
              isMax: true,
              onPressed: () {
                AppSnackbar.success(
                  context,
                  title: 'Custom Bottom Offset',
                  subtitle: 'Raised above bottom edge (offset: 32).',
                  offset: 32,
                );
              },
            ),
            SizedBox(height: size(16)),
            AppButton(
              text: 'Show Snackbar (Custom Text Size)',
              isMax: true,
              onPressed: () {
                AppSnackbar.show(
                  context,
                  title: 'Custom Typography',
                  subtitle: 'Smaller title and subtitle text.',
                  type: AppSnackbarType.normal,
                  actionLabel: 'OK',
                  onAction: () {},
                  titleSize: 12,
                  subtitleSize: 10,
                  actionLabelSize: 12,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
