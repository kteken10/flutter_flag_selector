import 'package:flutter/material.dart';
import '../../models/country_model.dart';
import '../country_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './types/flag_selector_types.dart';
import 'dialog_picker.dart';
import 'modal_bottom_sheet_picker.dart';
import 'popup_menu_picker.dart';

/// A highly customizable country selector widget for Flutter.
///
/// This widget allows users to select a country from a comprehensive list using
/// different modal interfaces like bottom sheets, dialogs, or popup menus.
/// It supports SVG flags, multilingual country names, and extensive customization options.
/// 
/// Example:
/// ```dart
/// FlagSelector(
///   flagSelectorLanguageCode: 'en',
///   flagSelectorInitialCountry: 'us',
///   onFlagSelectorCountryChanged: (country) {
///     print('Selected country: ${country.name}');
///   },
/// )
/// ```
class FlagSelector extends StatefulWidget {
  // ======================================================================= //
  // [1] MAIN SELECTOR PROPERTIES
  // ======================================================================= //
  /// The language code used for displaying country names.
  /// 
  /// Supported codes include 'en', 'fr', 'es', 'de', etc.
  /// Default is 'en' (English).
  final String flagSelectorLanguageCode;
  
  /// The list of countries available for selection.
  /// 
  /// By default, uses the predefined list of countries from [defaultCountries].
  final List<Country> flagSelectorCountries;
  
  /// The initial country code to be selected when the widget is first built.
  /// 
  /// This should be a valid ISO 2-letter country code (e.g., 'us', 'fr', 'jp').
  /// If not provided or invalid, the first country in the list will be selected.
  final String? flagSelectorInitialCountry;
  
  /// Callback function that is called when a country is selected.
  /// 
  /// The selected [Country] object is passed as a parameter.
  final ValueChanged<Country>? onFlagSelectorCountryChanged;
  
  /// The type of selector to show when tapped.
  /// 
  /// Options include:
  /// - [FlagSelectorOptionType.modalBottomSheet] (default)
  /// - [FlagSelectorOptionType.dialog]
  /// - [FlagSelectorOptionType.popupMenu]
  /// - [FlagSelectorOptionType.draggableSheet]
  final FlagSelectorOptionType flagSelectorOptionType;

  /// Padding around the content of the selector.
  final EdgeInsetsGeometry? flagSelectorPadding;
  
  /// Decoration for the selector container.
  /// 
  /// If not provided, a default decoration with rounded corners will be used.
  final BoxDecoration? flagSelectorDecoration;
  
  /// The spacing between elements within the selector.
  final double flagSelectorGap;
  
  /// Fixed width for the selector. If null, the width will be determined by its content.
  final double? flagSelectorWidth;
  
  /// Fixed height for the selector. If null, the height will be determined by its content.
  final double? flagSelectorHeight;
  
  /// Background color for the selector container.
  final Color? flagSelectorBackgroundColor;
  
  /// Determines how the selector's content is clipped.
  final Clip? flagSelectorClipBehavior;
  
  /// Size constraints for the selector container.
  final BoxConstraints? flagSelectorConstraints;
  
  /// Decoration to paint in front of the selector's content.
  final Decoration? flagSelectorForegroundDecoration;
  
  /// Transform matrix to apply to the selector.
  final Matrix4? flagSelectorTransform;
  
  /// Alignment of the transform operation.
  final AlignmentGeometry? flagSelectorTransformAlignment;
  
  /// Margin around the selector container.
  final EdgeInsetsGeometry? flagSelectorMargin;

  /// Width of the flag image.
  final double flagSelectorFlagWidth;
  
  /// Height of the flag image.
  final double flagSelectorFlagHeight;
  
  /// Custom builder for the flag widget.
  /// 
  /// If provided, this function will be used to build the flag widget instead of
  /// the default SVG image. The function receives the build context and the country object.
  final Widget Function(BuildContext, Country)? flagSelectorFlagBuilder;

  /// Text style for the country name.
  /// 
  /// If not provided, the default body medium style from the current theme will be used.
  final TextStyle? flagSelectorTextStyle;
  
  /// Custom builder for formatting the country name.
  /// 
  /// If provided, this function will be used to generate the displayed country name
  /// instead of using the default name property.
  final String Function(Country)? flagSelectorCountryNameBuilder;

  /// Custom widget for the dropdown indicator.
  /// 
  /// If not provided, a default arrow_drop_down icon will be used.
  final Widget? flagSelectorDropdownIcon;
  
  /// Size of the dropdown icon.
  final double flagSelectorIconSize;
  
  /// Color of the dropdown icon.
  /// 
  /// If not provided, the default icon color from the current theme will be used.
  final Color? flagSelectorIconColor;

