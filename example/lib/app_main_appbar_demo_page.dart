import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

enum _DemoMode { search, tabFilter }

class AppMainAppbarDemoPage extends StatefulWidget {
  const AppMainAppbarDemoPage({super.key});

  @override
  State<AppMainAppbarDemoPage> createState() => _AppMainAppbarDemoPageState();
}

class _AppMainAppbarDemoPageState extends State<AppMainAppbarDemoPage> {
  _DemoMode _demoMode = _DemoMode.search;
  String _searchQuery = '';
  String _selectedPeriod = 'daily';

  final List<String> _components = [
    'Typography',
    'Animations',
    'Date Extension',
    'Number Extension',
    'Currency Extension',
    'String Extension',
    'Widget Extension',
    'Glassy Extension',
    'Currency Formatter',
    'Generic Formatters',
    'App Button',
    'App Dialog',
    'App Bottom Navigation',
    'App Segmented Switch',
    'App Switch Button',
    'App Date Picker',
    'App Year Picker',
    'App Time Picker',
    'App Month Picker',
    'App Dropdown & Selection',
    'App Text & Password Field',
    'App OTP Form',
    'App Image Upload',
    'App File Upload',
    'App Snackbar',
    'App Dashboard Appbar',
    'App Main Appbar',
  ];

  void _toggleDemoMode() {
    setState(() {
      _demoMode = _demoMode == _DemoMode.search
          ? _DemoMode.tabFilter
          : _DemoMode.search;
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.uiTheme.background,
      body: CustomScrollView(
        slivers: [
          if (_demoMode == _DemoMode.search)
            AppMainAppbar(
              title: 'Komponen UI',
              titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
              appBarHeight: 76,
              titleBottomPadding: 6,
              searchHint: 'Cari komponen...',
              onBack: () => Navigator.pop(context),
              onSearch: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              onReset: () {
                setState(() {
                  _searchQuery = '';
                });
                AppSnackbar.info(context, title: 'Pencarian di-reset');
              },
              actions: [
                IconButton(
                  icon: HeroIcon(
                    HeroIcons.adjustmentsHorizontal,
                    color: context.uiTheme.onPrimary,
                  ),
                  tooltip: 'Switch ke Tab Filter demo',
                  onPressed: _toggleDemoMode,
                ),
                IconButton(
                  icon: HeroIcon(
                    HeroIcons.funnel,
                    color: context.uiTheme.onPrimary,
                  ),
                  onPressed: () {
                    AppSnackbar.success(context, title: 'Menu filter ditekan');
                  },
                ),
                IconButton(
                  icon: HeroIcon(
                    HeroIcons.ellipsisVertical,
                    color: context.uiTheme.onPrimary,
                  ),
                  onPressed: () {},
                ),
              ],
            )
          else
            AppMainAppbar(
              title: 'Laporan',
              titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
              tabFilterHeight: 48,
              titleBottomPadding: 6,
              onBack: () => Navigator.pop(context),
              tabFilter: AppSegmentedSwitch<String>(
                options: {
                  'daily': 'Harian',
                  'weekly': 'Mingguan',
                  'monthly': 'Bulanan',
                },
                selectedValue: _selectedPeriod,
                onChanged: (val) {
                  setState(() => _selectedPeriod = val);
                },
                height: 32,
                textSize: size(12),
                padding: EdgeInsets.all(size(2)),
              ),
              actions: [
                IconButton(
                  icon: HeroIcon(
                    HeroIcons.adjustmentsHorizontal,
                    color: context.uiTheme.onPrimary,
                  ),
                  tooltip: 'Switch ke Search demo',
                  onPressed: _toggleDemoMode,
                ),
              ],
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (_demoMode == _DemoMode.tabFilter && index == 0) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(size(16), size(16), size(16), size(8)),
                  child: Text(
                    'Periode aktif: $_selectedPeriod',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: context.uiTheme.primary,
                    ),
                  ),
                );
              }

              final itemIndex =
                  _demoMode == _DemoMode.tabFilter ? index - 1 : index;
              if (itemIndex < 0) return const SizedBox.shrink();

              final itemName = _components[itemIndex];
              if (_demoMode == _DemoMode.search &&
                  _searchQuery.isNotEmpty &&
                  !itemName.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  )) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size(16),
                  vertical: size(8),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size(16)),
                  height: size(60),
                  decoration: BoxDecoration(
                    color: context.uiTheme.surface,
                    borderRadius: BorderRadius.circular(size(12)),
                    border: Border.all(color: context.uiTheme.borderColor),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      HeroIcon(
                        HeroIcons.cube,
                        color: context.uiTheme.primary,
                        size: size(20),
                      ),
                      SizedBox(width: size(12)),
                      Expanded(
                        child: Text(
                          itemName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: context.uiTheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: _components.length + (_demoMode == _DemoMode.tabFilter ? 1 : 0)),
          ),
        ],
      ),
    );
  }
}
