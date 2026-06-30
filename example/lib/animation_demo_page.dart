import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart'; // Imports the new AnimatedWidgetExtension

class AnimationDemoPage extends StatelessWidget {
  const AnimationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Extension Demo'),
        backgroundColor: context.uiTheme.primary,
        foregroundColor: context.uiTheme.onPrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Vertical Float
              Container(
                padding: EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.uiTheme.primary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  boxShadow: [
                    BoxShadow(
                      color: context.uiTheme.shadowColor.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  'Float Vertical',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.uiTheme.onPrimary,
                  ),
                ),
              ).animated(
                variant: AppAnimationVariant.floatVertical,
                intensity: 0.8,
              ),

              SizedBox(height: AppSpacing.xxl * 2),

              // Horizontal Float
              Container(
                padding: EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.uiTheme.secondary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  'Float Horizontal',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.uiTheme.onSecondary,
                  ),
                ),
              ).animated(
                variant: AppAnimationVariant.floatHorizontal,
                intensity: 0.8,
              ),

              SizedBox(height: AppSpacing.xxl * 2),

              // Shake
              Container(
                padding: EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.uiTheme.error,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  'Shake',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.uiTheme.onError,
                  ),
                ),
              ).animated(variant: AppAnimationVariant.shake, intensity: 1.0),

              SizedBox(height: AppSpacing.xxl * 2),

              // Pulse
              Container(
                padding: EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.uiTheme.success,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  'Pulse',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.uiTheme.surface,
                  ),
                ),
              ).animated(variant: AppAnimationVariant.pulse, intensity: 1.0),

              SizedBox(height: AppSpacing.xxl * 2),

              // Fade
              Container(
                padding: EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.uiTheme.info,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  'Fade',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.uiTheme.surface,
                  ),
                ),
              ).animated(variant: AppAnimationVariant.fade, intensity: 1.0),
            ],
          ),
        ),
      ),
    );
  }
}
