# Flutter Flag Selector

[![Pub Version](https://img.shields.io/pub/v/flutter_flag_selector)](https://pub.dev/packages/flutter_flag_selector)
[![Pub Likes](https://img.shields.io/pub/likes/flutter_flag_selector)](https://pub.dev/packages/flutter_flag_selector)
[![Pub Popularity](https://img.shields.io/pub/popularity/flutter_flag_selector)](https://pub.dev/packages/flutter_flag_selector)
[![Pub Points](https://img.shields.io/pub/points/flutter_flag_selector)](https://pub.dev/packages/flutter_flag_selector)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A highly customizable Flutter country picker with 20+ languages, SVG flags, and multiple display modes. Perfect for phone number inputs and international forms.

![Flutter Flag Selector Demo](https://raw.githubusercontent.com/kteken10/flutter_flag_selector/main/screenshots/demo.gif)

## Why Choose Flutter Flag Selector?

Looking for the perfect **country picker** for your Flutter app? Here's why developers choose `flutter_flag_selector`:

| Feature | flutter_flag_selector | country_code_picker | country_picker | intl_phone_number_input |
|---------|----------------------|---------------------|----------------|-------------------------|
| **SVG Flags** | ✅ High-quality | ❌ PNG only | ❌ PNG only | ✅ |
| **Languages** | ✅ 20+ languages | ⚠️ Limited | ⚠️ Limited | ⚠️ Limited |
| **Display Modes** | ✅ 4 modes | ⚠️ 1-2 modes | ⚠️ 1-2 modes | ⚠️ 1 mode |
| **Customization** | ✅ 30+ properties | ⚠️ Basic | ⚠️ Basic | ⚠️ Basic |
| **Search Functionality** | ✅ Advanced | ✅ Basic | ✅ Basic | ✅ |
| **Phone Number Input** | ✅ Integrated | ✅ Integrated | ❌ | ✅ Full support |
| **Country Code Support** | ✅ Complete | ✅ Complete | ✅ Complete | ✅ Complete |
| **Cross-Platform** | ✅ All platforms | ✅ All platforms | ✅ All platforms | ✅ All platforms |
| **Active Maintenance** | ✅ Active | ⚠️ Varies | ⚠️ Varies | ✅ Active |

### Key Advantages

- 🌍 **20+ Languages**: Multi-language support for country names, perfect for international apps
- 🎨 **Highly Customizable**: 30+ properties to customize every aspect of the **flag selector**
- 🏳️ **SVG Flags**: Crisp, scalable flags that look perfect on any screen
- 🔍 **Advanced Search**: Search by country name, code, or **dial code**
- 📱 **4 Display Modes**: Choose between bottom sheet, dialog, popup menu, or draggable sheet
- 💻 **Cross-Platform**: Works seamlessly on Web, Android, iOS, macOS, Linux, and Windows
- 🚀 **Easy Integration**: Simple API for quick implementation in your Flutter app

## 🎥 Demo

| BottomSheet Country Modal Option | Dialog Country Option | PopUp Country Option | Draggable Sheet Option |
|:-------------------------------:|:--------------------:|:-------------------:|:---------------------:|
| ![Image](https://github.com/user-attachments/assets/d6009893-e961-469f-b83d-a962b1a2df6b) | ![Image](https://github.com/user-attachments/assets/2af10790-c1ac-436e-af42-e50fd2113d2b) | ![Image](https://github.com/user-attachments/assets/6795e06b-b5de-494f-aeee-d8a45539d159) | *Coming soon* |

## Installation

Add `flutter_flag_selector` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_flag_selector: ^latest_version
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Basic Country Picker

The simplest way to use the **country picker**:

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
            print('Country code: ${country.code}');
            print('Dial code: ${country.dialCode}');
          },
        ),
      ),
    );
  }
}
```

## Examples

### Example 1: Phone Number Input with Country Code

Perfect for international **phone number** inputs:

```dart
FlagSelector(
  flagSelectorLanguageCode: 'en',
  flagSelectorInitialCountry: 'us',
  flagSelectorOptionType: FlagSelectorOptionType.modalBottomSheet,
  onFlagSelectorCountryChanged: (country) {
    // Update phone number input with country dial code
    phoneNumberController.text = country.dialCode;
  },
  flagSelectorTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
)
```

### Example 2: Customized Bottom Sheet

Create a beautifully customized bottom sheet **flag selector**:

```dart
FlagSelector(
  flagSelectorOptionType: FlagSelectorOptionType.modalBottomSheet,
  flagSelectorModalTitle: 'Choose Your Country',
  flagSelectorModalTitleStyle: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  flagSelectorSelectedCountryItemColor: Colors.blue.shade100,
  flagSelectorCountryItemHeight: 60.0,
  onFlagSelectorCountryChanged: (country) {
    print('Selected: ${country.name}');
  },
)
```

### Example 3: Dialog Mode

Use a centered dialog for **country selection**:

```dart
FlagSelector(
  flagSelectorOptionType: FlagSelectorOptionType.dialog,
  flagSelectorModalTitle: 'Select Country',
  flagSelectorModalHeightFactor: 0.8,
  onFlagSelectorCountryChanged: (country) {
    Navigator.pop(context);
    // Handle country selection
  },
)
```

### Example 4: Popup Menu Mode

Compact popup menu for space-constrained layouts:

```dart
FlagSelector(
  flagSelectorOptionType: FlagSelectorOptionType.popupMenu,
  flagSelectorWidth: 200,
  flagSelectorHeight: 50,
  onFlagSelectorCountryChanged: (country) {
    print('Country: ${country.name}');
  },
)
```

### Example 5: Multi-Language Support

Display country names in different languages:

```dart
FlagSelector(
  flagSelectorLanguageCode: 'fr', // French
  onFlagSelectorCountryChanged: (country) {
    print(country.getName('fr')); // Get French name
  },
)

// Or switch dynamically
String currentLanguage = 'es'; // Spanish
FlagSelector(
  flagSelectorLanguageCode: currentLanguage,
  onFlagSelectorCountryChanged: (country) {
    print(country.getName(currentLanguage));
  },
)
```

### Example 6: Form Integration

Integrate with Flutter forms:

```dart
class CountryForm extends StatefulWidget {
  @override
  _CountryFormState createState() => _CountryFormState();
}

class _CountryFormState extends State<CountryForm> {
  Country? selectedCountry;
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          FlagSelector(
            flagSelectorInitialCountry: selectedCountry?.code,
            onFlagSelectorCountryChanged: (country) {
              setState(() {
                selectedCountry = country;
              });
            },
          ),
          if (selectedCountry != null)
            Text('Selected: ${selectedCountry!.name} (${selectedCountry!.dialCode})'),
        ],
      ),
    );
  }
}
```

### Example 7: Custom Styling

Fully customize the appearance:

```dart
FlagSelector(
  flagSelectorDecoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.blue, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(0.1),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  ),
  flagSelectorTextStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue.shade900,
  ),
  flagSelectorFlagWidth: 40,
  flagSelectorFlagHeight: 30,
  flagSelectorGap: 12,
  onFlagSelectorCountryChanged: (country) {
    // Handle selection
  },
)
```

### Example 8: Filtered Country List

Show only specific countries:

```dart
FlagSelector(
  flagSelectorCountries: [
    CountryService.byCode('us')!,
    CountryService.byCode('ca')!,
    CountryService.byCode('gb')!,
    CountryService.byCode('fr')!,
    CountryService.byCode('de')!,
  ],
  onFlagSelectorCountryChanged: (country) {
    print('Selected: ${country.name}');
  },
)
```

### Example 9: Advanced Search Configuration

Customize the search functionality:

```dart
FlagSelector(
  flagSelectorShowSearch: true,
  flagSelectorSearchHintText: 'Search by name or code...',
  flagSelectorSearchDecoration: InputDecoration(
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onFlagSelectorCountryChanged: (country) {
    // Handle selection
  },
)
```

### Example 10: Draggable Sheet Mode

Use the draggable sheet for a modern UX:

```dart
FlagSelector(
  flagSelectorOptionType: FlagSelectorOptionType.draggableSheet,
  flagSelectorModalTitle: 'Choose Country',
  onFlagSelectorCountryChanged: (country) {
    print('Selected: ${country.name}');
  },
)
```

## Use Cases

### 1. Phone Number Input Forms
Perfect for apps requiring international **phone number** input. The **country picker** automatically provides the correct **dial code** for each country.

### 2. User Registration
Allow users to select their country during registration. The **flag selector** provides an intuitive interface with visual country flags.

### 3. Shipping Address Forms
E-commerce apps can use the **country picker** in shipping address forms to help users quickly select their destination country.

### 4. Language Selection
Use the multi-language support to display country names in the user's preferred language, improving the international user experience.

### 5. Analytics and Reporting
Track user locations by country selection, useful for analytics and understanding your user base distribution.

### 6. Currency Selection
Since each country includes currency information, you can use the **country picker** to help users select their preferred currency.

### 7. Timezone Selection
Countries include timezone data, making it easy to implement timezone selection based on country choice.

## 🎌 Supported Languages

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

## 🎯 Display Modes

The package supports 4 different display modes for selecting countries:

1. **Modal Bottom Sheet** (default) - A bottom sheet that slides up from the bottom
2. **Dialog** - A centered dialog modal
3. **Popup Menu** - A popup menu positioned relative to the selector
4. **Draggable Sheet** - A resizable sheet that can be dragged up and down

You can choose the display mode using the `flagSelectorOptionType` property:

```dart
FlagSelector(
  flagSelectorOptionType: FlagSelectorOptionType.dialog, // or modalBottomSheet, popupMenu, draggableSheet
  // other properties...
)
```

## API Reference

### Main Selector Properties

| Property | Type | Description | Default Value |
| --- | --- | --- | --- |
| `flagSelectorLanguageCode` | String | Language code for country names | 'en' |
| `flagSelectorOptionType` | FlagSelectorOptionType | Display mode (modalBottomSheet, dialog, popupMenu, draggableSheet) | modalBottomSheet |
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

## Flag Assets

The package includes SVG flags for all countries. These assets are bundled with the package and accessed automatically. If you want to use custom flag images, you can provide your own implementation using the `flagSelectorFlagBuilder` property.

## Troubleshooting

### Issue: Flags not displaying

**Solution**: Ensure that `flutter_svg` is properly added to your dependencies. The flags are SVG files bundled with the package.

### Issue: Country names not in the correct language

**Solution**: Verify that you're using a supported language code. Check the [Supported Languages](#-supported-languages) section for available codes.

### Issue: Modal not closing after selection

**Solution**: This should happen automatically. If it doesn't, ensure you're using the latest version of the package. You can also manually close the modal in the `onFlagSelectorCountryChanged` callback.

### Issue: Search not working

**Solution**: Make sure `flagSelectorShowSearch` is set to `true` (default) and `flagSearchEnabled` is not set to `false`.

### Issue: Initial country not selected

**Solution**: Verify that the `flagSelectorInitialCountry` value is a valid ISO 2-letter country code (e.g., 'us', 'fr', 'jp'). The code is case-insensitive.

### Issue: Custom styling not applying

**Solution**: Ensure you're using the correct property names. All customization properties start with `flagSelector`. Check the [API Reference](#api-reference) for the complete list of properties.

### Issue: Performance issues with large country lists

**Solution**: The package is optimized for performance, but if you're using a very large custom country list, consider filtering the list to only include relevant countries.

## Contributing

Contributions are welcome! We love to see the community getting involved. Here's how you can help:

1. **Fork the repository**
2. **Create your feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes** following our code style guidelines
4. **Add tests** for new features
5. **Update documentation** (README.md, CHANGELOG.md)
6. **Commit your changes** (`git commit -m 'feat: add amazing feature'`)
7. **Push to the branch** (`git push origin feature/amazing-feature`)
8. **Open a Pull Request**

### Development Setup

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter analyze` to check for issues
4. Run `flutter test` to run tests
5. Check the example app in the `example/` folder

### Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add documentation comments for public APIs
- Write tests for new features

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Links

- [Pub.dev Package](https://pub.dev/packages/flutter_flag_selector)
- [GitHub Repository](https://github.com/kteken10/flutter_flag_selector)
- [Issue Tracker](https://github.com/kteken10/flutter_flag_selector/issues)

---

Made with ❤️ for the Flutter community
