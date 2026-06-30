import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class WidgetExtensionDemoPage extends StatefulWidget {
  const WidgetExtensionDemoPage({super.key});

  @override
  State<WidgetExtensionDemoPage> createState() =>
      _WidgetExtensionDemoPageState();
}

class _WidgetExtensionDemoPageState extends State<WidgetExtensionDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Widget Extension',
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
          Text(
            'Declarative UI Modifiers',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: context.uiTheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ).paddingBottom(AppSpacing.md),
          Text(
            'Bandingkan kode yang bersarang (nested) dengan penulisan berantai (chained). Ini membuat UI jauh lebih bersih.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: context.uiTheme.hintColor),
          ).paddingBottom(AppSpacing.xl),

          // 1. Padding & Background
          _buildSubtitle('1. .paddingAll() & .backgroundColor()'),
          Text(
                'Hello Flutter!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
              .center()
              .paddingAll(20)
              .backgroundColor(context.uiTheme.primary)
              .clipRRect(radius: 12)
              .paddingBottom(AppSpacing.xl),

          // 2. Visibility
          _buildSubtitle('2. .visible()'),
          Row(
            children: [
              Container(color: Colors.red, width: 50, height: 50),
              Container(
                color: Colors.green,
                width: 50,
                height: 50,
              ).visible(false), // Tersembunyi!
              Container(color: Colors.blue, width: 50, height: 50),
            ],
          ).paddingBottom(AppSpacing.xl),

          // 3. Size & Shape
          _buildSubtitle('3. .sized() & .clipOval()'),
          Container(color: Colors.purple)
              .sized(width: 80, height: 80)
              .clipOval()
              .center()
              .paddingBottom(AppSpacing.xl),

          // 4. Gestures (InkWell Ripple)
          _buildSubtitle('4. .onInkTap()'),
          Text(
                'Klik Saya!',
                style: TextStyle(color: context.uiTheme.primary, fontSize: 16),
              )
              .paddingAll(16)
              .backgroundColor(context.uiTheme.primary.withValues(alpha: 0.1))
              .clipRRect(radius: 8)
              .onInkTap(() {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Widget di-tap!')));
              }, borderRadius: 8)
              .center(),
        ],
      ),
    );
  }

  Widget _buildSubtitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    ).paddingBottom(AppSpacing.sm);
  }
}

// Tambahan custom padding spesifik untuk demo agar lebih rapi.
extension SpecificPaddingDemoExtension on Widget {
  Widget paddingBottom(double bottom) => Padding(
    padding: EdgeInsets.only(bottom: bottom),
    child: this,
  );
}
