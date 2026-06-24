import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';
import 'package:flutter_ui_kit/ui/buttons/app_button.dart';
import 'package:flutter_ui_kit/ui/image/app_image.dart';

class AppWelcomeAppBar extends StatelessWidget {
  final Widget? leadingWidget;
  final String? imageUrl;
  final String? greeting;
  final String? title;
  final bool isVerified;

  // Notification Icon
  final HeroIcons? notificationIcon;
  final int? notificationCount;
  final VoidCallback? onNotificationTap;
  final Color? notificationBackgroundColor;

  // Action Icon (Extra)
  final HeroIcons? actionIcon;
  final int? actionCount;
  final VoidCallback? onActionTap;
  final Color? actionBackgroundColor;

  final VoidCallback? onProfileTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? avatarSize;
  final bool isLoading;

  final bool isSliver;

  const AppWelcomeAppBar({
    super.key,
    this.leadingWidget,
    this.imageUrl,
    this.greeting,
    this.title,
    this.isVerified = false,
    this.notificationIcon,
    this.notificationCount,
    this.onNotificationTap,
    this.notificationBackgroundColor,
    this.actionIcon,
    this.actionCount,
    this.onActionTap,
    this.actionBackgroundColor,
    this.onProfileTap,
    this.backgroundColor,
    this.padding,
    this.avatarSize,
    this.isLoading = false,
  }) : isSliver = false;

  const AppWelcomeAppBar.sliver({
    super.key,
    this.leadingWidget,
    this.imageUrl,
    this.greeting,
    this.title,
    this.isVerified = false,
    this.notificationIcon,
    this.notificationCount,
    this.onNotificationTap,
    this.notificationBackgroundColor,
    this.actionIcon,
    this.actionCount,
    this.onActionTap,
    this.actionBackgroundColor,
    this.onProfileTap,
    this.backgroundColor,
    this.padding,
    this.avatarSize,
    this.isLoading = false,
  }) : isSliver = true;

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);
    if (isSliver) {
      return SliverToBoxAdapter(child: content);
    }
    return content;
  }

  Widget _buildContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final avatarDiameter = avatarSize ?? AppScale.w(52);
    final hasText = greeting != null || title != null;
    final hasLeading = leadingWidget != null || imageUrl != null || hasText;
    final showNotification = onNotificationTap != null;
    final showAction = onActionTap != null;

    final textColor = isDark ? AppColors.white : AppColors.neutral900;
    final greetingColor = isDark ? AppColors.neutral400 : AppColors.neutral500;
    final btnBg = isDark ? AppColors.surface : AppColors.white;
    final btnIconColor = isDark ? AppColors.white : AppColors.neutral900;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: double.infinity,
        color: backgroundColor ?? Colors.transparent,
        padding:
            padding ??
            EdgeInsets.symmetric(
              horizontal: AppScale.w(16),
              vertical: AppScale.h(12),
            ),
        child: Row(
          children: [
            if (hasLeading)
              Expanded(
                child: GestureDetector(
                  onTap: onProfileTap,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      if (leadingWidget != null)
                        leadingWidget!
                      else if (imageUrl != null) ...[
                        Skeleton.replace(
                          replace: isLoading,
                          replacement: Bone.circle(size: avatarDiameter),
                          child: AppImage(
                            imageUrl: imageUrl!,
                            width: avatarDiameter,
                            height: avatarDiameter,
                            borderRadius: BorderRadius.circular(
                              avatarDiameter / 2,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                      if ((leadingWidget != null || imageUrl != null) &&
                          hasText)
                        SizedBox(width: AppScale.w(12)),
                      if (hasText)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (greeting != null)
                                Text(
                                  greeting!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: AppScale.sp(13),
                                    color: greetingColor,
                                  ),
                                ),
                              if (greeting != null && title != null)
                                SizedBox(height: AppScale.h(4)),
                              if (title != null)
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: AppScale.sp(18),
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    if (isVerified) ...[
                                      SizedBox(width: AppScale.w(6)),
                                      Skeleton.replace(
                                        replace: isLoading,
                                        replacement: Bone.icon(
                                          size: AppScale.w(18),
                                        ),
                                        child: HeroIcon(
                                          HeroIcons.checkBadge,
                                          style: HeroIconStyle.solid,
                                          color: AppColors.success,
                                          size: AppScale.w(18),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            if (hasLeading && (showNotification || showAction))
              SizedBox(width: AppScale.w(12)),
            if (showAction) ...[
              _buildNotificationButton(
                icon: actionIcon ?? HeroIcons.sparkles,
                count: actionCount,
                onTap: onActionTap!,
                backgroundColor: actionBackgroundColor ?? btnBg,
                iconColor: btnIconColor,
              ),
              if (showNotification) SizedBox(width: AppScale.w(8)),
            ],
            if (showNotification)
              _buildNotificationButton(
                icon: notificationIcon ?? HeroIcons.bell,
                count: notificationCount,
                onTap: onNotificationTap!,
                backgroundColor: notificationBackgroundColor ?? btnBg,
                iconColor: btnIconColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton({
    required HeroIcons icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onTap,
    int? count,
  }) {
    final showBadge = count != null && count > 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppButton(
          customIcon: HeroIcon(
            icon,
            style: HeroIconStyle.outline,
            color: iconColor,
            size: AppScale.w(22),
          ),
          onPressed: onTap,
          variant: AppButtonVariant.solid,
          shape: AppButtonShape.square,
          size: AppButtonSize.small,
          color: backgroundColor,
          textColor: iconColor,
        ),
        if (showBadge)
          Positioned(
            top: -AppScale.h(4),
            right: -AppScale.w(4),
            child: Container(
              constraints: BoxConstraints(
                minWidth: AppScale.w(18),
                minHeight: AppScale.w(18),
              ),
              padding: EdgeInsets.symmetric(horizontal: AppScale.w(4)),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(AppScale.r(10)),
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                count > 99 ? '99+' : '$count',
                style: TextStyle(
                  fontSize: AppScale.sp(10),
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  height: 1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
