import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppProgressBarDemoPage extends StatefulWidget {
  const AppProgressBarDemoPage({super.key});

  @override
  State<AppProgressBarDemoPage> createState() => _AppProgressBarDemoPageState();
}

class _AppProgressBarDemoPageState extends State<AppProgressBarDemoPage> {
  double _progress = 0.3;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Progress Bar',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: context.uiTheme.onPrimary,
            fontSize: size(20),
          ),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
        actions: [
          IconButton(
            tooltip: 'Toggle Skeleton',
            icon: Icon(_isLoading ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            },
          ),
        ],
      ),
      backgroundColor: context.uiTheme.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interactive Demo',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size(24)),

            AppProgressBar(
              progress: _progress,
              title: 'Mengunggah Dokumen',
              subtitle: '${(_progress * 100).toInt()}%',
              icon: HeroIcons.documentArrowUp,
              isLoading: _isLoading,
            ),
            SizedBox(height: size(24)),

            AppProgressBar(
              progress: _progress,
              title: 'Kapasitas Penyimpanan',
              subtitle: '${(_progress * 100).toInt()} GB / 100 GB',
              icon: HeroIcons.server,
              color: context.uiTheme.warning,
              isLoading: _isLoading,
            ),
            SizedBox(height: size(24)),

            AppProgressBar(progress: _progress, isLoading: _isLoading),
            SizedBox(height: size(48)),

            // Control
            Text(
              'Simulasi Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _progress,
              onChanged: (val) {
                setState(() {
                  _progress = val;
                });
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton(
                  text: '0%',
                  variant: AppButtonVariant.outline,
                  onPressed: () => setState(() => _progress = 0.0),
                ),
                AppButton(
                  text: '50%',
                  variant: AppButtonVariant.outline,
                  onPressed: () => setState(() => _progress = 0.5),
                ),
                AppButton(
                  text: '100%',
                  variant: AppButtonVariant.outline,
                  onPressed: () => setState(() => _progress = 1.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
