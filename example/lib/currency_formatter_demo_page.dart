import 'package:example/widget_extension_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class CurrencyFormatterDemoPage extends StatefulWidget {
  const CurrencyFormatterDemoPage({super.key});

  @override
  State<CurrencyFormatterDemoPage> createState() =>
      _CurrencyFormatterDemoPageState();
}

class _CurrencyFormatterDemoPageState extends State<CurrencyFormatterDemoPage> {
  final TextEditingController _rupiahController = TextEditingController();
  final TextEditingController _dollarController = TextEditingController();

  @override
  void dispose() {
    _rupiahController.dispose();
    _dollarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Input Formatter',
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
            'Input Formatter Uang',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ).paddingBottom(AppSpacing.sm),
          Text(
            'Ketikkan angka di bawah ini, pemisah ribuan dan desimal akan otomatis ditambahkan!',
            style: TextStyle(color: context.uiTheme.hintColor),
          ).paddingBottom(AppSpacing.xl),

          // 1. Input Rupiah (Tanpa Desimal)
          Text(
            'Input Rupiah (Tanpa Desimal)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ).paddingBottom(AppSpacing.xs),
          TextField(
            controller: _rupiahController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                type: AppCurrencyType.rupiah,
                showSymbol: true,
              ),
            ],
            decoration: InputDecoration(
              hintText: 'Ketik nominal rupiah...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              filled: true,
              fillColor: context.uiTheme.surface,
            ),
          ).paddingBottom(AppSpacing.xl),

          // 2. Input Dollar (Dengan 2 Desimal)
          Text(
            'Input Dollar (2 Desimal Otomatis)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ).paddingBottom(AppSpacing.xs),
          TextField(
            controller: _dollarController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                type: AppCurrencyType.dollar,
                decimalDigits: 2,
                showSymbol: true,
                symbolSeparator: '',
              ),
            ],
            decoration: InputDecoration(
              hintText: 'Ketik nominal dollar...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              filled: true,
              fillColor: context.uiTheme.surface,
            ),
          ).paddingBottom(AppSpacing.xl),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.uiTheme.primary,
              foregroundColor: context.uiTheme.onPrimary,
              padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            ),
            onPressed: () {
              // Contoh mengambil nilai double aslinya (reverse parse)
              final rpVal = _rupiahController.text.toCurrencyFraction(
                AppCurrencyType.rupiah,
              );
              final dVal = _dollarController.text.toCurrencyFraction(
                AppCurrencyType.dollar,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Rupiah Value: $rpVal\nDollar Value: $dVal'),
                ),
              );
            },
            child: const Text('Ambil Nilai Asli (double)'),
          ),
        ],
      ),
    );
  }
}
