import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../ui_component_flutter.dart';

class AppDashboardAppbar extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? avatarUrl;
  final Widget? trailingWidget;

  /// Ukuran diameter avatar lingkaran. Default responsif `48`.
  final double? avatarSize;

  /// Ukuran font title (nilai desain, diskalakan via `size()`).
  final double? titleSize;

  /// Ukuran font subtitle (nilai desain, diskalakan via `size()`).
  final double? subtitleSize;

  /// Jika true, konten ditampilkan sebagai skeleton.
  /// Widget opsional yang null disembunyikan; yang ada di-replace skeleton.
  final bool isLoading;

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
    this.avatarSize,
    this.titleSize,
    this.subtitleSize,
    this.isLoading = false,
    this.onThemeToggle,
    this.isDarkMode = false,
  });

  double _avatarDiameter() => size(avatarSize ?? 48);

  double _avatarIconSize(double diameter) =>
      (diameter * 0.42).clamp(size(16), size(28));

  bool get _showAvatar => !isLoading || avatarUrl != null;

  bool get _showThemeToggle => onThemeToggle != null;

  bool get _showTrailing => trailingWidget != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uiTheme = context.uiTheme;
    final avatarDiameter = _avatarDiameter();
    final avatarIconSize = _avatarIconSize(avatarDiameter);

    return SliverAppBar(
      floating: true,
      backgroundColor: uiTheme.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: size(80),
      titleSpacing: 0,
      title: Skeletonizer(
        enabled: isLoading,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size(16), vertical: size(10)),
          child: Row(
            children: [
              if (_showAvatar) ...[
                Skeleton.replace(
                  replace: isLoading && avatarUrl != null,
                  replacement: Bone.circle(size: avatarDiameter),
                  child: _buildAvatar(context, avatarDiameter, avatarIconSize),
                ),
                SizedBox(width: size(12)),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize:
                            titleSize != null ? size(titleSize!) : null,
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
                        fontSize:
                            subtitleSize != null ? size(subtitleSize!) : null,
                        color: uiTheme.hintColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_showThemeToggle) ...[
                    Skeleton.replace(
                      replace: isLoading,
                      replacement: Bone(
                        width: size(36),
                        height: size(36),
                        borderRadius: BorderRadius.circular(size(10)),
                      ),
                      child: _buildActionButton(
                        context: context,
                        icon: isDarkMode ? HeroIcons.sun : HeroIcons.moon,
                        onTap: onThemeToggle!,
                      ),
                    ),
                  ],
                  if (_showTrailing) ...[
                    if (_showThemeToggle) SizedBox(width: size(12)),
                    Skeleton.replace(
                      replace: isLoading,
                      replacement: Bone(
                        width: size(24),
                        height: size(24),
                        borderRadius: BorderRadius.circular(size(6)),
                      ),
                      child: trailingWidget!,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    double avatarDiameter,
    double avatarIconSize,
  ) {
    final uiTheme = context.uiTheme;

    return Container(
      width: avatarDiameter,
      height: avatarDiameter,
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
          ? Center(
              child: HeroIcon(
                HeroIcons.user,
                color: uiTheme.primary,
                size: avatarIconSize,
              ),
            )
          : null,
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
