import 'package:flutter/material.dart';
import '../../models/country_model.dart';
import '../country_picker.dart';

/// Shows a draggable scrollable sheet-based country picker with full customization support.
///
/// This function displays a draggable sheet that can be resized by dragging,
/// containing a [CountryPicker] widget with all customization options.
/// The sheet starts at [initialChildSize] and can be dragged between
/// [minChildSize] and [maxChildSize].
void showDraggableSheetPicker({
  required BuildContext context,
  required List<Country> countries,
  required String languageCode,
  required ValueChanged<Country> onSelected,
  required Country? initiallySelectedCountry,
  required CountryPickerStyle? pickerStyle,
  required bool showModalTitle,
  required String? modalTitle,
  required TextStyle? modalTitleStyle,
  required EdgeInsetsGeometry? modalTitlePadding,
  required double modalHeightFactor,
  required Widget Function(BuildContext, Country)? countryItemBuilder,
  required EdgeInsetsGeometry? countryItemPadding,
  required double? countryItemHeight,
  required Color? countryItemColor,
  required Color? selectedCountryItemColor,
  required bool showSearchInput,
  required InputDecoration? searchDecoration,
  required TextStyle? searchTextStyle,
  required String? searchHintText,
  required EdgeInsetsGeometry? searchPadding,
  required Color? searchContainerColor,
  required BorderRadius? searchContainerBorderRadius,
  required BoxBorder? searchContainerBorder,
  required List<BoxShadow>? searchContainerShadow,
  required EdgeInsetsGeometry? searchContainerMargin,
  required EdgeInsetsGeometry? searchContainerPadding,
  required EdgeInsetsGeometry? searchInputPadding,
  required double? searchContainerWidth,
  required double? searchContainerHeight,
  required BoxConstraints? searchContainerConstraints,
  required bool searchEnabled,
  double minChildSize = 0.25,
  double maxChildSize = 0.9,
  double initialChildSize = 0.7,
  Key? key,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: pickerStyle?.countryPickerBackgroundColor ??
                Theme.of(context).canvasColor,
            borderRadius: pickerStyle?.countryPickerBorderRadius ??
                const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: CountryPicker(
            countryPickerCountryList: countries,
            countryPickerLanguageCode: languageCode,
            onCountryPickerSelected: (country) {
              onSelected(country);
              // CountryPicker gère déjà la fermeture avec Navigator.pop(context)
            },
            countryPickerStyle: pickerStyle ??
                CountryPickerStyle(
                  countryPickerBackgroundColor: Theme.of(context).canvasColor,
                  countryPickerBorderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  countryPickerTitleStyle: modalTitleStyle ??
                      Theme.of(context).textTheme.titleMedium,
                  countryPickerModalHeight: modalHeightFactor,
                  searchContainerBackgroundColor: searchContainerColor,
                  searchContainerBorderRadius: searchContainerBorderRadius,
                  searchContainerBorder: searchContainerBorder,
                  searchContainerShadow: searchContainerShadow,
                  searchContainerMargin: searchContainerMargin,
                  searchContainerPadding: searchContainerPadding,
                  searchInputPadding: searchInputPadding,
                  searchContainerWidth: searchContainerWidth,
                  searchContainerHeight: searchContainerHeight,
                  searchContainerConstraints: searchContainerConstraints,
                ),
            countryPickerShowTitle: showModalTitle,
            countryPickerTitle: modalTitle,
            countryPickerTitlePadding: modalTitlePadding,
            countryPickerItemBuilder: countryItemBuilder,
            countryPickerItemPadding: countryItemPadding,
            countryPickerItemHeight: countryItemHeight,
            countryPickerItemColor: countryItemColor,
            countryPickerSelectedItemColor: selectedCountryItemColor,
            searchInputDecoration: searchDecoration,
            searchTextStyle: searchTextStyle,
            searchHintText: searchHintText,
            searchInputPadding: searchPadding,
            showSearchInput: showSearchInput,
            countryPickerInitiallySelectedCountry: initiallySelectedCountry,
            countryPickerKey: key,
            searchEnabled: searchEnabled,
          ),
        );
      },
    ),
  );
}