  // ======================================================================= //
  // [2] MODAL PROPERTIES
  // ======================================================================= //
  /// Custom builder for the entire modal.
  /// 
  /// If provided, this function will be used to build the modal instead of
  /// the default implementations.
  final ModalPickerBuilder? flagSelectorModalBuilder;
  
  /// Global style for the country picker modal.
  final CountryPickerStyle? flagSelectorPickerStyle;

  /// Whether to show the title in the modal.
  final bool flagSelectorShowModalTitle;
  
  /// Text for the modal title.
  /// 
  /// Default is 'Select Country'.
  final String? flagSelectorModalTitle;
  
  /// Text style for the modal title.
  final TextStyle? flagSelectorModalTitleStyle;
  
  /// Padding around the modal title.
  final EdgeInsetsGeometry? flagSelectorModalTitlePadding;
  
  /// Height of the modal as a factor of the screen height.
  /// 
  /// Default is 0.7 (70% of screen height).
  final double flagSelectorModalHeightFactor;

  /// Custom builder for country list items.
  final CountryItemBuilder? flagSelectorCountryItemBuilder;
  
  /// Padding for country list items.
  final EdgeInsetsGeometry? flagSelectorCountryItemPadding;
  
  /// Height of each country list item.
  final double? flagSelectorCountryItemHeight;
  
  /// Background color for country list items.
  final Color? flagSelectorCountryItemColor;
  
  /// Background color for the selected country item.
  final Color? flagSelectorSelectedCountryItemColor;

  // ======================================================================= //
  // [3] SEARCH PROPERTIES
  // ======================================================================= //
  /// Custom builder for the search input.
  final SearchInputBuilder? flagSelectorSearchBuilder;
  
  /// Decoration for the search text field.
  final InputDecoration? flagSelectorSearchDecoration;
  
  /// Text style for the search input.
  final TextStyle? flagSelectorSearchTextStyle;
  
  /// Whether search functionality is enabled.
  final bool? flagSearchEnabled;
  
  /// Hint text for the search input.
  /// 
  /// Default is 'Search countries...'.
  final String? flagSelectorSearchHintText;
  
  /// Padding around the search input.
  final EdgeInsetsGeometry? flagSelectorSearchPadding;
  
  /// Whether to show the search bar in the modal.
  final bool flagSelectorShowSearch;

  /// Background color for the search container.
  final Color? flagSelectorSearchContainerColor;
  
  /// Border radius for the search container.
  final BorderRadius? flagSelectorSearchContainerBorderRadius;
  
  /// Border for the search container.
  final BoxBorder? flagSelectorSearchContainerBorder;
  
  /// Shadow for the search container.
  final List<BoxShadow>? flagSelectorSearchContainerShadow;
  
  /// Margin around the search container.
  final EdgeInsetsGeometry? flagSelectorSearchContainerMargin;
  
  /// Padding inside the search container.
  final EdgeInsetsGeometry? flagSelectorSearchContainerPadding;
  
  /// Padding inside the search input field.
  final EdgeInsetsGeometry? flagSelectorSearchInputPadding;
  
  /// Width of the search container.
  final double? flagSelectorSearchContainerWidth;
  
  /// Height of the search container.
  final double? flagSelectorSearchContainerHeight;
  
  /// Size constraints for the search container.
  final BoxConstraints? flagSelectorSearchContainerConstraints;

