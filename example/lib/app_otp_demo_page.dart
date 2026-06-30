import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppOtpDemoPage extends StatefulWidget {
  const AppOtpDemoPage({super.key});

  @override
  State<AppOtpDemoPage> createState() => _AppOtpDemoPageState();
}

class _AppOtpDemoPageState extends State<AppOtpDemoPage> {
  bool _isLoading = false;
  String _otpCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App OTP Form',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: context.uiTheme.onPrimary,
            fontSize: size(20),
          ),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
      ),
      backgroundColor: context.uiTheme.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            AppOtpForm(
              title: 'Verifikasi OTP',
              description:
                  'Masukkan 4 digit kode OTP yang telah dikirimkan ke nomor Anda',
              codeLength: 4,
              buttonText: 'Verifikasi',
              footerText: 'Belum menerima kode? ',
              footerActionText: 'Kirim Ulang',
              isLoading: _isLoading,
              onChanged: (value) {
                setState(() {
                  _otpCode = value;
                });
              },
              onCompleted: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('OTP Completed: $value')),
                );
              },
              onVerify: () {
                setState(() => _isLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    setState(() => _isLoading = false);
                    AppDialog.show(
                      // ignore: use_build_context_synchronously
                      context,
                      variant: AppDialogVariant.success,
                      title: 'Berhasil',
                      description:
                          'Verifikasi OTP berhasil untuk kode $_otpCode',
                    );
                  }
                });
              },
              onFooterActionTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengirim ulang OTP...')),
                );
              },
            ),
            SizedBox(height: size(24)),
            AppOtpForm(
              title: 'OTP 6 Digit',
              description: 'Contoh OTP dengan 6 digit tanpa tombol',
              codeLength: 6,
              isLoading: false,
              onCompleted: (value) {
                AppDialog.show(
                  context,
                  variant: AppDialogVariant.info,
                  title: 'Info',
                  description: 'OTP dimasukkan: $value',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
