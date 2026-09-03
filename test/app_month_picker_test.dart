import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/components/app_month_picker.dart';
import 'package:ui_component_flutter/theme/theme.dart';

void main() {
  testWidgets('AppMonthPicker button Pilih defaults to white text',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppMonthPicker(
              hint: 'Pilih bulan',
              value: 5,
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
      'AppMonthPicker button Pilih defaults to white text even when value is null',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppMonthPicker(
              hint: 'Pilih bulan',
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

  testWidgets('AppMonthPicker respects custom confirmTextColor',
      (tester) async {
    const customColor = Colors.yellow;

    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppMonthPicker(
              hint: 'Pilih bulan',
              value: 5,
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

  testWidgets('AppMonthPicker defaults to English (en) month names',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppMonthPicker(
              hint: 'Pilih bulan',
              value: 8,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('August'), findsOneWidget);

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    expect(find.text('August'), findsWidgets);
  });

  testWidgets('AppMonthPicker supports Indonesian (id) month names',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppMonthPicker(
              hint: 'Pilih bulan',
              value: 8,
              locale: 'id',
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('Agustus'), findsOneWidget);

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    expect(find.text('Agustus'), findsWidgets);
  });

  testWidgets('AppMonthPicker hides suffix icon when hideSuffixIcon is true',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppMonthPicker(
              hint: 'Pilih bulan',
              value: 8,
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