  /// Creates a flag selector widget with customizable appearance and behavior.
  /// 
  /// The [flagSelectorLanguageCode] parameter determines the language used for
  /// country names. The [flagSelectorInitialCountry] parameter sets the initially
  /// selected country. The [onFlagSelectorCountryChanged] callback is triggered
  /// when the user selects a new country.
  const FlagSelector({
    super.key,
    this.flagSelectorOptionType = FlagSelectorOptionType.modalBottomSheet,
    // [1] Main Selector Properties
    this.flagSelectorLanguageCode = 'en',
    this.flagSelectorCountries = defaultCountries,
    this.flagSelectorInitialCountry,
    this.onFlagSelectorCountryChanged,
    this.flagSelectorPadding,
    this.flagSelectorDecoration,
    this.flagSelectorGap = 8.0,
    this.flagSelectorWidth,
    this.flagSelectorHeight,
    this.flagSelectorBackgroundColor,
    this.flagSelectorClipBehavior,
    this.flagSelectorConstraints,
    this.flagSelectorForegroundDecoration,
    this.flagSelectorTransform,
    this.flagSelectorTransformAlignment,
    this.flagSelectorMargin,
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
    this.flagSelectorSelectedCountryItemColor,

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
          ctx,
          widget.flagSelectorCountries,
          (country) {
            widget.onFlagSelectorCountryChanged?.call(country);
            setState(() => _selectedCountry = country);
          },
        ),
      );
    } else {
      switch (widget.flagSelectorOptionType) {
       case FlagSelectorOptionType.modalBottomSheet:
  showModalBottomSheetPicker(
    context: context,
    countries: widget.flagSelectorCountries,
    languageCode: widget.flagSelectorLanguageCode,
    onSelected: (country) {
      widget.onFlagSelectorCountryChanged?.call(country);
      setState(() => _selectedCountry = country);
    },
    initiallySelectedCountry: _selectedCountry,
    pickerStyle: widget.flagSelectorPickerStyle,
    showModalTitle: widget.flagSelectorShowModalTitle,
    modalTitle: widget.flagSelectorModalTitle,
    modalTitleStyle: widget.flagSelectorModalTitleStyle,
    modalTitlePadding: widget.flagSelectorModalTitlePadding,
    modalHeightFactor: widget.flagSelectorModalHeightFactor,
    countryItemBuilder: widget.flagSelectorCountryItemBuilder,
    countryItemPadding: widget.flagSelectorCountryItemPadding,
    countryItemHeight: widget.flagSelectorCountryItemHeight,
    countryItemColor: widget.flagSelectorCountryItemColor,
    selectedCountryItemColor: widget.flagSelectorSelectedCountryItemColor,
    showSearchInput: widget.flagSelectorShowSearch,
    searchDecoration: widget.flagSelectorSearchDecoration,
    searchTextStyle: widget.flagSelectorSearchTextStyle,
    searchHintText: widget.flagSelectorSearchHintText,
    searchPadding: widget.flagSelectorSearchPadding,
    searchContainerColor: widget.flagSelectorSearchContainerColor,
    searchContainerBorderRadius: widget.flagSelectorSearchContainerBorderRadius,
    searchContainerBorder: widget.flagSelectorSearchContainerBorder,
    searchContainerShadow: widget.flagSelectorSearchContainerShadow,
    searchContainerMargin: widget.flagSelectorSearchContainerMargin,
    searchContainerPadding: widget.flagSelectorSearchContainerPadding,
    searchInputPadding: widget.flagSelectorSearchInputPadding,
    searchContainerWidth: widget.flagSelectorSearchContainerWidth,
    searchContainerHeight: widget.flagSelectorSearchContainerHeight,
    searchContainerConstraints: widget.flagSelectorSearchContainerConstraints,
    searchEnabled: widget.flagSearchEnabled ?? true,
    key: widget.key,
  );
  break;
        case FlagSelectorOptionType.dialog:
          showDialogPicker(
            context: context,
            countries: widget.flagSelectorCountries,

            onSelected: (country) {
              widget.onFlagSelectorCountryChanged?.call(country);
              setState(() => _selectedCountry = country);
            },
          );
          break;
        case FlagSelectorOptionType.popupMenu:
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset offset = renderBox.localToGlobal(Offset.zero);
          showPopupMenuPicker(
            context: context,
            offset: offset,
          
            
            countries: widget.flagSelectorCountries,
            onSelected: (country) {
              widget.onFlagSelectorCountryChanged?.call(country);
              setState(() => _selectedCountry = country);
            },
          );
          break;
        case FlagSelectorOptionType.draggableSheet:
          // Implémentez une feuille redimensionnable si nécessaire
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openCountryPicker(context),
      child: Container(
        width: widget.flagSelectorWidth,
        height: widget.flagSelectorHeight,
        padding: widget.flagSelectorPadding,
        decoration: widget.flagSelectorDecoration ??
            BoxDecoration(
              color: widget.flagSelectorBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
        clipBehavior: widget.flagSelectorClipBehavior ?? Clip.none,
        constraints: widget.flagSelectorConstraints,
        foregroundDecoration: widget.flagSelectorForegroundDecoration,
        margin: widget.flagSelectorMargin,
        transform: widget.flagSelectorTransform,
        transformAlignment: widget.flagSelectorTransformAlignment,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.flagSelectorFlagBuilder != null)
              widget.flagSelectorFlagBuilder!(context, _selectedCountry)
            else
              SvgPicture.asset(
                'packages/flutter_flag_selector/assets/images/${_selectedCountry.code.toUpperCase()}.svg',
                width: widget.flagSelectorFlagWidth,
                height: widget.flagSelectorFlagHeight,
              ),
            SizedBox(width: widget.flagSelectorGap),
            Text(
              widget.flagSelectorCountryNameBuilder?.call(_selectedCountry) ??
                  _selectedCountry.name,
              style: widget.flagSelectorTextStyle ??
                  Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(width: widget.flagSelectorGap),
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