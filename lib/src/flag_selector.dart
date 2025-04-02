import 'package:flutter/material.dart';
import 'models/country_modell.dart';
import 'widgets/country_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Custom builder typedefs
typedef SearchInputBuilder = Widget Function(
    BuildContext context, TextEditingController controller);
typedef CountryItemBuilder = Widget Function(
    BuildContext context, Country country);
typedef ModalPickerBuilder = Widget Function(
  BuildContext context,
  List<Country> countries,
  ValueChanged<Country> onSelected,
);

class FlagSelector extends StatefulWidget {
  // ======================================================================= //
  // [1] MAIN SELECTOR PROPERTIES
  // ======================================================================= //
  /// Core functionality properties
  final String flagSelectorLanguageCode;
  final List<Country> flagSelectorCountries;
  final String? flagSelectorInitialCountry;
  final ValueChanged<Country>? onFlagSelectorCountryChanged;

  /// Main container styling
  final EdgeInsetsGeometry? flagSelectorPadding;
  final BoxDecoration? flagSelectorDecoration;
  final double flagSelectorGap;
  final double? flagSelectorWidth;
  final double? flagSelectorHeight;

  /// Flag display properties
  final double flagSelectorFlagWidth;
  final double flagSelectorFlagHeight;
  final Widget Function(BuildContext, Country)? flagSelectorFlagBuilder;

  /// Text display properties
  final TextStyle? flagSelectorTextStyle;
  final String Function(Country)? flagSelectorCountryNameBuilder;

  /// Dropdown icon properties
  final Widget? flagSelectorDropdownIcon;
  final double flagSelectorIconSize;
  final Color? flagSelectorIconColor;

  // ======================================================================= //
  // [2] MODAL PROPERTIES
  // ======================================================================= //
  /// Modal customization
  final ModalPickerBuilder? flagSelectorModalBuilder;
  final CountryPickerStyle? flagSelectorPickerStyle;

  /// Modal header properties
  final bool flagSelectorShowModalTitle;
  final String? flagSelectorModalTitle;
  final TextStyle? flagSelectorModalTitleStyle;
  final EdgeInsetsGeometry? flagSelectorModalTitlePadding;
  final double flagSelectorModalHeightFactor;

  /// Country list item properties
  final CountryItemBuilder? flagSelectorCountryItemBuilder;
  final EdgeInsetsGeometry? flagSelectorCountryItemPadding;
  final double? flagSelectorCountryItemHeight;
  final Color? flagSelectorCountryItemColor;
  final Color? flagSelectorSelectedCountryItemColor;

  // ======================================================================= //
  // [3] SEARCH PROPERTIES
  // ======================================================================= //
  /// Search input customization
  final SearchInputBuilder? flagSelectorSearchBuilder;
  final InputDecoration? flagSelectorSearchDecoration;
  final TextStyle? flagSelectorSearchTextStyle;
  final bool? flagSearchEnabled;
  final String? flagSelectorSearchHintText;
  final EdgeInsetsGeometry? flagSelectorSearchPadding;
  final bool flagSelectorShowSearch;

  /// Search container styling
  final Color? flagSelectorSearchContainerColor;
  final BorderRadius? flagSelectorSearchContainerBorderRadius;
  final BoxBorder? flagSelectorSearchContainerBorder;
  final List<BoxShadow>? flagSelectorSearchContainerShadow;
  final EdgeInsetsGeometry? flagSelectorSearchContainerMargin;
  final EdgeInsetsGeometry? flagSelectorSearchContainerPadding;
  final EdgeInsetsGeometry? flagSelectorSearchInputPadding;
  final double? flagSelectorSearchContainerWidth;
  final double? flagSelectorSearchContainerHeight;
  final BoxConstraints? flagSelectorSearchContainerConstraints;

