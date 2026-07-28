import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppProgressCircleDemoPage extends StatefulWidget {
  const AppProgressCircleDemoPage({super.key});

  @override
  State<AppProgressCircleDemoPage> createState() =>
      _AppProgressCircleDemoPageState();
}

class _AppProgressCircleDemoPageState extends State<AppProgressCircleDemoPage> {
  double _progress = 0.3;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Progress Circle',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: size(20),
              ),
        ),
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
              'Gradient Showcase',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: size(16)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  AppProgressCircle(
                    progress: 0.3,
                    label: 'Label',
                    title: 'Your Score',
                    description: 'as on 15 April 2025 6:18 pm',
                    gradientColors: const [
                      Color(0xFF2563EB),
                      Color(0xFF38BDF8),
                    ],
                    isLoading: _isLoading,
                  ),
                  SizedBox(width: size(16)),
                  AppProgressCircle(
                    progress: 0.5,
                    label: 'Label',
                    title: 'Your Score',
                    description: 'as on 15 April 2025 6:18 pm',
                    gradientColors: const [
                      Color(0xFF10B981),
                      Color(0xFF8B5CF6),
                    ],
                    isLoading: _isLoading,
                  ),
                  SizedBox(width: size(16)),
                  AppProgressCircle(
                    progress: 0.7,
                    label: 'Label',
                    title: 'Your Score',
                    description: 'as on 15 April 2025 6:18 pm',
                    gradientColors: const [
                      Color(0xFF6366F1),
                      Color(0xFFEC4899),
                    ],
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
            SizedBox(height: size(32)),
            Text(
              'Solid Color',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: size(16)),
            Center(
              child: AppProgressCircle(
                progress: 0.65,
                label: 'Storage',
                title: 'Used Space',
                description: '65 GB of 100 GB',
                color: context.uiTheme.warning,
                isLoading: _isLoading,
              ),
            ),
            SizedBox(height: size(32)),
            Text(
              'Custom Styles & Size',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: size(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppProgressCircle(
                  progress: 0.45,
                  label: 'Small',
                  title: 'Compact',
                  diameter: 120,
                  valueSize: 28,
                  titleSize: 12,
                  gradientColors: const [
                    Color(0xFF14B8A6),
                    Color(0xFF06B6D4),
                  ],
                  labelBackgroundColor:
                      context.uiTheme.info.withValues(alpha: 0.15),
                  labelColor: context.uiTheme.info,
                  isLoading: _isLoading,
                ),
                AppProgressCircle(
                  progress: 0.85,
                  label: 'Large',
                  title: 'Expanded',
                  diameter: 200,
                  valueSize: 44,
                  strokeWidth: 14,
                  gradientColors: const [
                    Color(0xFFF97316),
                    Color(0xFFEF4444),
                  ],
                  isLoading: _isLoading,
                ),
              ],
            ),
            SizedBox(height: size(32)),
            Text(
              'Interactive Demo',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: size(16)),
            Center(
              child: AppProgressCircle(
                progress: _progress,
                label: 'Progress',
                title: 'Upload Status',
                description: '${(_progress * 100).round()}% completed',
                gradientColors: const [
                  Color(0xFF3B82F6),
                  Color(0xFFA855F7),
                ],
                isLoading: _isLoading,
              ),
            ),
            SizedBox(height: size(24)),
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
            SizedBox(height: size(32)),
          ],
        ),
      ),
    );
  }
}
