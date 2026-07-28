import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

void main() {
  testWidgets('AppDialog.show without description renders title and buttons',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showAppDialog(
                        context,
                        title: 'Konfirmasi Keluar',
                        titleSize: 22,
                        variant: AppDialogVariant.warning,
                        textLeft: 'Batal',
                        textRight: 'Keluar',
                      );
                    },
                    child: const Text('Open'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Konfirmasi Keluar'), findsOneWidget);
    expect(find.text('Batal'), findsOneWidget);
    expect(find.text('Keluar'), findsOneWidget);
  });
}