  const FlagSelector({
    super.key,
    // [1] Main Selector Properties
    this.flagSelectorLanguageCode = 'es',
    this.flagSelectorCountries = defaultCountries,
    this.flagSelectorInitialCountry,
    this.onFlagSelectorCountryChanged,
    this.flagSelectorPadding,
    this.flagSelectorDecoration,
    this.flagSelectorGap = 8.0,
    this.flagSelectorWidth,
    this.flagSelectorHeight,
    this.flagSelectorFlagWidth = 30,
    this.flagSelectorFlagHeight = 20,
    this.flagSelectorFlagBuilder,
    this.flagSelectorTextStyle,
    this.flagSelectorCountryNameBuilder,
    this.flagSelectorDropdownIcon,
    this.flagSelectorIconSize = 24,
    this.flagSelectorIconColor,

    // [2] Modal Properties
    this.flagSelectorModalBuilder,
    this.flagSelectorPickerStyle,
    this.flagSelectorShowModalTitle = true,
    this.flagSelectorModalTitle = 'Select Country',
    this.flagSelectorModalTitleStyle,
    this.flagSelectorModalTitlePadding,
    this.flagSelectorModalHeightFactor = 0.7,
    this.flagSelectorCountryItemBuilder,
    this.flagSelectorCountryItemPadding,
    this.flagSelectorCountryItemHeight,
    this.flagSelectorCountryItemColor,
    this.flagSelectorSelectedCountryItemColor = Colors.blueAccent,

    // [3] Search Properties
    this.flagSelectorSearchBuilder,
    this.flagSelectorSearchDecoration,
    this.flagSelectorSearchTextStyle,
    this.flagSelectorSearchHintText = 'Search countries...',
    this.flagSelectorSearchPadding,
    this.flagSelectorShowSearch = true,
    this.flagSelectorSearchContainerColor,
    this.flagSelectorSearchContainerBorderRadius,
    this.flagSelectorSearchContainerBorder,
    this.flagSelectorSearchContainerShadow,
    this.flagSelectorSearchContainerMargin,
    this.flagSelectorSearchContainerPadding,
    this.flagSelectorSearchInputPadding,
    this.flagSelectorSearchContainerWidth,
    this.flagSelectorSearchContainerHeight,
    this.flagSelectorSearchContainerConstraints,
    this.flagSearchEnabled,
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

   @override
  void didUpdateWidget(FlagSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.flagSelectorInitialCountry != oldWidget.flagSelectorInitialCountry ||
        widget.flagSelectorCountries != oldWidget.flagSelectorCountries) {
      _selectedCountry = _findInitialCountry();
    }
  }

   Country _findInitialCountry() {
    if (widget.flagSelectorInitialCountry != null) {
      return widget.flagSelectorCountries.firstWhere(
        (c) => c.code == widget.flagSelectorInitialCountry,
        orElse: () => widget.flagSelectorCountries.first,
      );
    }
    return widget.flagSelectorCountries.first;
  }

  void _openCountryPicker(BuildContext context) {
    if (widget.flagSelectorModalBuilder != null) {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => widget.flagSelectorModalBuilder!(
            ctx, widget.flagSelectorCountries, (country) {
          widget.onFlagSelectorCountryChanged?.call(country);
          setState(() => _selectedCountry = country);
        }),
      );
    } else {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => CountryPicker(
          countryPickerCountryList: widget.flagSelectorCountries,
          countryPickerLanguageCode: widget.flagSelectorLanguageCode,
          onCountryPickerSelected: (country) {
            widget.onFlagSelectorCountryChanged?.call(country);
            setState(() => _selectedCountry = country);
          },
          countryPickerStyle: widget.flagSelectorPickerStyle ??
              CountryPickerStyle(
                countryPickerBackgroundColor: Theme.of(context).canvasColor,
                countryPickerBorderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                countryPickerTitleStyle: widget.flagSelectorModalTitleStyle ??
                    Theme.of(context).textTheme.titleMedium,
                countryPickerModalHeight: widget.flagSelectorModalHeightFactor,
               
                searchContainerBackgroundColor:
                    widget.flagSelectorSearchContainerColor,
                searchContainerBorderRadius:
                    widget.flagSelectorSearchContainerBorderRadius,
                searchContainerBorder: widget.flagSelectorSearchContainerBorder,
                searchContainerShadow: widget.flagSelectorSearchContainerShadow,
                searchContainerMargin: widget.flagSelectorSearchContainerMargin,
                searchContainerPadding:
                    widget.flagSelectorSearchContainerPadding,
                searchInputPadding: widget.flagSelectorSearchInputPadding,
                searchContainerWidth: widget.flagSelectorSearchContainerWidth,
                searchContainerHeight: widget.flagSelectorSearchContainerHeight,
                searchContainerConstraints:
                    widget.flagSelectorSearchContainerConstraints,
              ),
          countryPickerShowTitle: widget.flagSelectorShowModalTitle,
          countryPickerTitle: widget.flagSelectorModalTitle,
          countryPickerTitlePadding: widget.flagSelectorModalTitlePadding,
          countryPickerItemBuilder: widget.flagSelectorCountryItemBuilder,
          countryPickerItemPadding: widget.flagSelectorCountryItemPadding,
          countryPickerItemHeight: widget.flagSelectorCountryItemHeight,
          countryPickerItemColor: widget.flagSelectorCountryItemColor,
          countryPickerSelectedItemColor:
              widget.flagSelectorSelectedCountryItemColor,
          searchBuilder: widget.flagSelectorSearchBuilder,
          searchInputDecoration: widget.flagSelectorSearchDecoration,
          searchTextStyle: widget.flagSelectorSearchTextStyle,
          searchHintText: widget.flagSelectorSearchHintText,
          searchInputPadding: widget.flagSelectorSearchPadding,
          showSearchInput: widget.flagSelectorShowSearch,
          searchIconColor:
              widget.flagSelectorIconColor ?? Theme.of(context).iconTheme.color,
          countryPickerInitiallySelectedCountry: _selectedCountry,
          
          onSearchEditingComplete: () => FocusScope.of(context).unfocus(),
          onSearchSubmitted: () => FocusScope.of(context).unfocus(),
          onSearchTap: () => FocusScope.of(context).unfocus(),
          searchDebounceDuration: const Duration(milliseconds: 300),
          searchTextInputAction: TextInputAction.search,
          searchInputEnabledBorder:
              widget.flagSelectorSearchDecoration?.enabledBorder,
          searchInputFocusedBorder:
              widget.flagSelectorSearchDecoration?.focusedBorder,
          searchEnabled: widget.flagSearchEnabled ?? true,
          searchFocusNode: widget.flagSelectorSearchBuilder != null
              ? FocusNode()
              : null,
        key:  widget.key,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openCountryPicker(context),
      child: Container(
        width: widget.flagSelectorWidth,
        height: widget.flagSelectorHeight,
        padding: widget.flagSelectorPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: widget.flagSelectorDecoration ??
            BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Flag display
            widget.flagSelectorFlagBuilder?.call(context, _selectedCountry) ??
                SvgPicture.asset(
                  'packages/flutter_flag_selector/assets/images/${_selectedCountry.code.toUpperCase()}.svg',
                  width: widget.flagSelectorFlagWidth,
                  height: widget.flagSelectorFlagHeight,
                  placeholderBuilder: (context) => SizedBox(
                    width: widget.flagSelectorFlagWidth,
                    height: widget.flagSelectorFlagHeight,
                    child: const Icon(Icons.flag),
                  ),
                ),
            SizedBox(width: widget.flagSelectorGap),
            
            // Country name
            Text(
              widget.flagSelectorCountryNameBuilder?.call(_selectedCountry) ??
                  _selectedCountry.getName(widget.flagSelectorLanguageCode),
              style: widget.flagSelectorTextStyle ??
                  Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(width: widget.flagSelectorGap),
            
            // Dropdown icon
            widget.flagSelectorDropdownIcon ??
                Icon(
                  Icons.arrow_drop_down,
                  size: widget.flagSelectorIconSize,
                  color: widget.flagSelectorIconColor ??
                      Theme.of(context).iconTheme.color,
                ),
          ],
        ),
      ),
    );
  }
}