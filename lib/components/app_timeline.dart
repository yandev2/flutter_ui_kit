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

  const AppTimelineNode({
    required this.title,
    this.subtitle,
    this.status = TimelineStatus.inactive,
    this.isHighlighted = false,
    this.content,
    this.titleSize,
    this.subtitleSize,
  });
}

class AppTimeline extends StatelessWidget {
  final List<AppTimelineNode> nodes;
  final Axis direction;
  final Color? activeColor;
  final double? itemWidth; // Digunakan jika direction == Axis.horizontal
  final bool isLoading;

  const AppTimeline({
    super.key,
    required this.nodes,
    this.direction = Axis.vertical,
    this.activeColor,
    this.itemWidth,
    this.isLoading = false,
  });

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
    final uiTheme = context.uiTheme;
    final isFirst = index == 0;
    final isLast = index == nodes.length - 1;

    final lineColor =
        node.status == TimelineStatus.completed ||
            node.status == TimelineStatus.active
        ? color
        : uiTheme.hintColor.withValues(alpha: 0.3);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Line & Indicator Column
          SizedBox(
            width: size(40),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // The Line
                Positioned(
                  top: isFirst ? size(24) : 0,
                  bottom: isLast ? null : 0,
                  height: isLast ? size(24) : null,
                  width: size(2),
                  child: Skeleton.replace(
                    replace: isLoading,
                    replacement: const Bone(),
                    child: Container(color: lineColor),
                  ),
                ),
                // The Indicator
                Positioned(
                  top: size(12),
                  child: Skeleton.replace(
                    replace: isLoading,
                    replacement: Bone.circle(size: size(24)),
                    child: _buildIndicator(context, node, color),
                  ),
                ),
              ],
            ),
          ),
          // Content Column
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
    final uiTheme = context.uiTheme;
    final isFirst = index == 0;
    final isLast = index == nodes.length - 1;

    final lineColor =
        node.status == TimelineStatus.completed ||
            node.status == TimelineStatus.active
        ? color
        : uiTheme.hintColor.withValues(alpha: 0.3);

    final width = itemWidth ?? size(140);

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line & Indicator
          SizedBox(
            height: size(40),
            width: double.infinity,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // The Line
                Positioned(
                  left: isFirst ? size(24) : 0,
                  right: isLast ? null : 0,
                  width: isLast ? size(24) : null,
                  height: size(2),
                  child: Skeleton.replace(
                    replace: isLoading,
                    replacement: const Bone(),
                    child: Container(color: lineColor),
                  ),
                ),
                // The Indicator
                Positioned(
                  left: size(12),
                  child: Skeleton.replace(
                    replace: isLoading,
                    replacement: Bone.circle(size: size(24)),
                    child: _buildIndicator(context, node, color),
                  ),
                ),
              ],
            ),
          ),
          // Content
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
    Color color,
  ) {
    final uiTheme = context.uiTheme;
    switch (node.status) {
      case TimelineStatus.completed:
        return Container(
          width: size(24),
          height: size(24),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Container(
              width: size(8),
              height: size(8),
              decoration: BoxDecoration(
                color: uiTheme.surface,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case TimelineStatus.active:
        return Container(
          width: size(24),
          height: size(24),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
          ),
          child: Center(
            child: Container(
              width: size(10),
              height: size(10),
              decoration: BoxDecoration(
                color: uiTheme.success,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case TimelineStatus.inactive:
        final inactiveColor = uiTheme.hintColor.withValues(alpha: 0.5);
        return Container(
          width: size(24),
          height: size(24),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: inactiveColor, width: size(2)),
          ),
          child: Center(
            child: Container(
              width: size(8),
              height: size(8),
              decoration: BoxDecoration(
                color: inactiveColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case TimelineStatus.disabled:
        final disabledColor = uiTheme.disabledColor;
        return Container(
          width: size(24),
          height: size(24),
          decoration: BoxDecoration(
            color: disabledColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: size(8),
              height: size(8),
              decoration: BoxDecoration(
                color: disabledColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
    }
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
        ? uiTheme.success
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
            color: theme.cardColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(size(12)),
            border: Border.all(color: theme.cardColor),
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
