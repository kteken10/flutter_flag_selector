import 'dart:async';
import 'package:flutter/material.dart';
import '../../flutter_flag_selector.dart';
import '../models/country_modell.dart';
import 'search_input.dart';

class CountryPickerStyle {
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final double? modalHeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? titlePadding;
  final Color? dividerColor;
  final double? dividerThickness;

  // Search container styling
  final Color? searchContainerColor;
  final BorderRadius? searchContainerBorderRadius;
  final BoxBorder? searchContainerBorder;
  final List<BoxShadow>? searchContainerShadow;
  final EdgeInsetsGeometry? searchContainerMargin;
  final EdgeInsetsGeometry? searchContainerPadding;
  final EdgeInsetsGeometry? searchInputPadding;
  final double? searchContainerWidth;
  final double? searchContainerHeight;
  final BoxConstraints? searchContainerConstraints;

  const CountryPickerStyle({
    this.backgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.modalHeight = 0.7,
    this.padding,
    this.titlePadding,
    this.dividerColor,
    this.dividerThickness,
    this.searchContainerColor,
    this.searchContainerBorderRadius,
    this.searchContainerBorder,
    this.searchContainerShadow,
    this.searchContainerMargin,
    this.searchContainerPadding,
    this.searchInputPadding,
    this.searchContainerWidth,
    this.searchContainerHeight,
    this.searchContainerConstraints,
  });
}

class CountryPicker extends StatefulWidget {
  final List<Country> countries;
  final ValueChanged<Country> onSelected;
  final CountryPickerStyle style;
  final bool showTitle;
  final String? title;
  final EdgeInsetsGeometry? titlePadding;
  final Widget Function(BuildContext, Country)? countryItemBuilder;
  final EdgeInsetsGeometry? countryItemPadding;
  final double? countryItemHeight;
  final Color? countryItemColor;
  final Color? selectedCountryItemColor;
  final SearchInputBuilder? searchBuilder;
  final InputDecoration? searchDecoration;
  final TextStyle? searchTextStyle;
  final String? searchHintText;
  final EdgeInsetsGeometry? searchPadding;
  final bool showSearch;
  final Duration? searchDebounceDuration;
  final Country? initiallySelectedCountry;

  const CountryPicker({
    super.key,
    required this.countries,
    required this.onSelected,
    this.style = const CountryPickerStyle(),
    this.showTitle = true,
    this.title = 'Select Country',
    this.titlePadding,
    this.countryItemBuilder,
    this.countryItemPadding,
    this.countryItemHeight,
    this.countryItemColor,
    this.selectedCountryItemColor,
    this.searchBuilder,
    this.searchDecoration,
    this.searchTextStyle,
    this.searchHintText,
    this.searchPadding,
    this.showSearch = true,
    this.searchDebounceDuration,
    this.initiallySelectedCountry,
  });

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  late final ValueNotifier<String> _searchNotifier;
  late final TextEditingController _searchController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchNotifier = ValueNotifier('');
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchNotifier.dispose();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      widget.searchDebounceDuration ?? const Duration(milliseconds: 300),
      () => _searchNotifier.value = value,
    );
  }

  List<Country> _filterCountries(String searchValue) {
    if (searchValue.isEmpty) return widget.countries;
    return CountryService.search(searchValue); // Utilisation de CountryService
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * (widget.style.modalHeight ?? 0.7),
      ),
      decoration: BoxDecoration(
        color: widget.style.backgroundColor ?? Theme.of(context).canvasColor,
        borderRadius: widget.style.borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: widget.style.padding ?? const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.showTitle && widget.title != null)
            Padding(
              padding: widget.titlePadding ??
                  widget.style.titlePadding ??
                  const EdgeInsets.only(bottom: 16),
              child: Text(
                widget.title!,
                style: widget.style.titleStyle ??
                    Theme.of(context).textTheme.titleMedium,
              ),
            ),
          if (widget.showSearch)
            Padding(
              padding: widget.searchPadding ?? EdgeInsets.zero,
              child: widget.searchBuilder?.call(context, _searchController) ??
                  SearchInput(
                    controller: _searchController,
                    decoration: widget.searchDecoration,
                    textStyle: widget.searchTextStyle,
                    hintText: widget.searchHintText ?? 'Search countries...',
                    autofocus: true,
                    onChanged: _onSearchChanged,
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _searchNotifier.value = '';
                            },
                          )
                        : null,
                    containerColor: widget.style.searchContainerColor,
                    containerBorderRadius: widget.style.searchContainerBorderRadius,
                    containerBorder: widget.style.searchContainerBorder,
                    containerShadow: widget.style.searchContainerShadow,
                    margin: widget.style.searchContainerMargin,
                    padding: widget.style.searchContainerPadding,
                    inputPadding: widget.style.searchInputPadding,
                    width: widget.style.searchContainerWidth,
                    height: widget.style.searchContainerHeight,
                    constraints: widget.style.searchContainerConstraints,
                  ),
            ),
          if (widget.showSearch) const SizedBox(height: 16),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: _searchNotifier,
              builder: (context, searchValue, _) {
                final filteredCountries = _filterCountries(searchValue);
                return filteredCountries.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          final isSelected = widget.initiallySelectedCountry != null &&
                              widget.initiallySelectedCountry!.code == country.code;
                          return widget.countryItemBuilder?.call(context, country) ??
                              _buildDefaultCountryItem(
                                context,
                                country,
                                isSelected: isSelected,
                              );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 48),
          const SizedBox(height: 16),
          Text(
            'No countries found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultCountryItem(
    BuildContext context,
    Country country, {
    bool isSelected = false,
  }) {
    return Container(
      height: widget.countryItemHeight,
      color: isSelected
          ? widget.selectedCountryItemColor ?? Theme.of(context).highlightColor
          : widget.countryItemColor,
      child: ListTile(
        contentPadding: widget.countryItemPadding ?? EdgeInsets.zero,
        leading: Image.asset(
          'packages/flutter_flag_selector/assets/images/${country.code}.png',
          width: 50,
          height: 50,
          errorBuilder: (_, __, ___) => Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: const Color.fromARGB(255, 216, 214, 214)),
            ),
            child: const Icon(Icons.flag, size: 16),
          ),
        ),
        title: Text(
          '${country.dialCode} ${country.name}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: isSelected ? const Icon(Icons.check) : null,
        onTap: () {
          widget.onSelected(country);
          Navigator.pop(context);
        },
      ),
    );
  }
}