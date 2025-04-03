
# Flutter Flag Selector

[![Pub Version](https://img.shields.io/pub/v/flutter_flag_selector)](https://pub.dev/packages/flutter_flag_selector)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A highly customizable country selector for Flutter, allowing users to easily choose a country from a comprehensive list in an elegant modal interface. Includes support for SVG flags, multilingual search, and extensive customization.

![Flutter Flag Selector Demo](https://raw.githubusercontent.com/your-username/flutter_flag_selector/main/screenshots/demo.gif)

## Features

- 🌍 **Multilingual** - Support for over 20 languages
- 🔍 **Integrated Search** - Search by country name, code, or dial code
- 🎨 **Highly Customizable** - Customize the complete appearance of the selector and modal
- 🏳️ **SVG Flags** - High-quality rendering for all flags
- 🔄 **Fluid Interface** - Intuitive user experience with smooth animations
- 📱 **Responsive Design** - Automatically adapts to different screen sizes
- 💻 **Cross-Platform** - Compatible with Web, Android, iOS, macOS, Linux, and Windows

## 🎌 Supported Languages 🎌

The Flutter Flag Selector package supports the following languages for country name translations:

| Code | Language    | Example       |
|------|-------------|---------------|
| en   | English     | Andorra       |
| ru   | Russian     | Андорра       |
| pl   | Polish      | Andora        |
| ua   | Ukrainian   | Андорра       |
| cz   | Czech       | Andorra       |
| by   | Belarusian  | Андора        |
| pt   | Portuguese  | Andorra       |
| es   | Spanish     | Andorra       |
| ro   | Romanian    | Andorra       |
| bg   | Bulgarian   | Андора        |
| de   | German      | Andorra       |
| fr   | French      | Andorre       |
| nl   | Dutch       | Andorra       |
| it   | Italian     | Andorra       |
| cn   | Chinese     | 安道尔         |
| ee   | Estonian    | Andorra       |
| jp   | Japanese    | アンドラ       |
| he   | Hebrew      | אנדורה        |
| tr   | Turkish     | Andorra       |
| ar   | Arabic      | أندورا        |

You can set the display language using the `flagSelectorLanguageCode` property:

```dart
FlagSelector(
  flagSelectorLanguageCode: 'fr',  // Display country names in French
  // other properties...
)
```


## 🎥 Demo

### BottomSheet Country Modal Option
![Basic Usage Demo](https://raw.githubusercontent.com/your-username/flutter_flag_selector/main/screenshots/basic_usage.gif)

### Dialog Country Option
![Customization Demo](https://raw.githubusercontent.com/your-username/flutter_flag_selector/main/screenshots/customization.gif)


### PopUp Country  Option
![Customization Demo](https://raw.githubusercontent.com/your-username/flutter_flag_selector/main/screenshots/customization.gif)
## Installation


Add `flutter_flag_selector` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_flag_selector: ^latest_version
```

 Then run :

```bash
flutter pub get
```

## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlagSelector(
          onFlagSelectorCountryChanged: (country) {
            print('Selected country: ${country.name}');
          },
        ),
      ),
    );
  }
}
```

## Advanced Customization

The `FlagSelector` widget offers numerous customization options divided into three main categories: the main selector, the modal, and the search.

```dart
FlagSelector(
  // Main configuration
  flagSelectorLanguageCode: 'en',
  flagSelectorInitialCountry: 'us',
  onFlagSelectorCountryChanged: (country) {
    print('Selected country: ${country.name}');
    print('Code: ${country.code}');
    print('Dial code: ${country.dialCode}');
  },
  
  // Selector customization
  flagSelectorDecoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey),
  ),
  flagSelectorTextStyle: TextStyle(
    fontSize: 16, 
    fontWeight: FontWeight.bold
  ),
  
  // Modal customization
  flagSelectorModalTitle: 'Choose a country',
  flagSelectorModalTitleStyle: TextStyle(
    fontSize: 20, 
    fontWeight: FontWeight.bold
  ),
  
  // Search customization
  flagSelectorShowSearch: true,
  flagSelectorSearchHintText: 'Search countries...',
)
```

## Flag Assets

The package includes SVG flags for all countries in the following path:

```dart
'assets/flags/${countryCode.toLowerCase()}.svg'
```

These assets are bundled with the package and accessed using:

```dart
SvgPicture.asset(
  'assets/flags/${country.code.toLowerCase()}.svg',
  package: 'flutter_flag_selector',
)
```

If you want to use custom flag images, you can provide your own implementation using the `flagSelectorFlagBuilder` property.

## Using the Country Service

The package also includes a service for working with country data:

```dart
// Initialize the service (do this at app startup)
CountryService.initialize();

// Get a country by code
Country? usa = CountryService.byCode('us');

// Search countries by currency
List<Country> euroCountries = CountryService.byCurrency('EUR');

// Search countries by region
List<Country> europeanCountries = CountryService.byRegion('Europe');

// Advanced search
List<Country> results = CountryService.advancedSearch(
  region: 'Europe',
  currency: 'EUR',
  query: 'fr'
);
```

## Customization Options

### Main Selector Properties

| Property | Type | Description | Default Value |
| --- | --- | --- | --- |
| `flagSelectorLanguageCode` | String | Language code for country names | 'es' |
| `flagSelectorCountries` | List<Country> | Available countries list | defaultCountries |
| `flagSelectorInitialCountry` | String? | Initially selected country code | null |
| `onFlagSelectorCountryChanged` | ValueChanged<Country>? | Function called when a country is selected | null |
| `flagSelectorPadding` | EdgeInsetsGeometry? | Internal padding of the selector | null |
| `flagSelectorDecoration` | BoxDecoration? | Decoration of the main container | Default decoration with border radius |
| `flagSelectorBackgroundColor` | Color? | Background color of the selector | null |
| `flagSelectorGap` | double | Space between elements | 8.0 |
| `flagSelectorWidth` | double? | Selector width | null (automatic) |
| `flagSelectorHeight` | double? | Selector height | null (automatic) |
| `flagSelectorClipBehavior` | Clip? | How to clip the selector's content | Clip.none |
| `flagSelectorConstraints` | BoxConstraints? | Size constraints for the selector | null |
| `flagSelectorForegroundDecoration` | Decoration? | Foreground decoration drawn on top of the selector | null |
| `flagSelectorTransform` | Matrix4? | Transform to apply to the selector | null |
| `flagSelectorTransformAlignment` | AlignmentGeometry? | Alignment of the transform operation | null |
| `flagSelectorMargin` | EdgeInsetsGeometry? | External margin of the selector | null |
| `flagSelectorFlagWidth` | double | Flag width | 30.0 |
| `flagSelectorFlagHeight` | double | Flag height | 20.0 |
| `flagSelectorFlagBuilder` | Widget Function(BuildContext, Country)? | Custom builder for the flag | null |
| `flagSelectorTextStyle` | TextStyle? | Text style for the country name | Theme.of(context).textTheme.bodyMedium |
| `flagSelectorCountryNameBuilder` | String Function(Country)? | Custom builder for the country name | null |
| `flagSelectorDropdownIcon` | Widget? | Custom dropdown icon | Icon(Icons.arrow_drop_down) |
| `flagSelectorIconSize` | double | Icon size | 24.0 |
| `flagSelectorIconColor` | Color? | Icon color | Theme.of(context).iconTheme.color |

### Modal Properties

| Property | Type | Description | Default Value |
| --- | --- | --- | --- |
| `flagSelectorModalBuilder` | ModalPickerBuilder? | Custom builder for the entire modal | null |
| `flagSelectorPickerStyle` | CountryPickerStyle? | Global style for the picker | Default style |
| `flagSelectorShowModalTitle` | bool | Show the modal title | true |
| `flagSelectorModalTitle` | String? | Modal title text | 'Select Country' |
| `flagSelectorModalTitleStyle` | TextStyle? | Modal title style | Theme.of(context).textTheme.titleMedium |
| `flagSelectorModalTitlePadding` | EdgeInsetsGeometry? | Padding for the modal title | null |
| `flagSelectorModalHeightFactor` | double | Modal height (as a factor of the screen) | 0.7 |
| `flagSelectorCountryItemBuilder` | CountryItemBuilder? | Custom builder for country items | null |
| `flagSelectorCountryItemPadding` | EdgeInsetsGeometry? | Padding for country items | null |
| `flagSelectorCountryItemHeight` | double? | Height of country items | null |
| `flagSelectorCountryItemColor` | Color? | Background color of country items | null |
| `flagSelectorSelectedCountryItemColor` | Color? | Background color for the selected country | Colors.blueAccent |

### Search Properties

| Property | Type | Description | Default Value |
| --- | --- | --- | --- |
| `flagSelectorSearchBuilder` | SearchInputBuilder? | Custom builder for the search input | null |
| `flagSelectorSearchDecoration` | InputDecoration? | Decoration for the search input | null |
| `flagSelectorSearchTextStyle` | TextStyle? | Style for search text | null |
| `flagSearchEnabled` | bool? | Enable/disable search | true |
| `flagSelectorSearchHintText` | String? | Hint text for search | 'Search countries...' |
| `flagSelectorSearchPadding` | EdgeInsetsGeometry? | Padding for the search input | null |
| `flagSelectorShowSearch` | bool | Show the search bar | true |
| `flagSelectorSearchContainerColor` | Color? | Background color of the search container | null |
| `flagSelectorSearchContainerBorderRadius` | BorderRadius? | Border radius of the search container | null |
| `flagSelectorSearchContainerBorder` | BoxBorder? | Border of the search container | null |
| `flagSelectorSearchContainerShadow` | List<BoxShadow>? | Shadows of the search container | null |
| `flagSelectorSearchContainerMargin` | EdgeInsetsGeometry? | Margins of the search container | null |
| `flagSelectorSearchContainerPadding` | EdgeInsetsGeometry? | Padding of the search container | null |
| `flagSelectorSearchInputPadding` | EdgeInsetsGeometry? | Padding of the search input | null |
| `flagSelectorSearchContainerWidth` | double? | Width of the search container | null |
| `flagSelectorSearchContainerHeight` | double? | Height of the search container | null |
| `flagSelectorSearchContainerConstraints` | BoxConstraints? | Constraints of the search container | null |

## Country Model

The package uses a comprehensive `Country` model with the following properties:

```dart
class Country {
  final String code;            // ISO 2-letter code (e.g., 'us')
  final String name;            // Country name (in English)
  final String dialCode;        // Phone dial code (e.g., '+1')
  final String iso3;            // ISO 3-letter code (e.g., 'USA')
  final String currency;        // Currency code (e.g., 'USD')
  final String currencyName;    // Currency name (e.g., 'US Dollar')
  final String emoji;           // Flag emoji (e.g., '🇺🇸')
  final List<String> timezones; // Timezones (e.g., ['UTC-05:00'])
  final String region;          // Region (e.g., 'Americas')
  final Map<String, String> translations; // Name translations in multiple languages
}
```

## Complete Application Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Flag Selector Demo'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select your country',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                FlagSelector(
                  flagSelectorLanguageCode: 'en',
                  flagSelectorInitialCountry: 'us',
                  onFlagSelectorCountryChanged: (country) {
                    print('Selected country: ${country.name}');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
```

This updated README.md now includes:
1. The supported languages section with a table
2. The new flag assets section explaining how flags are included in the package
3. Updated main selector properties table with all new properties from your implementation