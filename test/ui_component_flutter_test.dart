import 'package:flutter_test/flutter_test.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

void main() {
  test('public barrel exports core symbols', () {
    expect(AppButtonVariant.solid, AppButtonVariant.solid);
    expect(AppCurrencyType.rupiah.locale, 'id_ID');
    expect(NoSpaceFormatter, isNotNull);
  });
}
