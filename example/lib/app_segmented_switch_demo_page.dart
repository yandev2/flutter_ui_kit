import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:ui_component_flutter/theme/app_scale.dart' as scale;

class AppSegmentedSwitchDemoPage extends StatefulWidget {
  const AppSegmentedSwitchDemoPage({super.key});

  @override
  State<AppSegmentedSwitchDemoPage> createState() =>
      _AppSegmentedSwitchDemoPageState();
}

class _AppSegmentedSwitchDemoPageState
    extends State<AppSegmentedSwitchDemoPage> {
  // Demo 1: T = String
  String _selectedString = 'Option 1';

  // Demo 2: T = bool
  bool _selectedBool = true;

  // Demo 3: T = int
  int _selectedInt = 1;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppSegmentedSwitch Demo',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: context.uiTheme.onPrimary),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(scale.size(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // DEMO 1: String type
            // ==========================================
            Text(
              '1. String Values (Default Styling)',
              style: TextStyle(
                fontSize: scale.size(16),
                fontWeight: FontWeight.bold,
                color: context.uiTheme.onSurface,
              ),
            ),
            SizedBox(height: scale.sizeHeight(16)),
            AppSegmentedSwitch<String>(
              options: {
                'Option 1': 'Daily',
                'Option 2': 'Weekly',
                'Option 3': 'Monthly',
              },
              icons: {
                'Option 1': HeroIcons.calendar,
                'Option 2': HeroIcons.calendarDays,
                'Option 3': HeroIcons.calendarDateRange,
              },
              selectedValue: _selectedString,
              isLoading: _isLoading,
              onChanged: (val) {
                setState(() => _selectedString = val);
              },
            ),
            SizedBox(height: scale.sizeHeight(16)),
            Text(
              'Selected Value: $_selectedString',
              style: TextStyle(color: context.uiTheme.primary),
            ),
            SizedBox(height: scale.sizeHeight(32)),

            // ==========================================
            // DEMO 2: Boolean type
            // ==========================================
            Text(
              '2. Boolean Values (Custom Styling)',
              style: TextStyle(
                fontSize: scale.size(16),
                fontWeight: FontWeight.bold,
                color: context.uiTheme.onSurface,
              ),
            ),
            SizedBox(height: scale.sizeHeight(16)),
            AppSegmentedSwitch<bool>(
              options: {true: 'Yes, I agree', false: 'No, thanks'},
              selectedValue: _selectedBool,
              onChanged: (val) {
                setState(() => _selectedBool = val);
              },
              activeColor: context.uiTheme.success,
              inactiveColor: context.uiTheme.disabledColor,
              backgroundColor: context.uiTheme.surface,
              borderRadius: BorderRadius.circular(scale.size(8)),
              isLoading: _isLoading,
            ),
            SizedBox(height: scale.sizeHeight(16)),
            Text(
              'Selected Value: $_selectedBool',
              style: TextStyle(color: context.uiTheme.success),
            ),
            SizedBox(height: scale.sizeHeight(32)),

            // ==========================================
            // DEMO 3: Integer type
            // ==========================================
            Text(
              '3. Integer Values (Custom Size & Padding)',
              style: TextStyle(
                fontSize: scale.size(16),
                fontWeight: FontWeight.bold,
                color: context.uiTheme.onSurface,
              ),
            ),
            SizedBox(height: scale.sizeHeight(16)),
            AppSegmentedSwitch<int>(
              options: {1: 'One', 2: 'Two', 3: 'Three', 4: 'Four'},
              selectedValue: _selectedInt,
              onChanged: (val) {
                setState(() => _selectedInt = val);
              },
              activeColor: context.uiTheme.error,
              borderRadius: BorderRadius.circular(scale.size(24)),
              textSize: scale.size(12),
              padding: EdgeInsets.all(scale.size(6)),
              isLoading: _isLoading,
            ),
            SizedBox(height: scale.sizeHeight(16)),
            Text(
              'Selected Value: $_selectedInt',
              style: TextStyle(color: context.uiTheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
