import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';

class AppProfileCard2 extends StatelessWidget {
  final String? imageUrl;
  final Widget? image;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? avatarSize;
  final String? name;
  final String? email;
  final String? badgeText;
  final HeroIcons? badgeIcon;
  final VoidCallback? onBadgeTap;
  final Widget? badge;
  final Color? badgeBackgroundColor;
  final Color? badgeForegroundColor;
  final Widget? content;
  final bool isMax;
  final bool isLoading;

  const AppProfileCard2({
    super.key,
    this.imageUrl,
    this.image,
    this.width,
    this.margin,
    this.onTap,
    this.avatarSize,
    this.name,
    this.email,
    this.badgeText,
    this.badgeIcon,
    this.onBadgeTap,
    this.badge,
    this.badgeBackgroundColor,
    this.badgeForegroundColor,
    this.content,
    this.isMax = false,
    this.isLoading = false,
  }) : assert(
          imageUrl != null || image != null,
          'imageUrl or image must be provided',
        );

  factory AppProfileCard2.network({
    Key? key,
    required String imageUrl,
    double? avatarSize,
    double? width,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    String? name,
    String? email,
    String? badgeText,
    HeroIcons? badgeIcon,
    VoidCallback? onBadgeTap,
    Widget? badge,
    Color? badgeBackgroundColor,
    Color? badgeForegroundColor,
    Widget? content,
    bool isMax = false,
    bool isLoading = false,
  }) {
    return AppProfileCard2(
      key: key,
      imageUrl: imageUrl,
      avatarSize: avatarSize ?? AppScale.w(80),
      width: width,
      margin: margin,
      onTap: onTap,
      name: name,
      email: email,
      badgeText: badgeText,
      badgeIcon: badgeIcon,
      onBadgeTap: onBadgeTap,
      badge: badge,
      badgeBackgroundColor: badgeBackgroundColor,
      badgeForegroundColor: badgeForegroundColor,
      content: content,
      isMax: isMax,
      isLoading: isLoading,
    );
  }

  bool get _hasBadge =>
      badge != null || (badgeText != null && badgeText!.isNotEmpty);

  Widget _buildAvatar(double avatar, bool isDark) {
    final avatarWidget = image ??
        AppImage(
          imageUrl: imageUrl!,
          width: avatar,
          height: avatar,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(avatar / 2),
        );

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? AppColors.border : AppColors.neutral200,
          width: AppScale.w(3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: isDark ? 0.2 : 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Skeleton.replace(
          replace: isLoading,
          replacement: Bone.circle(size: avatar),
          child: SizedBox(
            width: avatar,
            height: avatar,
            child: avatarWidget,
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    if (badge != null) return badge!;

    final icon = badgeIcon ?? HeroIcons.sparkles;
    return AppButton(
      text: badgeText!,
      customIcon: HeroIcon(
        icon,
        style: HeroIconStyle.solid,
        size: AppScale.w(16),
        color: badgeForegroundColor ?? AppColors.white,
      ),
      onPressed: onBadgeTap ?? () {},
      variant: AppButtonVariant.solid,
      shape: AppButtonShape.pill,
      size: AppButtonSize.small,
      color: badgeBackgroundColor ?? AppColors.primary,
      textColor: badgeForegroundColor ?? AppColors.white,
      isLoading: isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardWidth = isMax ? double.infinity : (width ?? AppScale.w(280));
    final avatar = avatarSize ?? AppScale.w(80);
    final bgColor = isDark ? AppColors.surface : AppColors.white;
    final nameColor = isDark ? AppColors.white : AppColors.neutral900;
    final emailColor = isDark ? AppColors.neutral400 : AppColors.neutral500;

    final card = Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: cardWidth,
        margin: margin,
        padding: EdgeInsets.symmetric(
          horizontal: AppScale.w(24),
          vertical: AppScale.h(28),
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppScale.r(24)),
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAvatar(avatar, isDark),
            if (name != null && name!.isNotEmpty) ...[
              SizedBox(height: AppScale.h(16)),
              Skeleton.replace(
                replace: isLoading,
                replacement: Bone.text(words: 2),
                child: Text(
                  name!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppScale.sp(18),
                    fontWeight: FontWeight.bold,
                    color: nameColor,
                    height: 1.2,
                  ),
                ),
              ),
            ],
            if (email != null && email!.isNotEmpty) ...[
              SizedBox(height: AppScale.h(4)),
              Skeleton.replace(
                replace: isLoading,
                replacement: Bone.text(words: 2),
                child: Text(
                  email!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppScale.sp(14),
                    color: emailColor,
                  ),
                ),
              ),
            ],
            if (content != null) ...[
              SizedBox(height: AppScale.h(16)),
              content!,
            ],
            if (_hasBadge) ...[
              SizedBox(height: AppScale.h(16)),
              Skeleton.leaf(child: _buildBadge()),
            ],
          ],
        ),
      ),
    );

    if (onTap == null) return card;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: card,
    );
  }
}
