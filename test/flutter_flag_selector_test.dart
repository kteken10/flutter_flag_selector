import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/src/flag_selector.dart';

import 'package:flutter_flag_selector/src/models/country_modell.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('FlagSelector displays initial country', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FlagSelector(initialCountry: 'fr'),
      ),
    );

    expect(find.text('France'), findsOneWidget);
  });

  testWidgets('Country selection works', (tester) async {
    late Country selectedCountry;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlagSelector(
            onCountryChanged: (country) => selectedCountry = country,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(FlagSelector));
    await tester.pumpAndSettle();

    await tester.tap(find.text('English'));
    await tester.pump();

    expect(selectedCountry.code, equals('en'));
  });
}