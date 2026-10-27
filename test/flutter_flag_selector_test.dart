import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child) => MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  group('Initial country', () {
    testWidgets('uses flagSelectorInitialCountry when valid', (tester) async {
      await tester.pumpWidget(_app(FlagSelector(flagSelectorInitialCountry: 'fr')));
      expect(find.text('France'), findsOneWidget);
    });

    testWidgets('is case-insensitive', (tester) async {
      await tester.pumpWidget(_app(FlagSelector(flagSelectorInitialCountry: 'FR')));
      expect(find.text('France'), findsOneWidget);
    });

    testWidgets('falls back to the device country', (tester) async {
      tester.platformDispatcher.localeTestValue = const Locale('de', 'DE');
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);

      await tester.pumpWidget(_app(FlagSelector()));
      expect(find.text('Germany'), findsOneWidget);
    });

    testWidgets('ignores an invalid code and uses the device country', (tester) async {
      tester.platformDispatcher.localeTestValue = const Locale('ja', 'JP');
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);

      await tester.pumpWidget(_app(FlagSelector(flagSelectorInitialCountry: 'zz')));
      expect(find.text('Japan'), findsOneWidget);
    });

    testWidgets('uses the first country when device detection is disabled', (tester) async {
      tester.platformDispatcher.localeTestValue = const Locale('de', 'DE');
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);

      await tester.pumpWidget(_app(FlagSelector(flagSelectorUseDeviceCountry: false)));
      expect(find.text(defaultCountries.first.name), findsOneWidget);
    });

    testWidgets('respects a custom country list', (tester) async {
      final countries = defaultCountries.where((c) => ['ca', 'mx'].contains(c.code)).toList();
      await tester.pumpWidget(_app(FlagSelector(
        flagSelectorCountries: countries,
        flagSelectorUseDeviceCountry: false,
      )));
      expect(find.text(countries.first.name), findsOneWidget);
    });
  });

  testWidgets('shows country names in the requested language', (tester) async {
    await tester.pumpWidget(_app(FlagSelector(
      flagSelectorInitialCountry: 'de',
      flagSelectorLanguageCode: 'fr',
    )));
    expect(find.text('Allemagne'), findsOneWidget);
  });

  testWidgets('selecting a country notifies the callback and updates the label', (tester) async {
    Country? selected;
    await tester.pumpWidget(_app(FlagSelector(
      flagSelectorInitialCountry: 'fr',
      onFlagSelectorCountryChanged: (country) => selected = country,
    )));

    await tester.tap(find.byType(FlagSelector));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Canada');
    await tester.pumpAndSettle();
    // Les lignes de la liste affichent « indicatif + nom ».
    await tester.tap(find.text('+1 Canada'));
    await tester.pumpAndSettle();

    expect(selected?.code, 'ca');
    expect(find.text('Canada'), findsOneWidget);
  });

  testWidgets('search stays within a custom country list', (tester) async {
    final countries = defaultCountries.where((c) => ['ca', 'mx'].contains(c.code)).toList();
    await tester.pumpWidget(_app(FlagSelector(
      flagSelectorCountries: countries,
      flagSelectorUseDeviceCountry: false,
    )));

    await tester.tap(find.byType(FlagSelector));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Fr');
    await tester.pumpAndSettle();

    expect(find.textContaining('France'), findsNothing);
  });

  testWidgets('the draggable sheet grows when its list is dragged up', (tester) async {
    await tester.pumpWidget(_app(FlagSelector(
      flagSelectorInitialCountry: 'fr',
      flagSelectorOptionType: FlagSelectorOptionType.draggableSheet,
    )));

    await tester.tap(find.byType(FlagSelector));
    await tester.pumpAndSettle();
    final before = tester.getTopLeft(find.byType(ListView)).dy;

    await tester.drag(find.byType(ListView), const Offset(0, -200));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.byType(ListView)).dy, lessThan(before));
  });

  test('CountryService.search matches name, code and dial code', () {
    expect(CountryService.search('Germany').map((c) => c.code), contains('de'));
    expect(CountryService.search('DEU').map((c) => c.code), contains('de'));
    expect(CountryService.search('+49').map((c) => c.code), contains('de'));
  });

  test('CountryService.search ranks names starting with the query first', () {
    final codes = CountryService.search('ger').map((c) => c.code).toList();
    expect(codes.first, 'de'); // Germany avant Algeria et Niger
    expect(codes, containsAll(['dz', 'ne', 'ng']));
  });

  test('CountryService.search puts an exact code or dial code first', () {
    expect(CountryService.search('fr').first.code, 'fr');
    expect(CountryService.search('33').first.code, 'fr');
  });

  test('Country.getName falls back to English for unknown languages', () {
    final france = defaultCountries.firstWhere((c) => c.code == 'fr');
    expect(france.getName('fr'), 'France');
    expect(france.getName('xx'), france.name);
  });
}
