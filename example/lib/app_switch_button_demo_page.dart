import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppSwitchButtonDemoPage extends StatefulWidget {
  const AppSwitchButtonDemoPage({super.key});

  @override
  State<AppSwitchButtonDemoPage> createState() =>
      _AppSwitchButtonDemoPageState();
}

class _AppSwitchButtonDemoPageState extends State<AppSwitchButtonDemoPage> {
  bool _switch1 = false;
  bool _switch2 = true;
  bool _switch3 = false;
  bool _switch4 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppSwitchButton Demo',
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
          _buildSectionTitle('1. Basic Switch'),
          AppSwitchButton(
            value: _switch1,
            onChanged: (val) => setState(() => _switch1 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('2. With Title & Description'),
          AppSwitchButton(
            value: _switch2,
            title: 'Enable Notifications',
            description:
                'Receive daily updates and alerts directly to your device.',
            onChanged: (val) => setState(() => _switch2 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('3. Control Position (Start)'),
          AppSwitchButton(
            value: _switch3,
            title: 'Dark Mode',
            controlPosition: AppSwitchControlPosition.start,
            onChanged: (val) => setState(() => _switch3 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('4. Custom Colors & Leading Icon'),
          AppSwitchButton(
            value: _switch4,
            title: 'Bluetooth',
            description: 'Allow app to connect to nearby devices.',
            activeColor: context.uiTheme.success,
            leading: Icon(
              Icons.bluetooth,
              color: _switch4
                  ? context.uiTheme.success
                  : context.uiTheme.disabledColor,
            ),
            onChanged: (val) => setState(() => _switch4 = val),
          ).paddingOnly(bottom: AppSpacing.xl),

          _buildSectionTitle('5. Disabled State with Error'),
          const AppSwitchButton(
            value: false,
            title: 'Location Services',
            description: 'GPS is currently disabled.',
            enabled: false,
            errorText: 'Please turn on GPS in settings.',
            onChanged: null,
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
