import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppDetailAppbarDemoPage extends StatelessWidget {
  const AppDetailAppbarDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.uiTheme.background,
      body: CustomScrollView(
        slivers: [
          const AppDetailAppbar(title: 'Detail Pembayaran', isBack: true),
          SliverPadding(
            padding: EdgeInsets.all(AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.md),
                  child: Container(
                    height: size(100),
                    decoration: BoxDecoration(
                      color: context.uiTheme.surface,
                      borderRadius: BorderRadius.circular(AppRadius.md),
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
                      'Konten Detail ${index + 1}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: context.uiTheme.onSurface,
                      ),
                    ),
                  ),
                );
              }, childCount: 10),
            ),
          ),
        ],
      ),
    );
  }
}
