import 'package:example/widget_extension_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class GlassyExtensionDemoPage extends StatefulWidget {
  const GlassyExtensionDemoPage({super.key});

  @override
  State<GlassyExtensionDemoPage> createState() =>
      _GlassyExtensionDemoPageState();
}

class _GlassyExtensionDemoPageState extends State<GlassyExtensionDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Glassy Extension',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: context.uiTheme.onPrimary),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
      ),
      body: Stack(
        children: [
          // Background statis dibungkus RepaintBoundary agar tidak ikut di-render ulang
          // saat ListView di-scroll, yang sering menyebabkan flicker.
          RepaintBoundary(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepOrangeAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.lightBlueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Konten Glassy
          ListView(
            padding: EdgeInsets.all(AppSpacing.xl),
            children: [
              _buildGlassyCard(
                '1. Smooth (Halus & Elegan)',
                'Cocok untuk overlay UI tipis.',
                AppGlassyVariant.smooth,
              ),
              _buildGlassyCard(
                '2. Frosted (Kaca Es)',
                'Blur standar yang kuat (Default).',
                AppGlassyVariant.frosted,
              ),
              _buildGlassyCard(
                '3. Dew (Efek Embun)',
                'Lebih jernih namun tetap blur dengan hint kebiruan.',
                AppGlassyVariant.dew,
              ),
              _buildGlassyCard(
                '4. Heavy (Tebal & Kasar)',
                'Sangat buram dan menutupi latar belakang.',
                AppGlassyVariant.heavy,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlassyCard(String title, String desc, AppGlassyVariant variant) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
            ),
          ).paddingBottom(AppSpacing.sm),
          Container(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ).glassy(variant: variant),
        ],
      ),
    );
  }
}
