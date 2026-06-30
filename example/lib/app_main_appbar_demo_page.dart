import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppMainAppbarDemoPage extends StatefulWidget {
  const AppMainAppbarDemoPage({super.key});

  @override
  State<AppMainAppbarDemoPage> createState() => _AppMainAppbarDemoPageState();
}

class _AppMainAppbarDemoPageState extends State<AppMainAppbarDemoPage> {
  String _searchQuery = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.uiTheme.background,
      body: CustomScrollView(
        slivers: [
          AppMainAppbar(
            title: 'Komponen UI',
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final itemName = _components[index];
              // Simulasi filter pencarian
              if (_searchQuery.isNotEmpty &&
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
            }, childCount: _components.length),
          ),
        ],
      ),
    );
  }
}
