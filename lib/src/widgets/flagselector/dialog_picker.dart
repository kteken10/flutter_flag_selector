import 'package:flutter/material.dart';
import '../../models/country_model.dart';
import '../country_picker.dart';

void showDialogPicker({
  required BuildContext context,
  required List<Country> countries,
  required ValueChanged<Country> onSelected,
}) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      insetPadding: const EdgeInsets.all(16), // Supprime les marges par défaut
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: MediaQuery.of(context).size.width, // Prend toute la largeur de l'écran
            child: CountryPicker(
              countryPickerCountryList: countries,
              onCountryPickerSelected: onSelected,
              
            ),
          );
        },
      ),
    ),
  );
}