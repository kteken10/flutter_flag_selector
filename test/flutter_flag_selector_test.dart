import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart'; // Assurez-vous que le chemin d'import est correct

void main() {
  group('FlagSelector Widget Tests', () {
    // Test 1: Vérifie que le widget s'affiche correctement avec le drapeau par défaut
    testWidgets('FlagSelector displays the default flag and country name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlagSelector(),
          ),
        ),
      );

      // Vérifie que le drapeau et le nom du pays par défaut sont affichés
      expect(find.text('France'), findsOneWidget); // Le pays par défaut est la France
      expect(find.byType(Image), findsOneWidget); // Vérifie qu'une image est affichée
    });

    // Test 2: Vérifie que le sélecteur de pays s'ouvre lorsqu'on clique sur le widget
    testWidgets('FlagSelector opens country picker when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlagSelector(),
          ),
        ),
      );

      // Clique sur le widget pour ouvrir le sélecteur de pays
      await tester.tap(find.byType(FlagSelector));
      await tester.pumpAndSettle(); // Attend que l'animation se termine

      // Vérifie que le sélecteur de pays est affiché
      expect(find.text('Sélectionnez votre pays'), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2)); // Deux pays dans la liste
    });

    // Test 3: Vérifie que la sélection d'un pays met à jour le widget
    testWidgets('FlagSelector updates when a country is selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlagSelector(),
          ),
        ),
      );

      // Ouvre le sélecteur de pays
      await tester.tap(find.byType(FlagSelector));
      await tester.pumpAndSettle();

      // Sélectionne le deuxième pays (États-Unis)
      await tester.tap(find.text('États-Unis'));
      await tester.pumpAndSettle();

      // Vérifie que le widget a été mis à jour avec le nouveau pays
      expect(find.text('États-Unis'), findsOneWidget);
      expect(find.text('France'), findsNothing); // La France ne doit plus être affichée
    });

    // Test 4: Vérifie que le sélecteur de pays se ferme après la sélection
    testWidgets('FlagSelector closes after selecting a country', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlagSelector(),
          ),
        ),
      );

      // Ouvre le sélecteur de pays
      await tester.tap(find.byType(FlagSelector));
      await tester.pumpAndSettle();

      // Sélectionne un pays
      await tester.tap(find.text('États-Unis'));
      await tester.pumpAndSettle();

      // Vérifie que le sélecteur de pays est fermé
      expect(find.text('Sélectionnez votre pays'), findsNothing);
    });
  });
}