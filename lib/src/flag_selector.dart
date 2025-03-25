import 'package:flutter/material.dart';
import 'models/country_model.dart';

/// A customizable flag selector widget for country selection
class FlagSelector extends StatefulWidget {
  /// Callback when country is selected
  final ValueChanged<Country>? onCountryChanged;

  /// Initial selected country code
  final String? initialCountry;

  /// List of available countries (defaults to predefined list)
  final List<Country>? countries;

  /// Style for the country name text
  final TextStyle? textStyle;

  /// Flag width (default: 30)
  final double flagWidth;

  /// Flag height (default: 20)
  final double flagHeight;

  /// Dropdown icon
  final Icon? dropdownIcon;

  /// Background color of the selector
  final Color? backgroundColor;

  /// Border radius of the selector
  final BorderRadius? borderRadius;

  const FlagSelector({
    super.key,
    this.onCountryChanged,
    this.initialCountry,
    this.countries,
    this.textStyle,
    this.flagWidth = 30,
    this.flagHeight = 20,
    this.dropdownIcon,
    this.backgroundColor,
    this.borderRadius,
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
    final availableCountries = widget.countries ?? defaultCountries;
    
    if (widget.initialCountry != null) {
      return availableCountries.firstWhere(
        (c) => c.code == widget.initialCountry,
        orElse: () => availableCountries.first,
      );
    }
    return availableCountries.first;
  }

  void _openCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountryPicker(
        countries: widget.countries ?? defaultCountries,
        onSelected: (country) {
          widget.onCountryChanged?.call(country);
          setState(() => _selectedCountry = country);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openCountryPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'packages/flutter_flag_selector/assets/images/${_selectedCountry.code}.png',
              width: widget.flagWidth,
              height: widget.flagHeight,
              errorBuilder: (_, __, ___) => SizedBox(
                width: widget.flagWidth,
                height: widget.flagHeight,
                child: const Icon(Icons.flag),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _selectedCountry.name,
              style: widget.textStyle ??
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            widget.dropdownIcon ?? const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

class _CountryPicker extends StatelessWidget {
  final List<Country> countries;
  final ValueChanged<Country> onSelected;

  const _CountryPicker({
    required this.countries,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Select Country',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return ListTile(
                  leading: Image.asset(
                    'packages/flutter_flag_selector/assets/images/${country.code}.png',
                    width: 30,
                    height: 20,
                    errorBuilder: (_, __, ___) => const Icon(Icons.flag),
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