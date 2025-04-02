import 'package:flutter/material.dart';
import '../../models/country_model.dart';
import '../country_picker.dart';

void showPopupMenuPicker({
  required BuildContext context,
  required Offset offset,
  required List<Country> countries,
  required ValueChanged<Country> onSelected,
}) {
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB( 0, // Positionne le menu à gauche
      0, // Position verticale
      0, // Position horizontale
     0
    
      ),
  
    items: [
      PopupMenuItem<Country>(
        enabled: false, // Désactive la sélection directe de cet élément
        child: SizedBox(
          width:   Overlay.of(context)!.context.size!.width, // Prend toute la largeur, // Définissez une largeur fixe pour le menu
          height: 400, // Définissez une hauteur fixe pour le menu
          child: CountryPicker(
            countryPickerCountryList: countries,
            onCountryPickerSelected: (selectedCountry) {
              // Navigator.pop(context); // Ferme le menu après la sélection
              onSelected(selectedCountry);
            },
          ),
        ),
      ),
    ],
  );
}