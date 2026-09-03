import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/components/app_file_upload.dart';
import 'package:ui_component_flutter/theme/theme.dart';

void main() {
  testWidgets('AppFileUpload defaults to card variant', (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: AppFileUpload(
              title: 'Upload Files',
              subtitle: 'Upload your source files here',
            ),
          ),
        ),
      ),
    );

    // Card variant renders primary button 'Pick File' and 'Cancel'
    expect(find.text('Pick File'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets(
      'AppFileUpload textField variant displays hint and upload icon when no file is selected',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: AppFileUpload(
              type: AppFileUploadType.textField,
              title: 'Dokumen',
              hint: 'Pilih file...',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Dokumen'), findsOneWidget);
    expect(find.text('Pilih file...'), findsOneWidget);
    // Prefix icon documentText and suffix icon arrowUpTray
    expect(find.byType(HeroIcon), findsNWidgets(2));
    // Cancel icon should not be present
    expect(find.byWidgetPredicate((w) =>
        w is HeroIcon && w.icon == HeroIcons.xMark), findsNothing);
  });

  testWidgets(
      'AppFileUpload textField variant displays file name and cancel icon when file is present',
      (tester) async {
    bool cancelTapped = false;

    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppFileUpload(
              type: AppFileUploadType.textField,
              title: 'Dokumen',
              hint: 'Pilih file...',
              localFilePath: '/storage/emulated/0/Downloads/surat_tugas.pdf',
              onCancel: () {
                cancelTapped = true;
              },
            ),
          ),
        ),
      ),
    );

    // File name is extracted and displayed
    expect(find.text('surat_tugas.pdf'), findsOneWidget);
    // Cancel icon xMark should be present
    final xMarkFinder = find.byWidgetPredicate((w) =>
        w is HeroIcon && w.icon == HeroIcons.xMark);
    expect(xMarkFinder, findsOneWidget);

    // Tap the cancel icon
    await tester.tap(xMarkFinder);
    await tester.pumpAndSettle();

    expect(cancelTapped, isTrue);
  });
}
