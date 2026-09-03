import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/components/app_year_picker.dart';
import 'package:ui_component_flutter/theme/theme.dart';

void main() {
  testWidgets('AppYearPicker button Pilih defaults to white text',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppYearPicker(
              hint: 'Pilih tahun',
              value: 2024,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    final pilihTextFinder = find.text('Pilih');
    expect(pilihTextFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(pilihTextFinder);
    expect(textWidget.style?.color, Colors.white);
  });

  testWidgets(
      'AppYearPicker button Pilih defaults to white text even when value is null',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppYearPicker(
              hint: 'Pilih tahun',
              value: null,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    final pilihTextFinder = find.text('Pilih');
    expect(pilihTextFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(pilihTextFinder);
    expect(textWidget.style?.color, Colors.white);
  });

  testWidgets('AppYearPicker respects custom confirmTextColor',
      (tester) async {
    const customColor = Colors.yellow;

    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppYearPicker(
              hint: 'Pilih tahun',
              value: 2024,
              confirmTextColor: customColor,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    final textWidget = tester.widget<Text>(find.text('Pilih'));
    expect(textWidget.style?.color, customColor);
  });

  testWidgets('AppYearPicker hides suffix icon when hideSuffixIcon is true',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppYearPicker(
              hint: 'Pilih tahun',
              value: 2024,
              hideSuffixIcon: true,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(find.byType(HeroIcon), findsNothing);
  });
}
