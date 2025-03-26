import 'package:flutter/material.dart';
import 'models/country_model.dart';
import 'widgets/country_picker.dart';


/// Signature for building custom search input widgets
typedef SearchInputBuilder = Widget Function(BuildContext context);

/// Signature for building custom country list items
typedef CountryItemBuilder = Widget Function(BuildContext context, Country country);

/// Signature for building completely custom modal pickers
typedef ModalPickerBuilder = Widget Function(
  BuildContext context,
  List<Country> countries,
  ValueChanged<Country> onSelected,
);

/// A customizable country flag selector with modal picker.
///
/// This widget provides a compact way to select countries with flags,
/// and opens a modal picker when tapped. Every aspect of the UI can be customized.
class FlagSelector extends StatefulWidget {
  /// List of available countries to select from
  final List<Country> countries;

  /// Initially selected country (by country code)
  final String? initialCountry;

  /// Callback when country selection changes
  final ValueChanged<Country>? onCountryChanged;

  // Main selector styling
  /// Padding around the selector content
  final EdgeInsetsGeometry? padding;

  /// Decoration for the selector container
  final BoxDecoration? decoration;

  /// Space between flag, text and icon
  final double gap;

  /// Fixed width for the selector
  final double? width;

  /// Fixed height for the selector
  final double? height;

  // Flag styling
  /// Width of the flag image
  final double flagWidth;

  /// Height of the flag image
  final double flagHeight;

  /// Custom builder for flag widget
  final Widget Function(BuildContext, Country)? flagBuilder;

  // Text styling
  /// Style for the country name text
  final TextStyle? textStyle;

  /// Custom country name formatter
  final String Function(Country)? countryNameBuilder;

  // Dropdown icon
  /// Custom dropdown icon widget
  final Widget? dropdownIcon;

  /// Size of the dropdown icon
  final double iconSize;

  /// Color of the dropdown icon
  final Color? iconColor;

  // Modal customization
  /// Completely custom modal builder
  final ModalPickerBuilder? modalBuilder;

  /// Style configuration for the default modal
  final CountryPickerStyle? pickerStyle;

  /// Whether to show title in modal
  final bool showModalTitle;

  /// Title text for the modal
  final String? modalTitle;

  /// Style for the modal title
  final TextStyle? modalTitleStyle;

  /// Padding around the modal title
  final EdgeInsetsGeometry? modalTitlePadding;

  /// Height factor for the modal (0.0 to 1.0)
  final double modalHeightFactor;

  // Country list customization
  /// Custom builder for country list items
  final CountryItemBuilder? countryItemBuilder;

  /// Padding for country list items
  final EdgeInsetsGeometry? countryItemPadding;

  /// Fixed height for country list items
  final double? countryItemHeight;

  /// Background color for country items
  final Color? countryItemColor;

  /// Background color for selected country item
  final Color? selectedCountryItemColor;

  // Search customization
  /// Custom search input builder
  final SearchInputBuilder? searchBuilder;

  /// Decoration for the search input field
  final InputDecoration? searchDecoration;

  /// Text style for the search input
  final TextStyle? searchTextStyle;

  /// Hint text for the search input
  final String? searchHintText;

  /// Padding around the search input
  final EdgeInsetsGeometry? searchPadding;

  /// Whether to show search input in modal
  final bool showSearch;

  /// Creates a flag selector widget
  const FlagSelector({
    super.key,
    this.countries = defaultCountries,
    this.initialCountry,
    this.onCountryChanged,
    this.padding,
    this.decoration,
    this.gap = 8.0,
    this.width,
    this.height,
    this.flagWidth = 30,
    this.flagHeight = 20,
    this.flagBuilder,
    this.textStyle,
    this.countryNameBuilder,
    this.dropdownIcon,
    this.iconSize = 24,
    this.iconColor,
    this.modalBuilder,
    this.pickerStyle,
    this.showModalTitle = true,
    this.modalTitle = 'Select Country',
    this.modalTitleStyle,
    this.modalTitlePadding,
    this.modalHeightFactor = 0.7,
    this.countryItemBuilder,
    this.countryItemPadding,
    this.countryItemHeight,
    this.countryItemColor,
    this.selectedCountryItemColor,
    this.searchBuilder,
    this.searchDecoration,
    this.searchTextStyle,
    this.searchHintText = 'Search countries...',
    this.searchPadding,
    this.showSearch = true,
  });

  @override
  State<FlagSelector> createState() => _FlagSelectorState();
}

class _FlagSelectorState extends State<FlagSelector> {
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _findInitialCountry();
  }

  /// Finds the initial country based on initialCountry code
  Country _findInitialCountry() {
    if (widget.initialCountry != null) {
      return widget.countries.firstWhere(
        (c) => c.code == widget.initialCountry,
        orElse: () => widget.countries.first,
      );
    }
    return widget.countries.first;
  }

  /// Opens the country picker modal
  void _openCountryPicker(BuildContext context) {
    if (widget.modalBuilder != null) {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => widget.modalBuilder!(ctx, widget.countries, (country) {
          widget.onCountryChanged?.call(country);
          setState(() => _selectedCountry = country);
        }),
      );
    } else {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => CountryPicker(
          countries: widget.countries,
          onSelected: (country) {
            widget.onCountryChanged?.call(country);
            setState(() => _selectedCountry = country);
          },
          style: widget.pickerStyle ?? CountryPickerStyle(
            backgroundColor: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            titleStyle: widget.modalTitleStyle ?? Theme.of(context).textTheme.titleMedium,
            modalHeight: widget.modalHeightFactor,
            padding: const EdgeInsets.all(16),
          ),
          showTitle: widget.showModalTitle,
          title: widget.modalTitle,
          titlePadding: widget.modalTitlePadding,
          countryItemBuilder: widget.countryItemBuilder,
          countryItemPadding: widget.countryItemPadding,
          countryItemHeight: widget.countryItemHeight,
          countryItemColor: widget.countryItemColor,
          selectedCountryItemColor: widget.selectedCountryItemColor,
          searchBuilder: widget.searchBuilder,
          searchDecoration: widget.searchDecoration,
          searchTextStyle: widget.searchTextStyle,
          searchHintText: widget.searchHintText,
          searchPadding: widget.searchPadding,
          showSearch: widget.showSearch,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openCountryPicker(context),
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: widget.decoration ?? BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.flagBuilder?.call(context, _selectedCountry) ?? Image.asset(
              'packages/flutter_flag_selector/assets/images/${_selectedCountry.code}.png',
              width: widget.flagWidth,
              height: widget.flagHeight,
              errorBuilder: (_, __, ___) => SizedBox(
                width: widget.flagWidth,
                height: widget.flagHeight,
                child: const Icon(Icons.flag),
              ),
            ),
            SizedBox(width: widget.gap),
            Text(
              widget.countryNameBuilder?.call(_selectedCountry) ?? _selectedCountry.name,
              style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(width: widget.gap),
            widget.dropdownIcon ?? Icon(
              Icons.arrow_drop_down,
              size: widget.iconSize,
              color: widget.iconColor ?? Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}