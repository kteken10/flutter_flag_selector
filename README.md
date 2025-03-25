# Flutter Flag Selector 🚩

A beautiful country flag selector with locale management.

## Features
- 🌍 200+ countries preconfigured
- 🎨 Fully customizable UI
- 🌐 Built-in locale change callbacks
- 📱 Mobile & web support

## Installation
```yaml
dependencies:
  flutter_flag_selector: ^1.0.0
```

## Basic Usage
```dart
FlagSelector(
  onCountryChanged: (country) {
    print('Selected ${country.name}');
  },
)
```

## Screenshots
| Light Mode | Dark Mode |
|------------|-----------|
| ![Light](screenshots/light.png) | ![Dark](screenshots/dark.png) |

## License
MIT