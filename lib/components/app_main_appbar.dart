import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../ui_component_flutter.dart';

class AppMainAppbar extends StatefulWidget {
  final String title;
  final Function(String)? onSearch;
  final VoidCallback? onReset;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Widget? tabFilter;
  final double? borderRadius;
  final String? searchHint;
  final Color? backgroundColor;

  const AppMainAppbar({
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
  State<AppMainAppbar> createState() => _AppMainAppbarState();
}

class _AppMainAppbarState extends State<AppMainAppbar> {
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
        borderRadius: widget.borderRadius ?? size(20),
        searchHint: widget.searchHint ?? 'Cari ...',
        backgroundColor: widget.backgroundColor,
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
  final Color? backgroundColor;

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
    this.backgroundColor,
  });

  // Base constants
  double get _titleHeight => sizeHeight(45);
  double get _searchHeight => sizeHeight(70);
  double get _collapsedHeight => sizeHeight(70);

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
        topPadding != oldDelegate.topPadding ||
        backgroundColor != oldDelegate.backgroundColor;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;

    // Fade out opacity for title when scrolled up
    double titleOpacity = 1.0 - (shrinkOffset / _titleHeight);
    if (titleOpacity < 0) titleOpacity = 0.0;
    if (titleOpacity > 1) titleOpacity = 1.0;

    final hasSearchOrTab = onSearch != null || tabFilter != null;
    final searchBottomAreaHeight = hasSearchOrTab
        ? _searchHeight
        : sizeHeight(20);

    return Container(
      color: backgroundColor ?? uiTheme.primary,
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
                        icon: HeroIcon(
                          HeroIcons.arrowLeft,
                          size: size(20),
                          color: uiTheme.onPrimary,
                        ),
                        onPressed: onBack,
                      ),
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: uiTheme.onPrimary,
                        fontWeight: FontWeight.bold,
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
                              HeroIcons.xMark,
                              color: uiTheme.onPrimary,
                              style: HeroIconStyle.solid,
                              size: size(24),
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
                  color: uiTheme.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(borderRadius),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size(16),
                  vertical: sizeHeight(10),
                ),
                alignment: Alignment.center,
                child: onSearch == null
                    ? const SizedBox.shrink()
                    : AppTextField(
                        fillColor: uiTheme.surface,

                        controller: textController,
                        hint: searchHint,
                        prefixIcon: HeroIcons.magnifyingGlass,
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
                  color: uiTheme.background,
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
