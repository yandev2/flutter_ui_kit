import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../ui_component_flutter.dart';

enum TimelineStatus { completed, active, inactive, disabled }

class AppTimelineNode {
  final String title;
  final String? subtitle;
  final TimelineStatus status;
  final bool isHighlighted;
  final Widget? content;

  final double? titleSize;
  final double? subtitleSize;
  final double? indicatorSize;

  const AppTimelineNode({
    required this.title,
    this.subtitle,
    this.status = TimelineStatus.inactive,
    this.isHighlighted = false,
    this.content,
    this.titleSize,
    this.subtitleSize,
    this.indicatorSize,
  });
}

class AppTimeline extends StatelessWidget {
  final List<AppTimelineNode> nodes;
  final Axis direction;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? highlightGlowColor;
  final double? indicatorSize;
  final double? itemWidth;
  final bool isLoading;

  const AppTimeline({
    super.key,
    required this.nodes,
    this.direction = Axis.vertical,
    this.activeColor,
    this.inactiveColor,
    this.highlightGlowColor,
    this.indicatorSize,
    this.itemWidth,
    this.isLoading = false,
  });

  double _resolveIndicatorSize(AppTimelineNode node) {
    return node.indicatorSize ?? indicatorSize ?? size(24);
  }

  Color _resolveInactiveColor(BuildContext context) {
    return inactiveColor ?? context.uiTheme.hintColor.withValues(alpha: 0.5);
  }

  Color _resolveGlowColor(Color active) {
    return highlightGlowColor ?? active;
  }

  double _indicatorTopPadding() {
    return size(12);
  }

  double _columnWidth(double indicatorSize, {required bool isHighlighted}) {
    final baseWidth = indicatorSize + size(16);
    return isHighlighted ? baseWidth + size(16) : baseWidth;
  }

  Color _lineColorForNode(
    AppTimelineNode node,
    Color active,
    Color inactive,
  ) {
    return node.status == TimelineStatus.completed ||
            node.status == TimelineStatus.active
        ? active
        : inactive.withValues(alpha: 0.3);
  }

  double _resolveTrackHeight() {
    final maxIndicator = nodes
        .map(_resolveIndicatorSize)
        .fold(0.0, (a, b) => a > b ? a : b);
    final anyHighlighted = nodes.any((node) => node.isHighlighted);
    return _columnWidth(maxIndicator, isHighlighted: anyHighlighted);
  }

  double _resolveLineColumnWidth() => _resolveTrackHeight();

  double _indicatorCenterY(double nodeIndicatorSize) {
    return _indicatorTopPadding() + (nodeIndicatorSize / 2);
  }

  Widget _buildLineBar(Color lineColor, bool isLoading) {
    return Skeleton.replace(
      replace: isLoading,
      replacement: const Bone(),
      child: ColoredBox(color: lineColor),
    );
  }

  double _lineLeft(double columnWidth) => (columnWidth - size(2)) / 2;

