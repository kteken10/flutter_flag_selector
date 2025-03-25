/// Represents a country with its code and name
class Country {
  final String code;
  final String name;
  final String? dialCode;  // Optionnel pour les numéros de téléphone

  const Country({
    required this.code,
    required this.name,
    this.dialCode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country && code == other.code;

  @override
  int get hashCode => code.hashCode;
}

/// Liste par défaut des pays supportés
const List<Country> defaultCountries = [
  Country(code: 'fr', name: 'France', dialCode: '+33'),
  Country(code: 'en', name: 'English', dialCode: '+1'),
  Country(code: 'es', name: 'Español', dialCode: '+34'),
  Country(code: 'de', name: 'Deutsch', dialCode: '+49'),
];