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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.uiTheme.background,
      appBar: AppBar(
        title: Text(
          'App Dashboard Appbar',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: size(20),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle Skeleton',
            icon: Icon(
              _isLoading ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          AppDashboardAppbar(
            title: 'Halo, Ryan!',
            subtitle: 'Selamat datang kembali di Dashboard',
            avatarSize: 56,
            titleSize: 18,
            subtitleSize: 13,
            isLoading: _isLoading,
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
