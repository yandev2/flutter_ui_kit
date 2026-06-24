import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/theme/theme.dart';

class AppAvatarStack extends StatelessWidget {
  final List<String> imageUrls;
  final int? totalCount;
  final int maxDisplay;
  final double size;
  final double overlap;
  final double borderWidth;
  final Color? borderColor;
  final bool showOnlineIndicator;
  final double? textSize;

  const AppAvatarStack({
    super.key,
    required this.imageUrls,
    this.totalCount,
    this.maxDisplay = 5,
    this.size = 40.0,
    this.overlap = 12.0,
    this.borderWidth = 2.0,
    this.borderColor,
    this.showOnlineIndicator = false,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTotalCount = totalCount ?? imageUrls.length;
    final displayCount = imageUrls.length > maxDisplay
        ? maxDisplay - 1
        : imageUrls.length;
    final hasMore = effectiveTotalCount > displayCount;
    final totalItems = displayCount + (hasMore ? 1 : 0);

    if (totalItems == 0) return const SizedBox.shrink();

    // Calculate width: size for the first item, plus (size - overlap) for the rest
    final stackWidth = size + ((totalItems - 1) * (size - overlap));
    final effectiveBorderColor = borderColor ?? Theme.of(context).cardColor;

    return SizedBox(
      width: stackWidth,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(totalItems, (index) {
          final double leftPos = index * (size - overlap);

          Widget child;
          if (hasMore && index == displayCount) {
            // "More" indicator (+X)
            final remainingCount = effectiveTotalCount - displayCount;
            child = Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color:
                    AppColors.neutral600, // Dark gray background as requested
                shape: BoxShape.circle,
                border: Border.all(
                  color: effectiveBorderColor,
                  width: borderWidth,
                ),
              ),
              child: Center(
                child: Text(
                  '+$remainingCount',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: textSize ?? (size * 0.35), // Scale text based on size or use custom
                  ),
                ),
              ),
            );
          } else {
            // Avatar
            final url = imageUrls[index];
            child = Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: effectiveBorderColor,
                      width: borderWidth,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: AppColors.neutral200),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.neutral300,
                        child: Center(
                          child: HeroIcon(
                            HeroIcons.camera,
                            color: AppColors.neutral500,
                            size: size * 0.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (showOnlineIndicator)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: size * 0.3,
                      height: size * 0.3,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: effectiveBorderColor,
                          width: borderWidth,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }

          return Positioned(left: leftPos, child: child);
        }),
      ),
    );
  }
}
