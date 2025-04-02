import 'package:flutter/material.dart';

import '../../models/country_modell.dart';


void showPopupMenuPicker({
  required BuildContext context,
  required Offset offset,
  required List<Country> countries,
  required ValueChanged<Country> onSelected,
}) {
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
    items: countries.map((country) {
      return PopupMenuItem<Country>(
        value: country,
        child: Text(country.name),
      );
    }).toList(),
  ).then((selectedCountry) {
    if (selectedCountry != null) {
      onSelected(selectedCountry);
    }
  });
}