import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../ui_component_flutter.dart';

class AppDetailAppbar extends StatelessWidget {
  final String title;
  final bool isBack;
  final VoidCallback? onBack;
  final Color? backgroundColor;

  const AppDetailAppbar({
    super.key,
    required this.title,
    this.isBack = true,
    this.onBack,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final uiTheme = context.uiTheme;
    final bgColor = backgroundColor ?? uiTheme.primary;

    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      collapsedHeight: 0,
      expandedHeight: size(75),
      backgroundColor: bgColor,
      leading: null,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: size(16)),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: uiTheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (isBack)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: size(14), left: size(16)),
                    child: GestureDetector(
                      onTap: onBack ?? () => Navigator.maybePop(context),
                      behavior: HitTestBehavior.opaque,
                      child: HeroIcon(
                        HeroIcons.arrowLeft,
                        size: size(20),
                        color: uiTheme.onPrimary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(size(30)),
        child: Container(
          height: size(30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: uiTheme.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(size(20))),
          ),
        ),
      ),
    );
  }
}
