# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2026-10-28

Same code as 1.0.1, published again so that pub.dev shows the current
README, demos and example.

## [1.0.1] - 2026-10-27

### Fixed
- Draggable sheet: dragging the list now resizes the sheet. The sheet's scroll
  controller was not passed to the list, so it stayed at its initial size. A
  drag handle now shows that the sheet can be resized.
- Bottom sheet and draggable sheet stay above the keyboard while searching,
  instead of being partly hidden by it.

### Changed
- Search ranks results: exact ISO code, ISO 3 code or dial code first, then
  names starting with the query, then names containing a word starting with
  it, then the rest. Typing "ger" now shows Germany before Algeria and Niger.
- New example app (a sign-up screen) and new demo GIFs for the four display
  modes and the languages, also shown in the pub.dev gallery.
- Shorter package description, within the pub.dev limit.

## [1.0.0] - 2026-10-27

First stable release.

### Added
- `flagSelectorUseDeviceCountry` (default `true`): without a valid
  `flagSelectorInitialCountry`, the selector preselects the device's country
  (read from the platform locale) instead of the first country of the list.
- 12 missing countries and territories: Germany, Greenland, Guadeloupe,
  Hong Kong, Kosovo, Macao, Martinique, Mayotte, New Caledonia, Palestine,
  Puerto Rico and Réunion, translated in all supported languages.
- Screenshots declared for the pub.dev gallery.
- Widget tests covering initial country, device country, custom lists,
  localized names and selection.

### Fixed
- The selected country label now uses `flagSelectorLanguageCode` (it was
  always shown in English).
- `Country.getName()` now defaults to English (it defaulted to Spanish).
- Country list items no longer trigger the "ListTile background color or ink
  splashes may be invisible" assertion, and their tap effect is visible.
- Internal imports use `package:` URIs; a malformed relative import broke
  compilation in some setups (including the test suite).
- Broken demo image in the README.
- Search now stays within `flagSelectorCountries` (it searched all countries,
  so a restricted picker could list countries outside its list).
  `CountryService.search()` accepts an optional `countries` list.

### Documentation
- The README feature table now describes this package only; the comparison
  with other packages was removed.

### Changed
- Removed the unused `font_awesome_flutter` dependency.
- Reduced `topics` to 5, the maximum allowed by pub.dev.

## [0.0.2] - 2026-01-05

### Added
- Dialog mode for country picker with complete property propagation
- Popup menu mode with correct positioning and full customization support
- Draggable sheet mode with resize capability for enhanced user experience
- Advanced search functionality by country dial code
- Case-insensitive country code matching for better usability
- Validation for empty country lists to prevent runtime errors

### Improved
- Country picker performance with optimized rendering
- Flag display quality with improved SVG rendering
- User experience with automatic modal closure after country selection
- Error handling for invalid initial country codes
- Popup menu positioning accuracy
- Animation smoothness in draggable sheet mode
- Code documentation with comprehensive dartdoc comments

### Fixed
- Dialog mode property propagation issues
- Popup menu positioning problems
- Modal closure behavior across all display modes
- Linter warnings and code quality issues

### Changed
- Refactored dialog picker implementation for better maintainability
- Refactored popup menu picker implementation
- Updated README.md with comprehensive examples and SEO optimization
- Enhanced property documentation for better developer experience

## [0.0.1] - 2025-01-XX

### Added
- Initial release with basic country selector functionality
- Modal bottom sheet display mode for country selection
- Multilingual support for 20+ languages
- SVG flag rendering with high-quality graphics
- Basic customization options for selector appearance
- Country search functionality by name and code
- Support for international phone number inputs with dial codes
