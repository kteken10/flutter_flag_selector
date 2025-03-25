import 'package:flutter/material.dart';

import '../models/country_model.dart';


// ignore: unused_element
class _CountryPicker extends StatelessWidget {
  
  final ValueChanged<Country> onSelected;

  const _CountryPicker({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select your country',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: defaultCountries.length,
              itemBuilder: (context, index) {
                final country = defaultCountries[index];
                return ListTile(
                  leading: Image.asset(
                    'packages/flutter_flag_selector/assets/images/${country.code}.png',
                    width: 30,
                    height: 20,
                  ),
                  title: Text(country.name),
                  onTap: () {
                    onSelected(country);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}