import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

enum AppTimelineStatus { completed, active, inactive, disabled }

class AppTimelineNode {
  final String title;
  final String? subtitle;
  final AppTimelineStatus status;
  final bool isHighlighted;
  final Widget? content;
  
  final double? titleSize;
  final double? subtitleSize;

  const AppTimelineNode({
    required this.title,
    this.subtitle,
    this.status = AppTimelineStatus.inactive,
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

  const AppTimeline({
    super.key,
    required this.nodes,
    this.direction = Axis.vertical,
    this.activeColor,
    this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    final color = activeColor ?? AppColors.primary;
    
    if (direction == Axis.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(nodes.length, (index) {
          return _buildVerticalNode(context, index, nodes[index], color);
        }),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(nodes.length, (index) {
            return _buildHorizontalNode(context, index, nodes[index], color);
          }),
        ),
      );
    }
  }

  Widget _buildVerticalNode(BuildContext context, int index, AppTimelineNode node, Color color) {
    final isFirst = index == 0;
    final isLast = index == nodes.length - 1;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    final lineColor = node.status == AppTimelineStatus.completed || node.status == AppTimelineStatus.active 
        ? color 
        : (isDarkMode ? AppColors.neutral700 : AppColors.neutral200);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Line & Indicator Column
          SizedBox(
            width: AppScale.w(40),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // The Line
                Positioned(
                  top: isFirst ? AppScale.h(24) : 0,
                  bottom: isLast ? null : 0,
                  height: isLast ? AppScale.h(24) : null,
                  width: AppScale.w(2),
                  child: Container(color: lineColor),
                ),
                // The Indicator
                Positioned(
                  top: AppScale.h(12),
                  child: _buildIndicator(node, color, isDarkMode),
                ),
              ],
            ),
          ),
          // Content Column
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppScale.h(24)),
              child: _buildNodeContent(context, node, color, isDarkMode),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalNode(BuildContext context, int index, AppTimelineNode node, Color color) {
    final isFirst = index == 0;
    final isLast = index == nodes.length - 1;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    final lineColor = node.status == AppTimelineStatus.completed || node.status == AppTimelineStatus.active 
        ? color 
        : (isDarkMode ? AppColors.neutral700 : AppColors.neutral200);

    final width = itemWidth ?? AppScale.w(140);

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line & Indicator
          SizedBox(
            height: AppScale.h(40),
            width: double.infinity,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // The Line
                Positioned(
                  left: isFirst ? AppScale.w(24) : 0,
                  right: isLast ? null : 0,
                  width: isLast ? AppScale.w(24) : null,
                  height: AppScale.h(2),
                  child: Container(color: lineColor),
                ),
                // The Indicator
                Positioned(
                  left: AppScale.w(12),
                  child: _buildIndicator(node, color, isDarkMode),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(right: AppScale.w(16)),
            child: _buildNodeContent(context, node, color, isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(AppTimelineNode node, Color color, bool isDarkMode) {
    switch (node.status) {
      case AppTimelineStatus.completed:
        return Container(
          width: AppScale.w(24),
          height: AppScale.w(24),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: AppScale.w(8),
              height: AppScale.w(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case AppTimelineStatus.active:
        return Container(
          width: AppScale.w(24),
          height: AppScale.w(24),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
          ),
          child: Center(
            child: Container(
              width: AppScale.w(10),
              height: AppScale.w(10),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case AppTimelineStatus.inactive:
        final inactiveColor = isDarkMode ? AppColors.neutral600 : AppColors.neutral300;
        return Container(
          width: AppScale.w(24),
          height: AppScale.w(24),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: inactiveColor, width: AppScale.w(2)),
          ),
          child: Center(
            child: Container(
              width: AppScale.w(8),
              height: AppScale.w(8),
              decoration: BoxDecoration(
                color: inactiveColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case AppTimelineStatus.disabled:
        final disabledColor = isDarkMode ? AppColors.neutral800 : AppColors.neutral200;
        return Container(
          width: AppScale.w(24),
          height: AppScale.w(24),
          decoration: BoxDecoration(
            color: disabledColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: AppScale.w(8),
              height: AppScale.w(8),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.neutral700 : AppColors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
    }
  }

  Widget _buildNodeContent(BuildContext context, AppTimelineNode node, Color color, bool isDarkMode) {
    final titleColor = node.status == AppTimelineStatus.disabled
        ? (isDarkMode ? AppColors.neutral600 : AppColors.neutral400)
        : AppColors.textPrimary;
        
    final subtitleColor = node.status == AppTimelineStatus.disabled
        ? (isDarkMode ? AppColors.neutral700 : AppColors.neutral300)
        : AppColors.textSecondary;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          node.title,
          style: TextStyle(
            fontSize: node.titleSize ?? AppScale.sp(14),
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        if (node.subtitle != null) ...[
          SizedBox(height: AppScale.h(4)),
          Text(
            node.subtitle!,
            style: TextStyle(
              fontSize: node.subtitleSize ?? AppScale.sp(12),
              color: subtitleColor,
            ),
          ),
        ],
        if (node.content != null) ...[
          SizedBox(height: AppScale.h(8)),
          node.content!,
        ],
      ],
    );

    if (node.isHighlighted) {
      content = Container(
        padding: EdgeInsets.all(AppScale.w(12)),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.neutral800 : AppColors.neutral100,
          borderRadius: BorderRadius.circular(AppScale.r(12)),
          border: Border.all(
            color: isDarkMode ? AppColors.neutral700 : AppColors.neutral200,
          ),
        ),
        child: content,
      );
    } else {
      content = Padding(
        padding: EdgeInsets.symmetric(vertical: AppScale.h(8), horizontal: AppScale.w(4)),
        child: content,
      );
    }

    return content;
  }
}
