import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppDialogDemoPage extends StatelessWidget {
  const AppDialogDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppDialog Demo',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: context.uiTheme.onPrimary),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.xl),
        children: [
          Text(
            'Klik tombol di bawah ini untuk melihat variasi AppDialog.',
            style: TextStyle(fontSize: 16, color: context.uiTheme.onSurface),
          ).paddingOnly(bottom: AppSpacing.xl),

          AppButton(
            text: 'Tampilkan Dialog INFO',
            variant: AppButtonVariant.solid,
            color: context.uiTheme.primary,
            isMax: true,
            onPressed: () {
              AppDialog.show(
                context,
                title: 'Informasi Penting',
                description: 'Aplikasi Anda sudah di-update ke versi terbaru.',
                variant: AppDialogVariant.info,
                textLeft: 'Kembali', // Sifatnya optional
                textRight: 'Mengerti',
                onRight: () => Navigator.of(context).pop(),
              );
            },
          ).paddingOnly(bottom: AppSpacing.md),

          AppButton(
            text: 'Tampilkan Dialog SUCCESS',
            variant: AppButtonVariant.solid,
            color: context.uiTheme.success,
            isMax: true,
            onPressed: () {
              AppDialog.show(
                context,
                title: 'Transaksi Berhasil',
                description: 'Pembayaran sebesar Rp 150.000 telah diterima.',
                variant: AppDialogVariant.success,
                textLeft: 'Kembali',
                textRight: 'Lihat Resi',
                onRight: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sedang memuat resi...')),
                  );
                },
              );
            },
          ).paddingOnly(bottom: AppSpacing.md),

          AppButton(
            text: 'Tampilkan Dialog WARNING',
            variant: AppButtonVariant.solid,
            color: context.uiTheme.warning,
            isMax: true,
            onPressed: () {
              AppDialog.show(
                context,
                title: 'Peringatan',
                description:
                    'Koneksi internet Anda tidak stabil. Beberapa fitur mungkin tidak berjalan lancar.',
                variant: AppDialogVariant.warning,
                textLeft: 'Batal', // Sifatnya optional
                textRight: 'Lanjutkan',
                onRight: () => Navigator.of(context).pop(),
              );
            },
          ).paddingOnly(bottom: AppSpacing.md),

          AppButton(
            text: 'Tampilkan Dialog ERROR',
            variant: AppButtonVariant.solid,
            color: context.uiTheme.danger,
            isMax: true,
            onPressed: () {
              AppDialog.show(
                context,
                title: 'Gagal Memuat Data',
                description:
                    'Server sedang mengalami gangguan, silakan coba beberapa saat lagi.',
                variant: AppDialogVariant.error,
                textLeft: 'Batal',
                textRight: 'Coba Lagi',
                onRight: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ).paddingOnly(bottom: AppSpacing.xl),

          Text(
            'Dialog dengan Custom Content',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ).paddingOnly(bottom: AppSpacing.sm),

          AppButton(
            text: 'Custom Content Dialog',
            variant: AppButtonVariant.outline,
            isMax: true,
            onPressed: () {
              AppDialog.show(
                context,
                title: 'Rate Aplikasi',
                description: 'Bagaimana pengalaman Anda sejauh ini?',
                variant: AppDialogVariant.info,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star_border,
                      size: 36,
                      color: Colors.amber,
                    ),
                  ),
                ),
                textLeft: 'Nanti',
                textRight: 'Kirim',
                onRight: () => Navigator.of(context).pop(),
              );
            },
          ).paddingOnly(bottom: AppSpacing.md),

          AppButton(
            text: 'Dialog dengan Image URL',
            variant: AppButtonVariant.outline,
            isMax: true,
            onPressed: () {
              AppDialog.show(
                context,
                title: 'Promo Spesial!',
                description:
                    'Dapatkan diskon 50% untuk transaksi pertama Anda.',
                imageUrl:
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                imageHeight: 180,
                imageFit: BoxFit.cover,
                textRight: 'Klaim Sekarang',
                onRight: () => Navigator.of(context).pop(),
              );
            },
          ).paddingOnly(bottom: AppSpacing.xl),

          Text(
            'Interactive Image Viewer',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ).paddingOnly(bottom: AppSpacing.sm),

          AppButton(
            text: 'Buka Fullscreen Image Viewer',
            variant: AppButtonVariant.solid,
            color: context.uiTheme.primary,
            isMax: true,
            icon: Icons.fullscreen,
            onPressed: () {
              AppImageViewerDialog.showOnline(
                context,
                imageUrl:
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              );
            },
          ),
        ],
      ),
    );
  }
}
