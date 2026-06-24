import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/inputs/app_textfield.dart';

class AppMainAppBar extends StatefulWidget {
  final String title;
  final Function(String)? onSearch;
  final VoidCallback? onReset;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Widget? tabFilter;
  final double? borderRadius;
  final String? searchHint;
  final Color? backgroundColor;

  const AppMainAppBar({
    super.key,
    required this.title,
    this.onSearch,
    this.onReset,
    this.onBack,
    this.actions,
    this.tabFilter,
    this.borderRadius,
    this.searchHint,
    this.backgroundColor,
  });

  @override
  State<AppMainAppBar> createState() => _AppMainAppBarState();
}

class _AppMainAppBarState extends State<AppMainAppBar> {
  final TextEditingController _textController = TextEditingController();
  bool _hasSearchText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final hasText = _textController.text.isNotEmpty;
    if (_hasSearchText != hasText) {
      setState(() {
        _hasSearchText = hasText;
      });
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_onSearchChanged);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SliverPersistentHeader(
      pinned: true,
      delegate: _AppbarDelegate(
        title: widget.title,
        onSearch: widget.onSearch,
        onReset: () {
          _textController.clear();
          widget.onReset?.call();
        },
        onBack: widget.onBack,
        actions: widget.actions,
        topPadding: topPadding,
        textController: _textController,
        hasSearchText: _hasSearchText,
        tabFilter: widget.tabFilter,
        borderRadius: widget.borderRadius ?? AppScale.r(20),
        searchHint: widget.searchHint ?? 'Cari ...',
        backgroundColor: widget.backgroundColor ?? AppColors.primary,
      ),
    );
  }
}

class _AppbarDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Function(String)? onSearch;
  final VoidCallback? onReset;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final double topPadding;
  final TextEditingController textController;
  final bool hasSearchText;
  final Widget? tabFilter;
  final double borderRadius;
  final String searchHint;
  final Color backgroundColor;

  _AppbarDelegate({
    required this.title,
    this.onSearch,
    this.onReset,
    this.onBack,
    this.actions,
    required this.topPadding,
    required this.textController,
    required this.hasSearchText,
    this.tabFilter,
    required this.borderRadius,
    required this.searchHint,
    required this.backgroundColor,
  });

  // Base constants
  double get _titleHeight => AppScale.h(45);
  double get _searchHeight => AppScale.h(70);
  double get _collapsedHeight => AppScale.h(70);

  @override
  double get maxExtent {
    if (onSearch == null && tabFilter == null) {
      return _collapsedHeight + topPadding;
    }
    return _titleHeight + _searchHeight + topPadding;
  }

  @override
  double get minExtent => _collapsedHeight + topPadding;

  @override
  bool shouldRebuild(covariant _AppbarDelegate oldDelegate) {
    return title != oldDelegate.title ||
        hasSearchText != oldDelegate.hasSearchText ||
        tabFilter != oldDelegate.tabFilter ||
        actions != oldDelegate.actions ||
        topPadding != oldDelegate.topPadding;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppColors.background : AppColors.white;

    // Fade out opacity for title when scrolled up
    double titleOpacity = 1.0 - (shrinkOffset / _titleHeight);
    if (titleOpacity < 0) titleOpacity = 0.0;
    if (titleOpacity > 1) titleOpacity = 1.0;

    final hasSearchOrTab = onSearch != null || tabFilter != null;
    final searchBottomAreaHeight = hasSearchOrTab ? _searchHeight : AppScale.h(20);

    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned(
            top: topPadding - (shrinkOffset * 0.5), // Light parallax effect
            left: 0,
            right: 0,
            height: _titleHeight,
            child: Opacity(
              opacity: titleOpacity,
              child: Stack(
                children: [
                  if (onBack != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: AppScale.w(20),
                          color: AppColors.white,
                        ),
                        onPressed: onBack,
                      ),
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: AppScale.sp(16),
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Builder(
                      builder: (context) {
                        if (hasSearchText) {
                          return IconButton(
                            icon: HeroIcon(
                              HeroIcons.funnel,
                              color: AppColors.white,
                              style: HeroIconStyle.solid,
                              size: AppScale.w(20),
                            ),
                            tooltip: 'Reset Filter',
                            onPressed: onReset,
                          );
                        }
                        if (actions != null) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: actions!,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Bar or Tab Filter pinned to the bottom
          if (tabFilter == null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: searchBottomAreaHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: scaffoldBg,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(borderRadius),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: AppScale.w(16),
                  vertical: AppScale.h(10),
                ),
                alignment: Alignment.center,
                child: onSearch == null
                    ? const SizedBox.shrink()
                    : AppTextField(
                        controller: textController,
                        hint: searchHint,
                        prefixIcon: Icons.search,
                        keyboardType: TextInputType.text,
                        onChanged: onSearch,
                      ),
              ),
            )
          else
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: _searchHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: scaffoldBg,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(borderRadius),
                  ),
                ),
                child: tabFilter!,
              ),
            ),
        ],
      ),
    );
  }
}
