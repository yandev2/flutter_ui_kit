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

  @override
  Widget build(BuildContext context) {
    final color = activeColor ?? context.uiTheme.primary;

    if (direction == Axis.vertical) {
      return Skeletonizer(
        enabled: isLoading,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(nodes.length, (index) {
            return _buildVerticalNode(
              context,
              index,
              nodes[index],
              color,
              isLoading,
            );
          }),
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

  Widget _buildVerticalNode(
    BuildContext context,
    int index,
    AppTimelineNode node,
    Color color,
    bool isLoading,
  ) {
    final isFirst = index == 0;
    final isLast = index == nodes.length - 1;
    final nodeIndicatorSize = _resolveIndicatorSize(node);
    final indicatorTop = _indicatorTopPadding();
    final lineCenter = indicatorTop + (nodeIndicatorSize / 2);
    final inactive = _resolveInactiveColor(context);

    final lineColor =
        node.status == TimelineStatus.completed ||
            node.status == TimelineStatus.active
        ? color
        : inactive.withValues(alpha: 0.3);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _columnWidth(
              nodeIndicatorSize,
              isHighlighted: node.isHighlighted,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: isFirst ? lineCenter : 0,
                  bottom: isLast ? null : 0,
                  height: isLast ? lineCenter : null,
                  width: size(2),
                  child: Skeleton.replace(
                    replace: isLoading,
                    replacement: const Bone(),
                    child: Container(color: lineColor),
                  ),
                ),
                Positioned(
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : size(24)),
              child: _buildNodeContent(context, node, color, isLoading),
            ),
          ),
        ],
      ),
    );
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
    final lineCenter = indicatorLeft + (nodeIndicatorSize / 2);
    final inactive = _resolveInactiveColor(context);

    final lineColor =
        node.status == TimelineStatus.completed ||
            node.status == TimelineStatus.active
        ? color
        : inactive.withValues(alpha: 0.3);

    final width = itemWidth ?? size(140);
    final rowHeight = _columnWidth(
      nodeIndicatorSize,
      isHighlighted: node.isHighlighted,
    );

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: rowHeight,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  left: isFirst ? lineCenter : 0,
                  right: isLast ? null : 0,
                  width: isLast ? lineCenter : null,
                  height: size(2),
                  child: Skeleton.replace(
                    replace: isLoading,
                    replacement: const Bone(),
                    child: Container(color: lineColor),
                  ),
                ),
                Positioned(
                  left: indicatorLeft,
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
