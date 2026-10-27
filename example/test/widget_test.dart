import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_flag_selector_example/main.dart';

void main() {
  testWidgets('the demo picks a country and shows its dial code', (tester) async {
    tester.platformDispatcher.localeTestValue = const Locale('en', 'US');
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);

    await tester.pumpWidget(const DemoApp());
    expect(find.text('United States'), findsOneWidget);

    await tester.tap(find.byType(FlagSelector));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Cameroon');
    await tester.pumpAndSettle();
    await tester.tap(find.text('+237 Cameroon'));
    await tester.pumpAndSettle();

    expect(find.text('Cameroon'), findsOneWidget);
    expect(find.text('+237'), findsOneWidget);
  });
}
