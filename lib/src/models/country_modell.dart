class Country {
  final String code;
  final String name;
  final String dialCode;
  final String iso3;
  final String currency;
  final String currencyName;
  final String emoji;
  final List<String> timezones;
  final String region;
  final Map<String, String> translations;

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

  String getName([String languageCode = 'ua']) {
    return translations[languageCode] ?? name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Country && code == other.code;

  @override
  int get hashCode => code.hashCode;

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
      'en': 'Andorra',       // English
      'ru': 'Андорра',       // Russian
      'pl': 'Andora',        // Polish
      'ua': 'Андорра',       // Ukrainian
      'cz': 'Andorra',       // Czech
      'by': 'Андора',        // Belarusian
      'pt': 'Andorra',       // Portuguese
      'es': 'Andorra',       // Spanish
      'ro': 'Andorra',       // Romanian
      'bg': 'Андора',        // Bulgarian
      'de': 'Andorra',       // German
      'fr': 'Andorre',       // French
      'nl': 'Andorra',       // Dutch
      'it': 'Andorra',       // Italian
      'cn': '安道尔',         // Chinese
      'ee': 'Andorra',       // Estonian
      'jp': 'アンドラ',       // Japanese
      'he': 'אנדורה',        // Hebrew
      'tr': 'Andorra',       // Turkish
      'ar': 'أندورا',        // Arabic
    },
  ),
  Country(
    code: 'ae',
    name: 'United Arab Emirates',
    dialCode: '+971',
    iso3: 'ARE',
    currency: 'AED',
    currencyName: 'UAE Dirham',
    emoji: '🇦🇪',
    timezones: ['UTC+04:00'],
    region: 'Asia',
    translations: {
      'en': 'United Arab Emirates',  // English
      'ru': 'Объединённые Арабские Эмираты',  // Russian
      'pl': 'Zjednoczone Emiraty Arabskie',  // Polish
      'ua': "Об'єднані Арабські Емірати",  // Ukrainian
      'cz': 'Spojené arabské emiráty',  // Czech
      'by': 'Аб\'яднаныя Арабскія Эміраты',  // Belarusian
      'pt': 'Emirados Árabes Unidos',  // Portuguese
      'es': 'Emiratos Árabes Unidos',  // Spanish
      'ro': 'Emiratele Arabe Unite',  // Romanian
      'bg': 'Обединени арабски емирства',  // Bulgarian
      'de': 'Vereinigte Arabische Emirate',  // German
      'fr': 'Émirats Arabes Unis',  // French
      'nl': 'Verenigde Arabische Emiraten',  // Dutch
      'it': 'Emirati Arabi Uniti',  // Italian
      'cn': '阿拉伯联合酋长国',  // Chinese
      'ee': 'Araabia Ühendemiraadid',  // Estonian
      'jp': 'アラブ首長国連邦',  // Japanese
      'he': 'איחוד האמירויות הערביות',  // Hebrew
      'tr': 'Birleşik Arap Emirlikleri',  // Turkish
      'ar': 'الإمارات العربية المتحدة',  // Arabic
    },
  ),
];

// Le reste de votre code CountryService reste inchangé
class CountryService {
  static final Map<String, Country> _byCode = {};
  static final Map<String, List<Country>> _byCurrency = {};
  static final Map<String, List<Country>> _byRegion = {};
  static final Map<String, List<Country>> _byTimezone = {};

  static void initialize() {
    if (_byCode.isNotEmpty) return;
    
    for (final country in defaultCountries) {
      _byCode[country.code.toLowerCase()] = country;
      _byCurrency.putIfAbsent(country.currency.toUpperCase(), () => []).add(country);
      _byRegion.putIfAbsent(country.region.toLowerCase(), () => []).add(country);
      
      for (final tz in country.timezones) {
        _byTimezone.putIfAbsent(tz.toLowerCase(), () => []).add(country);
      }
    }
  }

  static Country? byCode(String code) => _byCode[code.toLowerCase()];
  static List<Country> byCurrency(String currency) => _byCurrency[currency.toUpperCase()] ?? [];
  static List<Country> byRegion(String region) => _byRegion[region.toLowerCase()] ?? [];
  static List<Country> byTimezone(String timezone) => _byTimezone[timezone.toLowerCase()] ?? [];

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