import 'package:flutter/material.dart';
import '../../models/country_model.dart';
import '../country_picker.dart';

/// Shows a popup menu-based country picker with full customization support.
///
/// This function displays a popup menu positioned relative to the widget that
/// triggered it, containing a [CountryPicker] widget with all customization options.
void showPopupMenuPicker({
  required BuildContext context,
  required Offset offset,
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
  Key? key,
}) {
  final Size screenSize = MediaQuery.of(context).size;

  // Calcule la position relative pour le popup menu
  // Le menu apparaît sous le widget qui l'a déclenché
  final double left = offset.dx;
  final double top = offset.dy;
  final double right = screenSize.width - offset.dx;
  final double bottom = screenSize.height - offset.dy;

  final double menuHeight = screenSize.height * modalHeightFactor;

  showMenu<Country>(
    context: context,
    position: RelativeRect.fromLTRB(
      left,
      top,
      right,
      bottom,
    ),
    items: [
      PopupMenuItem<Country>(
        enabled: false, // Désactive la sélection directe de cet élément
        child: SizedBox(
          width: screenSize.width * 0.9,
          height: menuHeight.clamp(200.0, screenSize.height * 0.8),
          child: CountryPicker(
            countryPickerCountryList: countries,
            countryPickerLanguageCode: languageCode,
            onCountryPickerSelected: (selectedCountry) {
              onSelected(selectedCountry);
              // CountryPicker gère déjà la fermeture avec Navigator.pop(context)
            },
            countryPickerStyle: pickerStyle ??
                CountryPickerStyle(
                  countryPickerBackgroundColor: Theme.of(context).canvasColor,
                  countryPickerBorderRadius: BorderRadius.circular(12),
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
        ),
      ),
    ],
  );
}
