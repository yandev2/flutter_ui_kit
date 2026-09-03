import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/components/app_date_picker.dart';
import 'package:ui_component_flutter/theme/theme.dart';

void main() {
  testWidgets('AppDatePicker button Pilih has white text when date is selected',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppDatePicker(
              hint: 'Pilih tanggal',
              value: DateTime(2026, 9, 9),
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PopupMenuButton<DateTime>));
    await tester.pumpAndSettle();

    final pilihTextFinder = find.text('Pilih');
    expect(pilihTextFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(pilihTextFinder);
    expect(textWidget.style?.color, Colors.white);
  });

  testWidgets(
      'AppDatePicker button Pilih uses theme onSurface when date is unselected',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppDatePicker(
              hint: 'Pilih tanggal',
              value: null,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PopupMenuButton<DateTime>));
    await tester.pumpAndSettle();

    final pilihTextFinder = find.text('Pilih');
    expect(pilihTextFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(pilihTextFinder);
    expect(textWidget.style?.color, AppTheme.defaultUIComponentThemeLight.onSurface);
  });

  testWidgets('AppDatePicker respects custom confirmTextColor and unselectedConfirmTextColor',
      (tester) async {
    const customSelectedColor = Colors.yellow;
    const customUnselectedColor = Colors.red;

    // Test with unselected
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppDatePicker(
              hint: 'Pilih tanggal',
              value: null,
              confirmTextColor: customSelectedColor,
              unselectedConfirmTextColor: customUnselectedColor,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PopupMenuButton<DateTime>));
    await tester.pumpAndSettle();

    var textWidget = tester.widget<Text>(find.text('Pilih'));
    expect(textWidget.style?.color, customUnselectedColor);

    // Tap a selectable date to select
    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();

    textWidget = tester.widget<Text>(find.text('Pilih'));
    expect(textWidget.style?.color, customSelectedColor);
  });

  testWidgets('AppDatePicker hides suffix icon when hideSuffixIcon is true',
      (tester) async {
    await tester.pumpWidget(
      AppScaleInit(
        builder: (context, child) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: AppDatePicker(
              hint: 'Pilih tanggal',
              value: null,
              hideSuffixIcon: true,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    // No suffix icon rendered
    expect(find.byType(HeroIcon), findsNothing);
  });
}
