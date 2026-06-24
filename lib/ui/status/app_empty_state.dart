import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final Widget? customImageWidget;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.customImageWidget,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppScale.w(24), vertical: AppScale.h(32)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image logic
          if (customImageWidget != null)
            customImageWidget!
          else if (imageUrl != null && imageUrl!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: imageUrl!,
              width: AppScale.w(200),
              height: AppScale.w(200),
              fit: BoxFit.contain,
              placeholder: (context, url) => Center(
                child: SizedBox(
                  width: AppScale.w(40),
                  height: AppScale.w(40),
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: HeroIcon(
                  HeroIcons.photo,
                  color: AppColors.neutral300,
                  size: AppScale.w(80),
                ),
              ),
            )
          else
            // Fallback default icon if no image provided
            Container(
              width: AppScale.w(120),
              height: AppScale.w(120),
              decoration: BoxDecoration(
                color: AppColors.neutral100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: HeroIcon(
                  HeroIcons.documentMagnifyingGlass,
                  color: AppColors.neutral400,
                  size: AppScale.w(60),
                ),
              ),
            ),
          
          SizedBox(height: AppScale.h(24)),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppScale.sp(18),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppScale.h(12)),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppScale.sp(14),
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          
          // Optional Action Button
          if (actionLabel != null && onAction != null) ...[
            SizedBox(height: AppScale.h(32)),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: AppScale.w(24), vertical: AppScale.h(14)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppScale.r(100)),
                ),
                elevation: 0,
              ),
              child: Text(
                actionLabel!,
                style: TextStyle(
                  fontSize: AppScale.sp(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
