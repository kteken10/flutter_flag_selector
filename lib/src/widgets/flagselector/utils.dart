import 'package:flutter/material.dart';
import '../../models/country_model.dart';

Country findInitialCountry({
  required String? initialCountryCode,
  required List<Country> countries,
}) {
  if (initialCountryCode != null) {
    return countries.firstWhere(
      (c) => c.code == initialCountryCode,
      orElse: () => countries.first,
    );
  }
  return countries.first;
}

void showPopupMenuPicker({
  required BuildContext context,
  required Offset offset,
  required List<Country> countries,
  required ValueChanged<Country> onSelected,
}) {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  showMenu<Country>(
    context: context,
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy,
      overlay.size.width - offset.dx,
      overlay.size.height - offset.dy,
    ),
    items: countries
        .map(
          (country) => PopupMenuItem<Country>(
            value: country,
            child: Text(country.name),
          ),
        )
        .toList(),
  ).then((selectedCountry) {
    if (selectedCountry != null) {
      onSelected(selectedCountry);
    }
  });
}
