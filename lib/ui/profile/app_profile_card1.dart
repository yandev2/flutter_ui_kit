import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';

class AppProfileCard1FooterItem {
  final String? value;
  final String? label;
  final String? text;

  const AppProfileCard1FooterItem({
    this.value,
    this.label,
    this.text,
  });

  bool get isEmpty =>
      (value == null || value!.isEmpty) &&
      (label == null || label!.isEmpty) &&
      (text == null || text!.isEmpty);

  bool get hasValueLabel =>
      (value != null && value!.isNotEmpty) ||
      (label != null && label!.isNotEmpty);
}

class AppProfileCard1 extends StatelessWidget {
  final String? imageUrl;
  final HeroIcons? actionIcon1;
  final VoidCallback? onActionIcon1Tap;
  final HeroIcons? actionIcon2;
  final VoidCallback? onActionIcon2Tap;
  final String? title;
  final String? subtitle;
  final String? description;
  final AppProfileCard1FooterItem? footerItem1;
  final AppProfileCard1FooterItem? footerItem2;
  final AppProfileCard1FooterItem? footerItem3;
  final VoidCallback? onTap;
  final double? width;
  final double? avatarSize;
  final bool isMax;
  final bool isLoading;

  const AppProfileCard1({
    super.key,
    this.imageUrl,
    this.actionIcon1,
    this.onActionIcon1Tap,
    this.actionIcon2,
    this.onActionIcon2Tap,
    this.title,
    this.subtitle,
    this.description,
    this.footerItem1,
    this.footerItem2,
    this.footerItem3,
    this.onTap,
    this.width,
    this.avatarSize,
    this.isMax = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(360));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final avatarDiameter = avatarSize ?? AppScale.w(72);
    final cardRadius = BorderRadius.circular(AppScale.r(24));

    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final subtitleColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final bodyColor = isDark ? AppColors.neutral300 : AppColors.neutral700;
    final iconBtnBg = isDark
        ? AppColors.white.withValues(alpha: 0.08)
        : AppColors.neutral100;

    final hasActions = actionIcon1 != null || actionIcon2 != null;
    final hasHeader = imageUrl != null || hasActions;
    final hasProfileInfo = title != null || subtitle != null;
    final footerItems = [footerItem1, footerItem2, footerItem3]
        .whereType<AppProfileCard1FooterItem>()
        .where((item) => !item.isEmpty)
        .toList();
    final hasFooter = footerItems.isNotEmpty;
    final hasContent =
        hasHeader || hasProfileInfo || description != null || hasFooter;

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: cardWidth,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.all(AppScale.w(24)),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: cardRadius,
            border: isDark
                ? Border.all(color: AppColors.border, width: 1)
                : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: isDark ? 0.25 : 0.06),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasHeader) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (imageUrl != null)
                      Skeleton.replace(
                        replace: isLoading,
                        replacement: Bone.circle(size: avatarDiameter),
                        child: AppImage(
                          imageUrl: imageUrl!,
                          width: avatarDiameter,
                          height: avatarDiameter,
                          borderRadius:
                              BorderRadius.circular(avatarDiameter / 2),
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (imageUrl != null && hasActions)
                      const Spacer(),
                    if (imageUrl == null && hasActions) const Spacer(),
                    if (hasActions)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (actionIcon1 != null) ...[
                            _buildActionButton(
                              icon: actionIcon1!,
                              onTap: onActionIcon1Tap,
                              backgroundColor: iconBtnBg,
                              isLoading: isLoading,
                            ),
                            if (actionIcon2 != null)
                              SizedBox(width: AppScale.w(10)),
                          ],
                          if (actionIcon2 != null)
                            _buildActionButton(
                              icon: actionIcon2!,
                              onTap: onActionIcon2Tap,
                              backgroundColor: iconBtnBg,
                              isLoading: isLoading,
                            ),
                        ],
                      ),
                  ],
                ),
              ],
              if (hasHeader && hasProfileInfo)
                SizedBox(height: AppScale.h(20)),
              if (hasProfileInfo) ...[
                if (title != null)
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: AppScale.sp(22),
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      height: 1.2,
                    ),
                  ),
                if (title != null && subtitle != null)
                  SizedBox(height: AppScale.h(6)),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: AppScale.sp(14),
                      color: subtitleColor,
                    ),
                  ),
              ],
              if ((hasHeader || hasProfileInfo) && description != null)
                SizedBox(height: AppScale.h(16)),
              if (description != null)
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: AppScale.sp(15),
                    color: bodyColor,
                    height: 1.5,
                  ),
                ),
              if ((hasHeader || hasProfileInfo || description != null) &&
                  hasFooter)
                SizedBox(height: AppScale.h(20)),
              if (hasFooter)
                Row(
                  children: [
                    for (var i = 0; i < footerItems.length; i++) ...[
                      if (i > 0) SizedBox(width: AppScale.w(20)),
                      Expanded(
                        child: _buildFooterItem(
                          item: footerItems[i],
                          textColor: textColor,
                          mutedColor: subtitleColor,
                        ),
                      ),
                    ],
                  ],
                ),
              if (!hasContent) const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required HeroIcons icon,
    required Color backgroundColor,
    required bool isLoading,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Skeleton.replace(
        replace: isLoading,
        replacement: Bone.circle(size: AppScale.w(40)),
        child: Container(
          width: AppScale.w(40),
          height: AppScale.w(40),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: HeroIcon(
              icon,
              style: HeroIconStyle.outline,
              size: AppScale.w(20),
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterItem({
    required AppProfileCard1FooterItem item,
    required Color textColor,
    required Color mutedColor,
  }) {
    if (item.hasValueLabel) {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: AppScale.sp(13),
            color: mutedColor,
          ),
          children: [
            if (item.value != null)
              TextSpan(
                text: item.value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            if (item.value != null && item.label != null)
              const TextSpan(text: ' '),
            if (item.label != null) TextSpan(text: item.label),
          ],
        ),
      );
    }

    return Text(
      item.text ?? '',
      style: TextStyle(
        fontSize: AppScale.sp(13),
        color: mutedColor,
      ),
    );
  }
}