  @override
  Widget build(BuildContext context) {
    final color = activeColor ?? context.uiTheme.primary;

    if (direction == Axis.vertical) {
      final inactive = _resolveInactiveColor(context);
      final lineColumnWidth = _resolveLineColumnWidth();

      return Skeletonizer(
        enabled: isLoading,
        child: _VerticalTimelineLayout(
          nodes: nodes,
          lineColumnWidth: lineColumnWidth,
          rowSpacing: size(24),
          lineLeft: _lineLeft(lineColumnWidth),
          indicatorTop: _indicatorTopPadding(),
          isLoading: isLoading,
          resolveIndicatorSize: _resolveIndicatorSize,
          indicatorCenterY: _indicatorCenterY,
          segmentColor: (index) =>
              _lineColorForNode(nodes[index], color, inactive),
          buildIndicator: (context, index, node, nodeSize) =>
              _buildIndicator(context, node, color, inactive, nodeSize),
          buildContent: (context, index, node) =>
              _buildNodeContent(context, node, color, isLoading),
        ),
      );
    } else {
      return Skeletonizer(
        enabled: isLoading,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(nodes.length, (index) {
              return _buildHorizontalNode(
                context,
                index,
                nodes[index],
                color,
                isLoading,
              );
            }),
          ),
        ),
      );
    }
  }

  Widget _buildHorizontalNode(
    BuildContext context,
    int index,
    AppTimelineNode node,
    Color color,
    bool isLoading,
  ) {
    final isFirst = index == 0;
    final isLast = index == nodes.length - 1;
    final nodeIndicatorSize = _resolveIndicatorSize(node);
    final indicatorLeft = _indicatorTopPadding();
    final inactive = _resolveInactiveColor(context);
    final lineColorBelow = _lineColorForNode(node, color, inactive);
    final lineColorAbove = isFirst
        ? null
        : _lineColorForNode(nodes[index - 1], color, inactive);

    final width = itemWidth ?? size(140);
    final trackHeight = _resolveTrackHeight();
    final lineTop = (trackHeight - size(2)) / 2;
    final indicatorCenterX = indicatorLeft + (nodeIndicatorSize / 2);
    final indicatorTop = (trackHeight - nodeIndicatorSize) / 2;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: trackHeight,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (!isFirst)
                  Positioned(
                    left: 0,
                    top: lineTop,
                    width: indicatorCenterX,
                    height: size(2),
                    child: _buildLineBar(lineColorAbove!, isLoading),
                  ),
                if (!isLast)
                  Positioned(
                    left: indicatorCenterX,
                    top: lineTop,
                    right: 0,
                    height: size(2),
                    child: _buildLineBar(lineColorBelow, isLoading),
                  ),
                Positioned(
                  left: indicatorLeft,
                  top: indicatorTop,
                  child: Skeleton.replace(
                    replace: isLoading,
                    replacement: Bone.circle(size: nodeIndicatorSize),
                    child: _buildIndicator(
                      context,
                      node,
                      color,
                      inactive,
                      nodeIndicatorSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: size(16)),
            child: _buildNodeContent(context, node, color, isLoading),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(
    BuildContext context,
    AppTimelineNode node,
    Color active,
    Color inactive,
    double indicatorSize,
  ) {
    final uiTheme = context.uiTheme;
    final innerSmall = indicatorSize / 3;
    final innerActive = indicatorSize * (10 / 24);
    final borderWidth = (indicatorSize * (2 / 24)).clamp(1.0, 4.0);

    Widget indicator;
    switch (node.status) {
      case TimelineStatus.completed:
        indicator = Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(color: active, shape: BoxShape.circle),
          child: Center(
            child: Container(
              width: innerSmall,
              height: innerSmall,
              decoration: BoxDecoration(
                color: uiTheme.surface,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case TimelineStatus.active:
        indicator = Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: active.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: active.withValues(alpha: 0.5), width: 1),
          ),
          child: Center(
            child: Container(
              width: innerActive,
              height: innerActive,
              decoration: BoxDecoration(
                color: active,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case TimelineStatus.inactive:
        indicator = Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: inactive, width: borderWidth),
          ),
          child: Center(
            child: Container(
              width: innerSmall,
              height: innerSmall,
              decoration: BoxDecoration(
                color: inactive,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case TimelineStatus.disabled:
        final disabledColor = uiTheme.disabledColor;
        indicator = Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: disabledColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: innerSmall,
              height: innerSmall,
              decoration: BoxDecoration(
                color: disabledColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
    }

    if (node.isHighlighted) {
      return _TimelineGlowIndicator(
        indicatorSize: indicatorSize,
        glowColor: _resolveGlowColor(active),
        child: indicator,
      );
    }

    return indicator;
  }

  Widget _buildNodeContent(
    BuildContext context,
    AppTimelineNode node,
    Color color,
    bool isLoading,
  ) {
    final uiTheme = context.uiTheme;
    final theme = Theme.of(context);

    final titleColor = node.status == TimelineStatus.disabled
        ? uiTheme.disabledColor
        : node.isHighlighted
        ? color
        : theme.textTheme.bodyLarge?.color;

    final subtitleColor = node.status == TimelineStatus.disabled
        ? uiTheme.disabledColor
        : uiTheme.hintColor;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          node.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: node.titleSize,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        if (node.subtitle != null) ...[
          SizedBox(height: size(4)),
          Text(
            node.subtitle!,
            style: theme.textTheme.labelMedium?.copyWith(
              fontSize: node.subtitleSize,
              color: subtitleColor,
            ),
          ),
        ],
        if (node.content != null) ...[
          SizedBox(height: size(8)),
          Skeleton.replace(
            replace: isLoading,
            replacement: Bone(
              width: size(120),
              height: size(36),
              borderRadius: BorderRadius.circular(size(8)),
            ),
            child: node.content!,
          ),
        ],
      ],
    );

    if (node.isHighlighted) {
      content = Skeleton.leaf(
        enabled: isLoading,
        child: Container(
          padding: EdgeInsets.all(size(12)),
          decoration: BoxDecoration(
            color: uiTheme.cardColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(size(12)),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: content,
        ),
      );
    } else {
      content = Padding(
        padding: EdgeInsets.symmetric(vertical: size(8), horizontal: size(4)),
        child: content,
      );
    }

    return content;
  }
}

class _VerticalTimelineLayout extends StatefulWidget {
  final List<AppTimelineNode> nodes;
  final double lineColumnWidth;
  final double rowSpacing;
  final double lineLeft;
  final double indicatorTop;
  final bool isLoading;
  final double Function(AppTimelineNode node) resolveIndicatorSize;
  final double Function(double nodeIndicatorSize) indicatorCenterY;
  final Color Function(int segmentIndex) segmentColor;
  final Widget Function(
    BuildContext context,
    int index,
    AppTimelineNode node,
    double nodeSize,
  ) buildIndicator;
  final Widget Function(
    BuildContext context,
    int index,
    AppTimelineNode node,
  ) buildContent;

  const _VerticalTimelineLayout({
    required this.nodes,
    required this.lineColumnWidth,
    required this.rowSpacing,
    required this.lineLeft,
    required this.indicatorTop,
    required this.isLoading,
    required this.resolveIndicatorSize,
    required this.indicatorCenterY,
    required this.segmentColor,
    required this.buildIndicator,
    required this.buildContent,
  });

  @override
  State<_VerticalTimelineLayout> createState() =>
      _VerticalTimelineLayoutState();
}

class _VerticalTimelineLayoutState extends State<_VerticalTimelineLayout> {
  final List<GlobalKey> _rowKeys = [];
  List<double> _rowHeights = [];

  @override
  void initState() {
    super.initState();
    _syncRowKeys();
  }

  @override
  void didUpdateWidget(covariant _VerticalTimelineLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.nodes.length != widget.nodes.length) {
      _syncRowKeys();
      _rowHeights = [];
    }
  }

  void _syncRowKeys() {
    _rowKeys
      ..clear()
      ..addAll(List.generate(widget.nodes.length, (_) => GlobalKey()));
  }

  void _measureRows() {
    if (!mounted) return;

    final heights = <double>[];
    for (final key in _rowKeys) {
      final box = key.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) return;
      heights.add(box.size.height);
    }

    if (heights.length != widget.nodes.length) return;

    final changed = _rowHeights.length != heights.length ||
        !_heightsEqual(_rowHeights, heights);
    if (changed) {
      setState(() => _rowHeights = heights);
    }
  }

  bool _heightsEqual(List<double> a, List<double> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if ((a[i] - b[i]).abs() > 0.5) return false;
    }
    return true;
  }

  List<double> _indicatorCenters() {
    if (_rowHeights.length != widget.nodes.length) return [];

    var offset = 0.0;
    final centers = <double>[];
    for (var i = 0; i < widget.nodes.length; i++) {
      final nodeSize = widget.resolveIndicatorSize(widget.nodes[i]);
      centers.add(offset + widget.indicatorCenterY(nodeSize));
      offset += _rowHeights[i];
    }
    return centers;
  }

  double? get _totalHeight {
    if (_rowHeights.length != widget.nodes.length) return null;
    return _rowHeights.fold<double>(0, (sum, height) => sum + height);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureRows());

    final centers = _indicatorCenters();
    final totalHeight = _totalHeight;
    final lineX = widget.lineLeft + (size(2) / 2);
    final segmentColors = List.generate(
      widget.nodes.length - 1,
      widget.segmentColor,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.lineColumnWidth,
          height: totalHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (centers.length >= 2 && totalHeight != null)
                CustomPaint(
                  size: Size(widget.lineColumnWidth, totalHeight),
                  painter: _VerticalTimelineLinePainter(
                    centers: centers,
                    lineX: lineX,
                    strokeWidth: size(2),
                    segmentColors: segmentColors,
                  ),
                ),
              ...List.generate(widget.nodes.length, (index) {
                if (centers.length != widget.nodes.length) {
                  return const SizedBox.shrink();
                }

                final node = widget.nodes[index];
                final nodeSize = widget.resolveIndicatorSize(node);
                final top = centers[index] - (nodeSize / 2);

                return Positioned(
                  top: top,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Skeleton.replace(
                      replace: widget.isLoading,
                      replacement: Bone.circle(size: nodeSize),
                      child: widget.buildIndicator(
                        context,
                        index,
                        node,
                        nodeSize,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.nodes.length, (index) {
              final isLast = index == widget.nodes.length - 1;
              return KeyedSubtree(
                key: _rowKeys[index],
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : widget.rowSpacing,
                  ),
                  child: widget.buildContent(
                    context,
                    index,
                    widget.nodes[index],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _VerticalTimelineLinePainter extends CustomPainter {
  final List<double> centers;
  final double lineX;
  final double strokeWidth;
  final List<Color> segmentColors;

  const _VerticalTimelineLinePainter({
    required this.centers,
    required this.lineX,
    required this.strokeWidth,
    required this.segmentColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < segmentColors.length; i++) {
      final paint = Paint()
        ..color = segmentColors[i]
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawLine(
        Offset(lineX, centers[i]),
        Offset(lineX, centers[i + 1]),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _VerticalTimelineLinePainter oldDelegate) {
    return oldDelegate.centers != centers ||
        oldDelegate.lineX != lineX ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.segmentColors != segmentColors;
  }
}

class _TimelineGlowIndicator extends StatefulWidget {
  final double indicatorSize;
  final Color glowColor;
  final Widget child;

  const _TimelineGlowIndicator({
    required this.indicatorSize,
    required this.glowColor,
    required this.child,
  });

  @override
  State<_TimelineGlowIndicator> createState() => _TimelineGlowIndicatorState();
}

class _TimelineGlowIndicatorState extends State<_TimelineGlowIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final t = _pulse.value;
        return SizedBox(
          width: widget.indicatorSize,
          height: widget.indicatorSize,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: widget.indicatorSize,
                height: widget.indicatorSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.glowColor.withValues(alpha: 0.15 + (0.35 * t)),
                      blurRadius: size(6) + (size(10) * t),
                      spreadRadius: size(1) + (size(5) * t),
                    ),
                    BoxShadow(
                      color: widget.glowColor.withValues(alpha: 0.08 + (0.2 * t)),
                      blurRadius: size(12) + (size(16) * t),
                      spreadRadius: size(2) + (size(8) * t),
                    ),
                  ],
                ),
              ),
              child!,
            ],
          ),
        );
      },
      child: widget.child,
    );
  }
}
