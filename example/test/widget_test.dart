import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('example app renders home catalog', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('UI Component'), findsOneWidget);
  });
}
