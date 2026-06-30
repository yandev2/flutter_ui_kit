import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../ui_component_flutter.dart';

class AppDashboardAppbar extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? avatarUrl;
  final Widget? trailingWidget;

  /// Dipanggil ketika tombol tema (bulan/matahari) diklik.
  /// Jika null, tombol tema tidak akan ditampilkan.
  final VoidCallback? onThemeToggle;

  /// Apakah posisi appbar saat ini sedang dalam mode gelap (dark mode).
  /// Berguna untuk menentukan ikon bulan atau matahari yang tampil.
  final bool isDarkMode;

  const AppDashboardAppbar({
    super.key,
    required this.title,
    required this.subtitle,
    this.avatarUrl,
    this.trailingWidget,
    this.onThemeToggle,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;

    return SliverAppBar(
      floating: true,
      backgroundColor: uiTheme.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: size(80),
      titleSpacing: 0,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: size(16), vertical: size(10)),
        child: Row(
          children: [
            // Avatar
            Container(
              width: size(48),
              height: size(48),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: uiTheme.primary.withValues(alpha: 0.1),
                image: avatarUrl != null
                    ? DecorationImage(
                        image: NetworkImage(avatarUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: avatarUrl == null
                  ? HeroIcon(HeroIcons.user, color: uiTheme.primary)
                  : null,
            ),
            SizedBox(width: size(12)),
            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: uiTheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size(4)),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: uiTheme.hintColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onThemeToggle != null) ...[
                  _buildActionButton(
                    context: context,
                    icon: isDarkMode ? HeroIcons.sun : HeroIcons.moon,
                    onTap: onThemeToggle!,
                  ),
                ],
                if (trailingWidget != null) ...[
                  if (onThemeToggle != null) SizedBox(width: size(12)),
                  trailingWidget!,
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required HeroIcons icon,
    required VoidCallback onTap,
  }) {
    final uiTheme = context.uiTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size(8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size(10)),
          color: uiTheme.primary.withValues(alpha: 0.1),
        ),
        child: HeroIcon(icon, size: size(20), color: uiTheme.primary),
      ),
    );
  }
}
