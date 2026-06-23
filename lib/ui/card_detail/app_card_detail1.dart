import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/color.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/data_display/app_avatar_stack.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';
import 'package:flutter_ui_kit/ui/status/app_progress_bar.dart';

class AppCardDetail1 extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final List<String>? avatarUrls;
  final int? donorTotalCount;
  final String? donorText;
  final String? progressLabel;
  final String? timeLeftText;
  final double? progress;
  final Color? progressColor;
  final String? raisedAmount;
  final String? raisedLabel;
  final String? progressPercentText;
  final String? description;
  final VoidCallback? onTap;
  final double? width;
  final double? imageHeight;
  final bool isMax;
  final bool isLoading;

  const AppCardDetail1({
    super.key,
    this.imageUrl,
    this.title,
    this.avatarUrls,
    this.donorTotalCount,
    this.donorText,
    this.progressLabel,
    this.timeLeftText,
    this.progress,
    this.progressColor,
    this.raisedAmount,
    this.raisedLabel,
    this.progressPercentText,
    this.description,
    this.onTap,
    this.width,
    this.imageHeight,
    this.isMax = false,
    this.isLoading = false,
  });

  static const Color _defaultProgressColor = Color(0xFF14B8A6);

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(360));
    final imgHeight = imageHeight ?? AppScale.h(200);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final mutedColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final barColor = progressColor ?? _defaultProgressColor;

    final hasDonorSection =
        (avatarUrls != null && avatarUrls!.isNotEmpty) || donorText != null;
    final hasProgressSection = progress != null;
    final hasProgressHeader =
        hasProgressSection && (progressLabel != null || timeLeftText != null);
    final hasProgressStats = hasProgressSection &&
        (raisedAmount != null || progressPercentText != null || progress != null);
    final hasContent = title != null ||
        hasDonorSection ||
        hasProgressSection ||
        description != null;

    final percentLabel = progressPercentText ??
        (progress != null ? '${(progress!.clamp(0.0, 1.0) * 100).round()}%' : null);
    final effectiveRaisedLabel =
        raisedLabel ?? (raisedAmount != null ? 'raised' : null);

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppScale.r(20)),
            border: isDark
                ? Border.all(color: AppColors.border, width: 1)
                : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (imageUrl != null)
                Skeleton.leaf(
                  child: AppImage(
                    imageUrl: imageUrl!,
                    width: double.infinity,
                    height: imgHeight,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppScale.r(20)),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              if (hasContent)
                Padding(
                  padding: EdgeInsets.all(AppScale.w(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: TextStyle(
                            fontSize: AppScale.sp(18),
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1.35,
                          ),
                        ),
                      if (title != null && hasDonorSection)
                        SizedBox(height: AppScale.h(16)),
                      if (hasDonorSection)
                        Row(
                          children: [
                            if (avatarUrls != null && avatarUrls!.isNotEmpty) ...[
                              AppAvatarStack(
                                imageUrls: avatarUrls!,
                                maxDisplay: 4,
                                totalCount: donorTotalCount,
                                size: AppScale.w(32),
                                overlap: AppScale.w(10),
                                borderColor: bgColor,
                              ),
                              if (donorText != null)
                                SizedBox(width: AppScale.w(12)),
                            ],
                            if (donorText != null)
                              Expanded(
                                child: Text(
                                  donorText!,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(13),
                                    color: mutedColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      if ((title != null || hasDonorSection) && hasProgressSection)
                        SizedBox(height: AppScale.h(20)),
                      if (hasProgressSection) ...[
                        if (hasProgressHeader)
                          Row(
                            children: [
                              if (progressLabel != null)
                                Expanded(
                                  child: Text(
                                    progressLabel!,
                                    style: TextStyle(
                                      fontSize: AppScale.sp(13),
                                      fontWeight: FontWeight.w600,
                                      color: mutedColor,
                                    ),
                                  ),
                                ),
                              if (timeLeftText != null)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Skeleton.replace(
                                      replace: isLoading,
                                      replacement: Bone.icon(
                                        size: AppScale.w(14),
                                      ),
                                      child: HeroIcon(
                                        HeroIcons.clock,
                                        style: HeroIconStyle.outline,
                                        size: AppScale.w(14),
                                        color: mutedColor,
                                      ),
                                    ),
                                    SizedBox(width: AppScale.w(4)),
                                    Text(
                                      timeLeftText!,
                                      style: TextStyle(
                                        fontSize: AppScale.sp(13),
                                        color: mutedColor,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        if (hasProgressHeader) SizedBox(height: AppScale.h(10)),
                        AppProgressBar(
                          progress: progress!,
                          color: barColor,
                          height: AppScale.h(8),
                          mainAxisSize: MainAxisSize.max,
                        ),
                        if (hasProgressStats) ...[
                          SizedBox(height: AppScale.h(10)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              if (raisedAmount != null) ...[
                                Text(
                                  raisedAmount!,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(18),
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                if (effectiveRaisedLabel != null) ...[
                                  SizedBox(width: AppScale.w(4)),
                                  Text(
                                    effectiveRaisedLabel,
                                    style: TextStyle(
                                      fontSize: AppScale.sp(13),
                                      color: mutedColor,
                                    ),
                                  ),
                                ],
                              ],
                              const Spacer(),
                              if (percentLabel != null)
                                Text(
                                  percentLabel,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(16),
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                      if ((title != null || hasDonorSection || hasProgressSection) &&
                          description != null)
                        SizedBox(height: AppScale.h(16)),
                      if (description != null)
                        Text(
                          description!,
                          style: TextStyle(
                            fontSize: AppScale.sp(14),
                            color: mutedColor,
                            height: 1.5,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
