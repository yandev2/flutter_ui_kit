import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppDashboardAppbarDemoPage extends StatefulWidget {
  const AppDashboardAppbarDemoPage({super.key});

  @override
  State<AppDashboardAppbarDemoPage> createState() =>
      _AppDashboardAppbarDemoPageState();
}

class _AppDashboardAppbarDemoPageState extends State<AppDashboardAppbarDemoPage> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    // Karena komponen berupa SliverAppBar, kita harus meletakkannya di dalam CustomScrollView
    return Scaffold(
      backgroundColor: context.uiTheme.background,
      body: CustomScrollView(
        slivers: [
          AppDashboardAppbar(
            title: 'Halo, Ryan!',
            subtitle: 'Selamat datang kembali di Dashboard',
            isDarkMode: _isDark,
            onThemeToggle: () {
              setState(() {
                _isDark = !_isDark;
              });
              AppSnackbar.info(
                context,
                title: 'Tema Diubah',
                subtitle: 'Tema berganti ke ${_isDark ? 'Gelap' : 'Terang'}',
              );
            },
            trailingWidget: HeroIcon(
              HeroIcons.bell,
              color: context.uiTheme.primary,
              size: size(24),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size(16),
                    vertical: size(8),
                  ),
                  child: Container(
                    height: size(100),
                    decoration: BoxDecoration(
                      color: context.uiTheme.surface,
                      borderRadius: BorderRadius.circular(size(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: size(10),
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Konten $index',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: context.uiTheme.onSurface,
                          ),
                    ),
                  ),
                );
              },
              childCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}
