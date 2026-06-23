import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ui_kit_example/main.dart';

void main() {
  testWidgets('ViewDemoUi smoke test loads without layout overflow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Dialog Components'), findsOneWidget);
    expect(find.text('Animated Extension'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
