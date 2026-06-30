import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';
import 'package:ui_component_flutter/theme/app_scale.dart' as scale;

class AppBottomNavigationDemoPage extends StatefulWidget {
  const AppBottomNavigationDemoPage({super.key});

  @override
  State<AppBottomNavigationDemoPage> createState() =>
      _AppBottomNavigationDemoPageState();
}

class _AppBottomNavigationDemoPageState
    extends State<AppBottomNavigationDemoPage> {
  int _currentIndex = 0;
  AppBottomNavigationVariant _selectedVariant =
      AppBottomNavigationVariant.indicator;

  final List<AppBottomNavItem> _navItems = [
    AppBottomNavItem(label: 'Home', icon: HeroIcons.home),
    AppBottomNavItem(label: 'Explore', icon: HeroIcons.magnifyingGlass),
    AppBottomNavItem(label: 'Saved', icon: HeroIcons.bookmark),
    AppBottomNavItem(label: 'Profile', icon: HeroIcons.user),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppBottomNavigation Demo',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: context.uiTheme.onPrimary),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tampilan Halaman: ${_navItems[_currentIndex].label}',
              style: TextStyle(
                fontSize: scale.size(18),
                fontWeight: FontWeight.bold,
                color: context.uiTheme.onSurface,
              ),
            ),
            SizedBox(height: scale.sizeHeight(32)),
            Text(
              'Pilih Varian Navigasi:',
              style: TextStyle(
                fontSize: scale.size(14),
                color: context.uiTheme.disabledColor,
              ),
            ),
            SizedBox(height: scale.sizeHeight(16)),
            Wrap(
              spacing: scale.size(8),
              runSpacing: scale.sizeHeight(8),
              alignment: WrapAlignment.center,
              children: AppBottomNavigationVariant.values.map((v) {
                final isSelected = _selectedVariant == v;
                return ChoiceChip(
                  label: Text(v.name.toUpperCase()),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedVariant = v);
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navItems,
        variant: _selectedVariant,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey.shade400,
        backgroundColor: context.uiTheme.cardColor,
        iconSize: scale.size(24),
      ),
    );
  }
}
