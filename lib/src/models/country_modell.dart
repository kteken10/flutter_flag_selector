class Country {
  final String code;          // Code ISO2 (ex: "fr")
  final String name;          // Nom anglais par défaut
  final String dialCode;      // Indicatif (ex: "+33")
  final String iso3;          // Code ISO3 (ex: "FRA")
  final String currency;      // Code devise (ex: "EUR")
  final String currencyName;  // Nom complet de la devise
  final String emoji;         // Emoji drapeau
  final List<String> timezones;
  final String region;        // Continent
  final Map<String, String> translations; // Noms multilingues

  const Country({
    required this.code,
    required this.name,
    required this.dialCode,
    required this.iso3,
    required this.currency,
    required this.currencyName,
    required this.emoji,
    required this.timezones,
    required this.region,
    required this.translations,
  });

  // Getter pour nom traduit
  String getName([String languageCode = 'en']) {
    return translations[languageCode] ?? name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Country && code == other.code;

  @override
  int get hashCode => code.hashCode;

  // Conversion en Map pour le sérialisation
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'dialCode': dialCode,
      'iso3': iso3,
      'currency': currency,
      'currencyName': currencyName,
      'emoji': emoji,
      'timezones': timezones,
      'region': region,
      'translations': translations,
    };
  }
}

// Liste des pays avec traductions (exemple avec AD, AE, AF)
const List<Country> defaultCountries = [
  Country(
    code: 'ad',
    name: 'Andorra',
    dialCode: '+376',
    iso3: 'AND',
    currency: 'EUR',
    currencyName: 'Euro',
    emoji: '🇦🇩',
    timezones: ['UTC+01:00'],
    region: 'Europe',
    translations: {
      'en': 'Andorra',
      'fr': 'Andorre',
      'es': 'Andorra',
      'de': 'Andorra',
      'ar': 'أندورا'
    },
  ),

  
];

class CountryService {
  static final Map<String, Country> _byCode = {};
  static final Map<String, List<Country>> _byCurrency = {};
  static final Map<String, List<Country>> _byRegion = {};
  static final Map<String, List<Country>> _byTimezone = {};

  static void initialize() {
    if (_byCode.isNotEmpty) return;
    
    for (final country in defaultCountries) {
      // Index par code
      _byCode[country.code.toLowerCase()] = country;
      
      // Index par devise
      _byCurrency.putIfAbsent(
        country.currency.toUpperCase(), 
        () => []
      ).add(country);
      
      // Index par région
      _byRegion.putIfAbsent(
        country.region.toLowerCase(), 
        () => []
      ).add(country);
      
      // Index par fuseau horaire
      for (final tz in country.timezones) {
        _byTimezone.putIfAbsent(tz.toLowerCase(), () => []).add(country);
      }
    }
  }

  // Recherche par code ISO2 (O(1))
  static Country? byCode(String code) => _byCode[code.toLowerCase()];

  // Recherche par devise (ex: 'EUR')
  static List<Country> byCurrency(String currency) => 
      _byCurrency[currency.toUpperCase()] ?? [];

  // Recherche par région (ex: 'Europe')
  static List<Country> byRegion(String region) => 
      _byRegion[region.toLowerCase()] ?? [];

  // Recherche par fuseau horaire (ex: 'UTC+01:00')
  static List<Country> byTimezone(String timezone) => 
      _byTimezone[timezone.toLowerCase()] ?? [];

  // Recherche textuelle (nom, code, indicatif, traductions)
  static List<Country> search(String query) {
    final q = query.toLowerCase();
    return defaultCountries.where((country) =>
      country.code.toLowerCase().contains(q) ||
      country.name.toLowerCase().contains(q) ||
      country.dialCode.contains(q) ||
      country.iso3.toLowerCase().contains(q) ||
      country.translations.values.any((v) => v.toLowerCase().contains(q))
    ).toList();
  }

  // Filtres combinés
  static List<Country> advancedSearch({
    String? code,
    String? currency,
    String? region,
    String? timezone,
    String? query,
  }) {
    var results = defaultCountries;
    
    if (code != null) results = results.where((c) => c.code == code).toList();
    if (currency != null) results = results.where((c) => c.currency == currency).toList();
    if (region != null) results = results.where((c) => c.region == region).toList();
    if (timezone != null) {
      results = results.where((c) => c.timezones.contains(timezone)).toList();
    }
    if (query != null) {
      final q = query.toLowerCase();
      results = results.where((c) =>
        c.code.toLowerCase().contains(q) ||
        c.name.toLowerCase().contains(q) ||
        c.translations.values.any((v) => v.toLowerCase().contains(q))
      ).toList();
    }
    
    return results;
  }
}