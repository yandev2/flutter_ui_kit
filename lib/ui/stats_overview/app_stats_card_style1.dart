import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppStatsCardStyle1 extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final double trendPercentage;
  final String trendDescription;
  final VoidCallback? onTap;
  final bool isLoading;
  final double? width;

  const AppStatsCardStyle1({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.trendPercentage,
    required this.trendDescription,
    this.onTap,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = trendPercentage >= 0;
    final Color trendColor = isPositive ? AppColors.success : AppColors.error;
    final IconData trendIcon = isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
    final String trendText = '${trendPercentage.abs().toStringAsFixed(1)}%';

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.all(AppScale.w(16)),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppScale.r(16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header: Icon + Label
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppScale.w(6)),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: AppScale.r(16),
                    color: iconColor,
                  ),
                ),
                SizedBox(width: AppScale.w(8)),
                Expanded(
                  child: Skeleton.replace(
                    replace: isLoading,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: AppScale.sp(14),
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppScale.h(16)),
            
            // Value
            Skeleton.replace(
              replace: isLoading,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: AppScale.sp(24),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: AppScale.h(12)),
            
            // Trend
            Row(
              children: [
                Skeleton.replace(
                  replace: isLoading,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendIcon,
                        size: AppScale.r(14),
                        color: trendColor,
                      ),
                      SizedBox(width: AppScale.w(2)),
                      Text(
                        trendText,
                        style: TextStyle(
                          fontSize: AppScale.sp(12),
                          fontWeight: FontWeight.bold,
                          color: trendColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppScale.w(6)),
                Expanded(
                  child: Skeleton.replace(
                    replace: isLoading,
                    child: Text(
                      trendDescription,
                      style: TextStyle(
                        fontSize: AppScale.sp(12),
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
