import 'package:flutter/material.dart';
import 'models/country_model.dart';
import 'widgets/country_picker.dart';

typedef SearchInputBuilder = Widget Function(BuildContext context, TextEditingController controller);
typedef CountryItemBuilder = Widget Function(BuildContext context, Country country);
typedef ModalPickerBuilder = Widget Function(
  BuildContext context,
  List<Country> countries,
  ValueChanged<Country> onSelected,
);

class FlagSelector extends StatefulWidget {
  final List<Country> countries;
  final String? initialCountry;
  final ValueChanged<Country>? onCountryChanged;
  
  // Main selector styling
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final double gap;
  final double? width;
  final double? height;
  
  // Flag styling
  final double flagWidth;
  final double flagHeight;
  final Widget Function(BuildContext, Country)? flagBuilder;
  
  // Text styling
  final TextStyle? textStyle;
  final String Function(Country)? countryNameBuilder;
  
  // Dropdown icon
  final Widget? dropdownIcon;
  final double iconSize;
  final Color? iconColor;
  
  // Modal customization
  final ModalPickerBuilder? modalBuilder;
  final CountryPickerStyle? pickerStyle;
  final bool showModalTitle;
  final String? modalTitle;
  final TextStyle? modalTitleStyle;
  final EdgeInsetsGeometry? modalTitlePadding;
  final double modalHeightFactor;
  
  // Country list customization
  final CountryItemBuilder? countryItemBuilder;
  final EdgeInsetsGeometry? countryItemPadding;
  final double? countryItemHeight;
  final Color? countryItemColor;
  final Color? selectedCountryItemColor;
  
  // Search customization
  final SearchInputBuilder? searchBuilder;
  final InputDecoration? searchDecoration;
  final TextStyle? searchTextStyle;
  final String? searchHintText;
  final EdgeInsetsGeometry? searchPadding;
  final bool showSearch;
  
  // Search container styling
  final Color? searchContainerColor;
  final BorderRadius? searchContainerBorderRadius;
  final BoxBorder? searchContainerBorder;
  final List<BoxShadow>? searchContainerShadow;
  final EdgeInsetsGeometry? searchContainerMargin;
  final EdgeInsetsGeometry? searchContainerPadding;
  final EdgeInsetsGeometry? searchInputPadding;

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
    this.searchContainerColor,
    this.searchContainerBorderRadius,
    this.searchContainerBorder,
    this.searchContainerShadow,
    this.searchContainerMargin,
    this.searchContainerPadding,
    this.searchInputPadding,
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

  Country _findInitialCountry() {
    if (widget.initialCountry != null) {
      return widget.countries.firstWhere(
        (c) => c.code == widget.initialCountry,
        orElse: () => widget.countries.first,
      );
    }
    return widget.countries.first;
  }

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
            searchContainerColor: widget.searchContainerColor,
            searchContainerBorderRadius: widget.searchContainerBorderRadius,
            searchContainerBorder: widget.searchContainerBorder,
            searchContainerShadow: widget.searchContainerShadow,
            searchContainerMargin: widget.searchContainerMargin,
            searchContainerPadding: widget.searchContainerPadding,
            searchInputPadding: widget.searchInputPadding,
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