import 'package:flutter/material.dart';
import '../../flutter_flag_selector.dart';
import 'search_input.dart';

/// Style configuration for the country picker modal
///
/// This class allows customization of the modal's appearance including
/// background color, border radius, title style, and dimensions.
class CountryPickerStyle {
  /// Background color of the modal
  final Color? backgroundColor;

  /// Border radius of the modal
  final BorderRadius? borderRadius;

  /// Text style for the modal title
  final TextStyle? titleStyle;

  /// Height factor of the modal (0.0 to 1.0 relative to screen height)
  final double? modalHeight;

  /// Padding around the modal content
  final EdgeInsetsGeometry? padding;

  /// Padding around the modal title
  final EdgeInsetsGeometry? titlePadding;

  /// Color of dividers between country items
  final Color? dividerColor;

  /// Thickness of dividers between country items
  final double? dividerThickness;

  /// Creates a style for the country picker modal
  const CountryPickerStyle({
    this.backgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.modalHeight = 0.7,
    this.padding,
    this.titlePadding,
    this.dividerColor,
    this.dividerThickness,
  });
}

/// A customizable modal country picker with search functionality
///
/// This widget displays a scrollable list of countries in a modal bottom sheet,
/// with optional search functionality. It's typically used in conjunction with
/// [FlagSelector].
class CountryPicker extends StatelessWidget {
  /// List of countries to display in the picker
  final List<Country> countries;

  /// Callback when a country is selected
  final ValueChanged<Country> onSelected;

  /// Style configuration for the picker modal
  final CountryPickerStyle style;

  /// Whether to show the title at the top of the modal
  final bool showTitle;

  /// Title text to display at the top of the modal
  final String? title;

  /// Padding around the title
  final EdgeInsetsGeometry? titlePadding;

  // Country list customization
  
  /// Builder for custom country list items
  final Widget Function(BuildContext, Country)? countryItemBuilder;

  /// Padding for each country list item
  final EdgeInsetsGeometry? countryItemPadding;

  /// Fixed height for country list items
  final double? countryItemHeight;

  /// Background color for country items
  final Color? countryItemColor;

  /// Background color for the selected country item
  final Color? selectedCountryItemColor;

  // Search customization
  
  /// Builder for custom search input widget
  final SearchInputBuilder? searchBuilder;

  /// Decoration for the default search input field
  final InputDecoration? searchDecoration;

  /// Text style for the search input
  final TextStyle? searchTextStyle;

  /// Hint text for the search input
  final String? searchHintText;

  /// Padding around the search input
  final EdgeInsetsGeometry? searchPadding;

  /// Whether to show the search input field
  final bool showSearch;

  /// Creates a country picker widget
  const CountryPicker({
    super.key,
    required this.countries,
    required this.onSelected,
    this.style = const CountryPickerStyle(),
    this.showTitle = true,
    this.title = 'Select Country',
    this.titlePadding,
    this.countryItemBuilder,
    this.countryItemPadding,
    this.countryItemHeight,
    this.countryItemColor,
    this.selectedCountryItemColor,
    this.searchBuilder,
    this.searchDecoration,
    this.searchTextStyle,
    this.searchHintText,
    this.searchPadding,
    this.showSearch = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * (style.modalHeight ?? 0.7),
      ),
      decoration: BoxDecoration(
        color: style.backgroundColor ?? Theme.of(context).canvasColor,
        borderRadius: style.borderRadius ?? const BorderRadius.vertical(
          top: Radius.circular(20)),
      ),
      padding: style.padding ?? const EdgeInsets.all(16),
      child: Column(
        children: [
          if (showTitle && title != null)
            Padding(
              padding: titlePadding ?? style.titlePadding ?? const EdgeInsets.only(bottom: 16),
              child: Text(
                title!,
                style: style.titleStyle ?? Theme.of(context).textTheme.titleMedium,
              ),
            ),
          if (showSearch)
            Padding(
              padding: searchPadding ?? EdgeInsets.zero,
              child: searchBuilder?.call(context) ?? SearchInput(
                decoration: searchDecoration,
                textStyle: searchTextStyle,
                hintText: searchHintText ?? 'Search countries...',
                autofocus: true,
              ),
            ),
          if (showSearch) const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return countryItemBuilder?.call(context, country) ?? 
                    _buildDefaultCountryItem(context, country);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the default country list item widget
  Widget _buildDefaultCountryItem(BuildContext context, Country country) {
    return Container(
      height: countryItemHeight,
      color: countryItemColor,
      child: ListTile(
        contentPadding: countryItemPadding,
        leading: Image.asset(
          'packages/flutter_flag_selector/assets/images/${country.code}.png',
          width: 30,
          height: 20,
          errorBuilder: (_, __, ___) => const Icon(Icons.flag),
        ),
        title: Text(country.name),
        onTap: () {
          onSelected(country);
          Navigator.pop(context);
        },
      ),
    );
  }
}