import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../button/app_button.dart';
import '../../../theme/app_scale.dart';
import '../../../theme/theme.dart';
import '../image/app_image.dart';
import '../theme/card_style_1_theme.dart';
import '../theme/ui_theme_helpers.dart';

class CardStyle1 extends StatelessWidget {
  const CardStyle1({
    super.key,
    required this.image,
    this.width,
    this.margin,
    this.onTap,
    this.avatars,
    this.avatarUrls,
    this.maxAvatars = 4,
    this.title,
    this.edition,
    this.price,
    this.priceLeading,
    this.priceIcon,
    this.timeLabel,
    this.timeLeading,
    this.timeIcon,
    this.actionLabel,
    this.onActionTap,
    this.style,
    this.imageHeight,
    this.footer,
    this.content,
    this.isLoading,
  });

  /// Shortcut jika image berupa URL string.
  factory CardStyle1.network({
    Key? key,
    required String imageUrl,
    double? imageHeight,
    double? width,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    List<Widget>? avatars,
    List<String>? avatarUrls,
    int maxAvatars = 4,
    String? title,
    String? edition,
    String? price,
    Widget? priceLeading,
    HeroIcons? priceIcon,
    String? timeLabel,
    Widget? timeLeading,
    HeroIcons? timeIcon,
    String? actionLabel,
    VoidCallback? onActionTap,
    CardStyle1Theme? style,
    Widget? footer,
    Widget? content,
    bool? isLoading,
  }) {
    return CardStyle1(
      key: key,
      image: Skeleton.leaf(
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(size(16)),
          child: AppImage(
            imageUrl: imageUrl,
            width: double.infinity,
            height: imageHeight ?? size(180),
            fit: BoxFit.cover,
          ),
        ),
      ),
      imageHeight: imageHeight ?? size(180),
      width: width,
      margin: margin,
      onTap: onTap,
      avatars: avatars,
      avatarUrls: avatarUrls,
      maxAvatars: maxAvatars,
      title: title,
      edition: edition,
      price: price,
      priceLeading: priceLeading,
      priceIcon: priceIcon,
      timeLabel: timeLabel,
      timeLeading: timeLeading,
      timeIcon: timeIcon,
      actionLabel: actionLabel,
      onActionTap: onActionTap,
      style: style,
      footer: footer,
      content: content,
      isLoading: isLoading,
    );
  }

  /// Image utama — **wajib**.
  final Widget image;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? imageHeight;

  /// Avatar stack di pojok kiri-bawah image.
  final List<Widget>? avatars;
  final List<String>? avatarUrls;
  final int maxAvatars;

  /// Baris judul + teks kanan (mis. "1 of 321").
  final String? title;
  final String? edition;

  /// Baris harga/nilai.
  final String? price;
  final Widget? priceLeading;
  final HeroIcons? priceIcon;

  /// Chip waktu/status di footer kiri.
  final String? timeLabel;
  final Widget? timeLeading;
  final HeroIcons? timeIcon;

  /// Teks aksi di footer kanan.
  final String? actionLabel;
  final VoidCallback? onActionTap;

  /// Slot konten kustom di antara price dan footer.
  final Widget? content;

  /// Footer kustom — menggantikan baris time/action bawaan jika diisi.
  final Widget? footer;

  final CardStyle1Theme? style;
  final bool? isLoading;

  bool get _hasAvatars =>
      (avatars != null && avatars!.isNotEmpty) ||
      (avatarUrls != null && avatarUrls!.isNotEmpty);

  bool get _hasTitleRow =>
      (title != null && title!.isNotEmpty) ||
      (edition != null && edition!.isNotEmpty);

  bool get _hasPrice =>
      (price != null && price!.isNotEmpty) ||
      priceLeading != null ||
      priceIcon != null;

  bool get _hasFooter =>
      footer != null ||
      (timeLabel != null && timeLabel!.isNotEmpty) ||
      (actionLabel != null && actionLabel!.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final theme = style ?? CardStyle1Theme.of(context);

    final card = Skeletonizer(
      enabled: isLoading ?? false,
      child: Container(
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(theme.borderRadius),
          boxShadow: theme.shadow,
        ),
        child: Padding(
          padding: theme.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _ImageSection(
                image: image,
                imageHeight: imageHeight,
                theme: theme,
                avatars: avatars,
                avatarUrls: avatarUrls,
                maxAvatars: maxAvatars,
                isLoading: isLoading ?? false,
              ),
              if (_hasAvatars) SizedBox(height: theme.avatarOverlap),
              if (_hasTitleRow) ...[
                SizedBox(height: theme.contentGap),
                _TitleRow(
                  title: title,
                  edition: edition,
                  theme: theme,
                  isLoading: isLoading ?? false,
                ),
              ],
              if (_hasPrice) ...[
                SizedBox(height: size(6)),
                _PriceRow(
                  price: price,
                  priceLeading: priceLeading,
                  priceIcon: priceIcon,
                  theme: theme,
                  isLoading: isLoading ?? false,
                ),
              ],
              if (content != null) ...[
                SizedBox(height: theme.contentGap),
                Skeleton.leaf(child: content!),
              ],
              if (_hasFooter) ...[
                SizedBox(height: theme.contentGap),
                footer ??
                    _FooterRow(
                      timeLabel: timeLabel,
                      timeLeading: timeLeading,
                      timeIcon: timeIcon,
                      actionLabel: actionLabel,
                      onActionTap: onActionTap,
                      theme: theme,
                      isLoading: isLoading ?? false,
                    ),
              ],
            ],
          ),
        ),
      ),
    );

    if (onTap == null) return card;

    return GestureDetector(onTap: onTap, child: card);
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({
    required this.image,
    required this.theme,
    required this.avatars,
    required this.avatarUrls,
    required this.maxAvatars,
    this.imageHeight,
    required this.isLoading,
  });

  final Widget image;
  final double? imageHeight;
  final CardStyle1Theme theme;
  final List<Widget>? avatars;
  final List<String>? avatarUrls;
  final int maxAvatars;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final hasAvatars =
        (avatars != null && avatars!.isNotEmpty) ||
        (avatarUrls != null && avatarUrls!.isNotEmpty);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(theme.imageRadius),
          child: SizedBox(
            width: double.infinity,
            height: imageHeight,
            child: image,
          ),
        ),
        if (hasAvatars)
          Positioned(
            left: size(10),
            bottom: -theme.avatarOverlap,
            child: _AvatarStack(
              avatars: avatars,
              avatarUrls: avatarUrls,
              maxAvatars: maxAvatars,
              theme: theme,
            ),
          ),
      ],
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({
    required this.avatars,
    required this.avatarUrls,
    required this.maxAvatars,
    required this.theme,
  });

  final List<Widget>? avatars;
  final List<String>? avatarUrls;
  final int maxAvatars;
  final CardStyle1Theme theme;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];

    if (avatars != null && avatars!.isNotEmpty) {
      items.addAll(avatars!.take(maxAvatars));
    } else if (avatarUrls != null && avatarUrls!.isNotEmpty) {
      for (final url in avatarUrls!.take(maxAvatars)) {
        items.add(
          Skeleton.leaf(
            child: CircleAvatar(
              radius: theme.avatarSize / 2 - theme.avatarBorderWidth,
              backgroundColor: AppColors.textMuted.withValues(alpha: 0.2),
              child: AppImage(
                imageUrl: url,
                errorIconSize: size(10),
                borderRadius: BorderRadius.circular(300),
              ),
            ),
          ),
        );
      }
    }

    if (items.isEmpty) return const SizedBox.shrink();

    final step = theme.avatarSize - theme.avatarOverlap;
    final width = theme.avatarSize + (items.length - 1) * step;

    return SizedBox(
      width: width,
      height: theme.avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < items.length; i++)
            Positioned(
              left: i * step,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: UiThemeHelpers.avatarRingColor(context),
                    width: theme.avatarBorderWidth,
                  ),
                ),
                child: items[i],
              ),
            ),
        ],
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.theme,
    this.title,
    this.edition,
    required this.isLoading,
  });

  final String? title;
  final String? edition;
  final CardStyle1Theme theme;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (title != null && title!.isNotEmpty)
          Expanded(
            child: Text(
              title!,
              style: theme.titleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (edition != null && edition!.isNotEmpty) ...[
          if (title != null && title!.isNotEmpty) SizedBox(width: size(8)),
          Text(
            edition!,
            style: theme.editionStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.theme,
    this.price,
    this.priceLeading,
    this.priceIcon,
    required this.isLoading,
  });

  final String? price;
  final Widget? priceLeading;
  final HeroIcons? priceIcon;
  final CardStyle1Theme theme;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (priceLeading != null) ...[
          priceLeading!,
          SizedBox(width: size(4)),
        ] else if (priceIcon != null) ...[
          HeroIcon(priceIcon!, size: size(14), color: theme.accentColor),
          SizedBox(width: size(4)),
        ],
        if (price != null && price!.isNotEmpty)
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              price!,
              style: theme.priceStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

class _FooterRow extends StatelessWidget {
  const _FooterRow({
    required this.theme,
    this.timeLabel,
    this.timeLeading,
    this.timeIcon,
    this.actionLabel,
    this.onActionTap,
    required this.isLoading,
  });

  final String? timeLabel;
  final Widget? timeLeading;
  final HeroIcons? timeIcon;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final CardStyle1Theme theme;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (timeLabel != null && timeLabel!.isNotEmpty)
          Flexible(
            fit: FlexFit.tight,
            child: Skeleton.leaf(
              child: _TimeTag(
                label: timeLabel!,
                leading: timeLeading,
                icon: timeIcon,
                theme: theme,
                isMax: actionLabel == null,
              ),
            ),
          ),

        if (actionLabel != null && actionLabel!.isNotEmpty) ...[
          const Spacer(),
          AppButton(
            onPressed: onActionTap,
            label: actionLabel ?? '',
            expand: false,
          ),
        ],
      ],
    );
  }
}

class _TimeTag extends StatelessWidget {
  const _TimeTag({
    required this.label,
    required this.theme,
    this.leading,
    this.icon,
    this.isMax = false,
  });

  final String label;
  final Widget? leading;
  final HeroIcons? icon;
  final CardStyle1Theme theme;
  final bool isMax;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMax ? Get.width : null,
      padding: EdgeInsets.symmetric(horizontal: size(10), vertical: size(5)),
      decoration: BoxDecoration(
        color: theme.accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(size(20)),
        border: Border.all(color: theme.accentColor.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null)
            leading!
          else if (icon != null)
            HeroIcon(icon!, size: size(12), color: theme.accentColor),
          if (leading != null || icon != null) SizedBox(width: size(4)),
          Flexible(
            child: Text(
              label,
              style: theme.timeTagStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
