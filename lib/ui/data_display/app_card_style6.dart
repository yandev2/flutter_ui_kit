import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';

class AppCardStyle6 extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? author;
  final String? date;
  final String? tagText;
  final Color? tagColor;
  final Color? playRingColor;
  final VoidCallback? onPlayTap;
  final VoidCallback? onTap;
  final double? width;
  final double? imageHeight;
  final bool isMax;
  final bool isLoading;
  
  final double? titleSize;
  final double? authorSize;
  final double? dateSize;
  final double? tagTextSize;

  const AppCardStyle6({
    super.key,
    this.imageUrl,
    this.title,
    this.author,
    this.date,
    this.tagText,
    this.tagColor,
    this.playRingColor,
    this.onPlayTap,
    this.onTap,
    this.width,
    this.imageHeight,
    this.isMax = false,
    this.isLoading = false,
    this.titleSize,
    this.authorSize,
    this.dateSize,
    this.tagTextSize,
  });

  static const Color _defaultTagColor = Color(0xFFE85D5C);
  static const Color _defaultPlayRingColor = Color(0xFFE8A838);

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(320));
    final imgHeight = imageHeight ?? AppScale.h(200);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final playSize = AppScale.w(56);
    final playOverlap = playSize * 0.45;
    final badgeColor = tagColor ?? _defaultTagColor;
    final ringColor = playRingColor ?? _defaultPlayRingColor;

    final hasMetadata = author != null || date != null;
    final showPlay = onPlayTap != null;
    final hasContent =
        title != null || hasMetadata || tagText != null;
    final needsContentArea = hasContent || (imageUrl != null && showPlay);
    final cardRadius = BorderRadius.circular(AppScale.r(20));
    final imageRadius = BorderRadius.vertical(
      top: Radius.circular(AppScale.r(20)),
    );

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: cardWidth,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: cardRadius,
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
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (imageUrl != null)
                    Skeleton.replace(
                      replace: isLoading,
                      replacement: Bone(
                        width: double.infinity,
                        height: imgHeight,
                        borderRadius: imageRadius,
                      ),
                      child: AppImage(
                        imageUrl: imageUrl!,
                        width: double.infinity,
                        height: imgHeight,
                        borderRadius: imageRadius,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (needsContentArea)
                      Container(
                        color: bgColor,
                        padding: EdgeInsets.fromLTRB(
                          AppScale.w(20),
                          showPlay && imageUrl != null
                              ? playOverlap + AppScale.h(8)
                              : AppScale.h(20),
                          AppScale.w(20),
                          AppScale.h(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (title != null)
                              Padding(
                                padding: EdgeInsets.only(
                                  left: showPlay && imageUrl != null
                                      ? playSize * 0.55
                                      : 0,
                                ),
                                child: Text(
                                  title!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: titleSize ?? AppScale.sp(18),
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            if (title != null && hasMetadata)
                              SizedBox(height: AppScale.h(12)),
                            if (hasMetadata)
                              Padding(
                                padding: EdgeInsets.only(
                                  left: showPlay && imageUrl != null
                                      ? playSize * 0.55
                                      : 0,
                                ),
                                child: Wrap(
                                  spacing: AppScale.w(12),
                                  runSpacing: AppScale.h(4),
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    if (author != null)
                                      Text(
                                        author!,
                                        style: TextStyle(
                                          fontSize: authorSize ?? AppScale.sp(13),
                                          color: subtitleColor,
                                        ),
                                      ),
                                    if (date != null)
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
                                              color: subtitleColor,
                                            ),
                                          ),
                                          SizedBox(width: AppScale.w(4)),
                                          Text(
                                            date!,
                                            style: TextStyle(
                                              fontSize: dateSize ?? AppScale.sp(13),
                                              color: subtitleColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            if (tagText != null) ...[
                              if (title != null || hasMetadata)
                                SizedBox(height: AppScale.h(16)),
                                _buildTag(
                                  text: tagText!,
                                  color: badgeColor,
                                  isLoading: isLoading,
                                  textSize: tagTextSize,
                                ),
                            ],
                          ],
                        ),
                      ),
                  ],
                ),
                if (imageUrl != null && showPlay)
                  Positioned(
                    left: AppScale.w(16),
                    top: imgHeight - playOverlap,
                    child: _buildPlayButton(
                      size: playSize,
                      ringColor: ringColor,
                      isLoading: isLoading,
                      onTap: onPlayTap!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _buildPlayButton({
    required double size,
    required Color ringColor,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Skeleton.replace(
        replace: isLoading,
        replacement: Bone.circle(size: size),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ringColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(AppScale.w(4)),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              color: AppColors.neutral900,
              size: size * 0.45,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag({
    required String text,
    required Color color,
    required bool isLoading,
    double? textSize,
  }) {
    return Skeleton.leaf(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppScale.w(14),
          vertical: AppScale.h(8),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppScale.r(24)),
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Skeleton.replace(
            replace: isLoading,
            replacement: Bone.circle(size: AppScale.w(6)),
            child: Container(
              width: AppScale.w(6),
              height: AppScale.w(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(width: AppScale.w(8)),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: textSize ?? AppScale.sp(10),
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    ),
    );
  }
}
