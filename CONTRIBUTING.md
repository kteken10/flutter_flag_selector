# Contributing to Flutter Flag Selector

First off, thank you for considering contributing to Flutter Flag Selector! It's people like you that make this package better for everyone.

## Code of Conduct

This project adheres to a code of conduct that all contributors are expected to follow. Please be respectful and constructive in all interactions.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When creating a bug report, please include as many details as possible:

- **Description**: A clear and concise description of what the bug is
- **Steps to Reproduce**: Detailed steps to reproduce the behavior
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Screenshots**: If applicable, add screenshots to help explain your problem
- **Flutter Version**: Your Flutter version (`flutter --version`)
- **Package Version**: The version of `flutter_flag_selector` you're using
- **Platform**: The platform(s) affected (Android, iOS, Web, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use Case**: A clear description of the use case
- **Proposed Solution**: How you envision this feature working
- **Alternatives**: Any alternative solutions or features you've considered
- **Additional Context**: Any other context, mockups, or examples

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Make your changes** following our coding standards
3. **Add tests** for any new features or bug fixes
4. **Update documentation** (README.md, CHANGELOG.md, code comments)
5. **Run the linter** (`flutter analyze`)
6. **Run tests** (`flutter test`)
7. **Commit your changes** using our commit message format
8. **Push to your fork** and submit a pull request

## Development Setup

1. **Fork and clone** the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/flutter_flag_selector.git
   cd flutter_flag_selector
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the example app**:
   ```bash
   cd example
   flutter run
   ```

4. **Run tests**:
   ```bash
   flutter test
   ```

5. **Run the analyzer**:
   ```bash
   flutter analyze
   ```

## Coding Standards

### Dart Style Guide

- Follow the [official Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to format your code
- Maximum line length: 80 characters (soft limit, 100 hard limit)

### Code Documentation

- **All public APIs must have dartdoc comments**
- Include `@example` tags in documentation when helpful
- Use keywords naturally: "country selection", "flag display", "dial code"
- Add `@see` tags linking related methods

Example:
```dart
/// Displays a customizable country picker for Flutter applications.
///
/// Perfect for international phone number inputs, country selection forms,
/// and multi-language applications. Supports 20+ languages with SVG flags.
///
/// Example:
/// ```dart
/// FlagSelector(
///   flagSelectorLanguageCode: 'en',
///   onFlagSelectorCountryChanged: (country) {
///     print(country.name);
///   },
/// )
/// ```
///
/// See also:
/// - [Country] for country data structure
/// - [FlagSelectorMode] for display options
class FlagSelector extends StatefulWidget {
  // ...
}
```

### Testing

- Write tests for all new features
- Maintain or improve test coverage (target: >80%)
- Test on multiple platforms when possible
- Include widget tests for UI components
- Include unit tests for utility functions

### Commit Messages

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

Format: `<type>(<scope>): <description>`

Types:
- `feat`: New feature (bumps minor version)
- `fix`: Bug fix (bumps patch version)
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Test additions/changes
- `chore`: Build/tooling changes

Examples:
- ✅ `feat(search): add country search by dial code`
- ✅ `docs: improve phone number input example`
- ✅ `fix(flags): resolve SVG rendering on iOS`
- ✅ `feat(i18n): add Vietnamese language support`

❌ Avoid:
- `fix: bug`
- `update readme`
- `changes`

## Project Structure

```
flutter_flag_selector/
├── lib/
│   ├── flutter_flag_selector.dart (main export)
│   └── src/
│       ├── models/ (Country, etc.)
│       ├── widgets/ (FlagSelector, etc.)
│       └── utils/
├── example/
│   └── lib/
│       └── main.dart (examples)
├── test/
│   ├── widget_test.dart
│   └── unit_test.dart
└── README.md
```

## Adding New Features

When adding new features:

1. **Discuss first**: Open an issue to discuss the feature before implementing
2. **Keep it focused**: One feature per pull request
3. **Update documentation**: README.md, CHANGELOG.md, and code comments
4. **Add examples**: Include examples in the example app
5. **Write tests**: Ensure adequate test coverage
6. **Maintain compatibility**: Avoid breaking changes when possible

## Documentation Updates

When updating documentation:

- Keep the README.md SEO-optimized
- Update CHANGELOG.md with detailed, descriptive entries
- Use keywords naturally: "country picker", "flag selector", "phone number", "country code"
- Include code examples that are complete and runnable
- Add screenshots/GIFs when helpful

## Release Process

Releases are handled by maintainers. Before a release:

- [ ] All tests pass
- [ ] No analyzer warnings
- [ ] CHANGELOG.md updated
- [ ] Version bumped in pubspec.yaml
- [ ] Documentation reviewed
- [ ] Example app tested

## Questions?

If you have questions, feel free to:
- Open an issue with the `question` label
- Check existing issues and discussions
- Review the README.md for usage examples

Thank you for contributing to Flutter Flag Selector! 🎉

