import 'package:flutter/material.dart';

import '../../models/country_modell.dart';
import '../country_picker.dart';

void showDialogPicker({
  required BuildContext context,
  required List<Country> countries,
  required ValueChanged<Country> onSelected,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      
      title: const Text('Select Country'),
      content: SizedBox(
        width: double.maxFinite,
        child: CountryPicker(
          countryPickerCountryList: countries,
          onCountryPickerSelected: onSelected,

        ),
      ),
    ),
  );
}