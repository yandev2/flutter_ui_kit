import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../ui_component_flutter.dart';

class AppMainAppbar extends StatefulWidget {
  final String title;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onReset;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Widget? tabFilter;
  final double? borderRadius;
  final String? searchHint;
  final Color? backgroundColor;

  /// Gaya teks judul. Untuk warna kustom, set [TextStyle.color] di sini.
  final TextStyle? titleStyle;

  /// Tinggi area appbar (collapsed/search). Nilai desain, diskalakan via `sizeHeight()`.
  final double? appBarHeight;

  /// Tinggi area tab filter (nilai desain, diskalakan via `sizeHeight()`.
  /// Hanya dipakai jika [tabFilter] disediakan. Default `70`.
  final double? tabFilterHeight;

  /// Padding bawah pada area title. Nilai desain, diskalakan via `sizeHeight()`.
  final double? titleBottomPadding;

  /// Jika true, appbar penuh (title + search/tab) fixed saat scroll.
  /// Jika false, title + ikon collapse; yang menempel hanya area search/tab.
  final bool pinned;

  /// App bar muncul kembali saat scroll ke atas. Default `false`.
  final bool floating;

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
    this.titleStyle,
    this.appBarHeight,
    this.tabFilterHeight,
    this.titleBottomPadding,
    this.pinned = true,
    this.floating = false,
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
    final topPadding = MediaQuery.paddingOf(context).top;

    return SliverPersistentHeader(
      pinned: true,
      floating: widget.floating,
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
        titleStyle: widget.titleStyle,
        appBarHeight: widget.appBarHeight,
        tabFilterHeight: widget.tabFilterHeight,
        titleBottomPadding: widget.titleBottomPadding,
        pinned: widget.pinned,
      ),
    );
  }
}

class _AppbarDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final ValueChanged<String>? onSearch;
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
  final TextStyle? titleStyle;
  final double? appBarHeight;
  final double? tabFilterHeight;
  final double? titleBottomPadding;
  final bool pinned;

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
    this.titleStyle,
    this.appBarHeight,
    this.tabFilterHeight,
    this.titleBottomPadding,
    required this.pinned,
  });

  double get _titleHeight => sizeHeight(45);
  double get _searchHeight => sizeHeight(appBarHeight ?? 70);
  double get _tabFilterHeight =>
      sizeHeight(tabFilterHeight ?? appBarHeight ?? 70);
  double get _bottomAreaHeight =>
      tabFilter != null ? _tabFilterHeight : _searchHeight;

  bool get _hasTitleRow => onSearch != null || tabFilter != null;

  double get _bottomOnlyExtent => _bottomAreaHeight + topPadding;

  double get _fullExtent {
    if (!_hasTitleRow) return _bottomOnlyExtent;
    return _titleHeight + _bottomAreaHeight + topPadding;
  }

  TextStyle _resolvedTitleStyle(ThemeData theme, UIComponentTheme uiTheme) {
    final defaults = theme.textTheme.titleMedium?.copyWith(
      color: uiTheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    if (titleStyle == null) {
      return defaults ?? const TextStyle();
    }

    return (defaults ?? const TextStyle()).merge(titleStyle).copyWith(
      color: titleStyle?.color ?? uiTheme.onPrimary,
    );
  }

  double get _resolvedTitleBottomPadding =>
      titleBottomPadding != null ? sizeHeight(titleBottomPadding!) : 0;

  @override
  double get maxExtent => _fullExtent;

  @override
  double get minExtent {
    if (pinned || !_hasTitleRow) return _fullExtent;
    return _bottomOnlyExtent;
  }

  @override
  bool shouldRebuild(covariant _AppbarDelegate oldDelegate) {
    return title != oldDelegate.title ||
        hasSearchText != oldDelegate.hasSearchText ||
        tabFilter != oldDelegate.tabFilter ||
        actions != oldDelegate.actions ||
        topPadding != oldDelegate.topPadding ||
        backgroundColor != oldDelegate.backgroundColor ||
        titleStyle != oldDelegate.titleStyle ||
        appBarHeight != oldDelegate.appBarHeight ||
        tabFilterHeight != oldDelegate.tabFilterHeight ||
        titleBottomPadding != oldDelegate.titleBottomPadding ||
        pinned != oldDelegate.pinned;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;

    final collapseRange = (maxExtent - minExtent).clamp(0.0, _titleHeight);
    final collapseProgress = collapseRange == 0
        ? 0.0
        : (shrinkOffset / collapseRange).clamp(0.0, 1.0);

    final titleOpacity = pinned ? 1.0 : 1.0 - collapseProgress;
    final titleTop = pinned
        ? topPadding
        : topPadding - (shrinkOffset * 0.5).clamp(0.0, topPadding);

    final hasSearchOrTab = onSearch != null || tabFilter != null;
    final searchBottomAreaHeight = hasSearchOrTab
        ? _bottomAreaHeight
        : sizeHeight(20);

    return Container(
      color: backgroundColor ?? uiTheme.primary,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          if (_hasTitleRow && titleOpacity > 0)
            Positioned(
              top: titleTop,
              left: 0,
              right: 0,
              height: _titleHeight,
              child: Padding(
                padding: EdgeInsets.only(bottom: _resolvedTitleBottomPadding),
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
                          style: _resolvedTitleStyle(theme, uiTheme),
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
            ),

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
              height: _tabFilterHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: uiTheme.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(borderRadius),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size(16),
                  vertical: sizeHeight(8),
                ),
                alignment: Alignment.center,
                child: tabFilter!,
              ),
            ),
        ],
      ),
    );
  }
}
