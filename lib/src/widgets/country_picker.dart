import 'dart:async';
import 'package:flutter/material.dart';
import '../../flutter_flag_selector.dart';
import '../models/country_modell.dart';
import 'search_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryPickerStyle {
  final Color? countryPickerBackgroundColor;
  final BorderRadius? countryPickerBorderRadius;
  final TextStyle? countryPickerTitleStyle;
  final double? countryPickerModalHeight;
  final EdgeInsetsGeometry? countryPickerPadding;
  final EdgeInsetsGeometry? countryPickerTitlePadding;
  final Color? countryPickerDividerColor;
  final double? countryPickerDividerThickness;

  
  final Color? searchContainerBackgroundColor;
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
    this.countryPickerBackgroundColor,
    this.countryPickerBorderRadius,
    this.countryPickerTitleStyle,
    this.countryPickerModalHeight = 0.7,
    this.countryPickerPadding,
    this.countryPickerTitlePadding,
    this.countryPickerDividerColor,
    this.countryPickerDividerThickness,
    this.searchContainerBackgroundColor,
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
  final String countryPickerLanguageCode;
  final List<Country> countryPickerCountryList;
  final ValueChanged<Country> onCountryPickerSelected;
  final CountryPickerStyle countryPickerStyle;
  final bool countryPickerShowTitle;
  final String? countryPickerTitle;
  final EdgeInsetsGeometry? countryPickerTitlePadding;
  final Widget Function(BuildContext, Country)? countryPickerItemBuilder;
  final EdgeInsetsGeometry? countryPickerItemPadding;
  final double? countryPickerItemHeight;
  final Color? countryPickerItemColor;
  final Color? countryPickerSelectedItemColor;


  // Search properties (conserve le préfixe search original)
  final SearchInputBuilder? searchBuilder;
  final InputDecoration? searchInputDecoration;
  final bool ? searchEnabled;
  final TextStyle? searchTextStyle;
  final String? searchHintText;
  final EdgeInsetsGeometry? searchInputPadding;
  final bool showSearchInput;
  final Duration? searchDebounceDuration;
  final VoidCallback? onSearchSubmitted;
  final VoidCallback? onSearchEditingComplete;
  final VoidCallback? onSearchTap;
  final TextInputAction? searchTextInputAction;
  final InputBorder? searchInputEnabledBorder;
  final InputBorder? searchInputFocusedBorder;
  final Color? searchIconColor;
  final Country? countryPickerInitiallySelectedCountry;
  final FocusNode? searchFocusNode;
  

  const CountryPicker({
    super.key,
    required this.countryPickerCountryList,
    required this.onCountryPickerSelected,
    this.countryPickerLanguageCode = 'en',
    this.searchEnabled ,

    this.searchFocusNode,
    this.countryPickerStyle = const CountryPickerStyle(),
    this.countryPickerShowTitle = true,
    this.countryPickerTitle = 'Select Country',
    this.countryPickerTitlePadding,
    this.countryPickerItemBuilder,
    this.countryPickerItemPadding,
    this.countryPickerItemHeight,
    this.countryPickerItemColor,
    this.countryPickerSelectedItemColor,
    this.searchBuilder,
    this.searchInputDecoration,
    this.searchTextStyle,
    this.searchHintText,
    this.searchInputPadding,
    this.showSearchInput = true,
    this.searchDebounceDuration,
    this.onSearchSubmitted,
    this.onSearchEditingComplete,
    this.onSearchTap,
    this.searchTextInputAction,
    this.searchInputEnabledBorder,
    this.searchInputFocusedBorder,
    this.searchIconColor,
    this.countryPickerInitiallySelectedCountry,
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
    if (searchValue.isEmpty) return widget.countryPickerCountryList;
    return CountryService.search(searchValue, languageCode: widget.countryPickerLanguageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 
            (widget.countryPickerStyle.countryPickerModalHeight ?? 0.7),
      ),
      decoration: BoxDecoration(
        color: widget.countryPickerStyle.countryPickerBackgroundColor ?? 
            Theme.of(context).canvasColor,
        borderRadius: widget.countryPickerStyle.countryPickerBorderRadius ??
            const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: widget.countryPickerStyle.countryPickerPadding ?? 
          const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.countryPickerShowTitle && widget.countryPickerTitle != null)
            Padding(
              padding: widget.countryPickerTitlePadding ??
                  widget.countryPickerStyle.countryPickerTitlePadding ??
                  const EdgeInsets.only(bottom: 16),
              child: Text(
                widget.countryPickerTitle!,
                style: widget.countryPickerStyle.countryPickerTitleStyle ??
                    Theme.of(context).textTheme.titleMedium,
              ),
            ),
          if (widget.showSearchInput)
            Padding(
              padding: widget.searchInputPadding ?? EdgeInsets.zero,
              child: widget.searchBuilder?.call(context, _searchController) ??
                  SearchInput(
                    searchController: _searchController,
                    searchInputDecoration: widget.searchInputDecoration,
                    searchTextStyle: widget.searchTextStyle,
                    searchHintText: widget.searchHintText ?? 'Search countries...',
                    searchAutofocus: widget.countryPickerStyle.searchContainerBorderRadius != null,
                    
                    onSearchTextChanged: _onSearchChanged,
                 
                    onSearchTextSubmitted: (_) => widget.onSearchSubmitted?.call(),
                    onSearchEditingComplete: widget.onSearchEditingComplete,
                    onSearchTap: widget.onSearchTap,
                    searchTextInputAction: widget.searchTextInputAction,
               
                      searchSuffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _searchNotifier.value = '';
                            },
                          )
                        : widget.searchInputDecoration?.suffixIcon,
                    searchContainerColor: widget.countryPickerStyle.searchContainerBackgroundColor,
                    searchContainerBorderRadius: widget.countryPickerStyle.searchContainerBorderRadius,
                    searchContainerBorder: widget.countryPickerStyle.searchContainerBorder,
                    searchContainerShadow: widget.countryPickerStyle.searchContainerShadow,
                    searchContainerMargin: widget.countryPickerStyle.searchContainerMargin,
                    searchContainerPadding: widget.countryPickerStyle.searchContainerPadding,
                    searchInputPadding: widget.countryPickerStyle.searchInputPadding,
                    searchContainerWidth: widget.countryPickerStyle.searchContainerWidth,
                    searchContainerHeight: widget.countryPickerStyle.searchContainerHeight,
                    searchContainerConstraints: widget.countryPickerStyle.searchContainerConstraints,
                    searchInputEnabledBorder: widget.searchInputEnabledBorder,
                    searchInputFocusedBorder: widget.searchInputFocusedBorder,
                    searchIconColor: widget.searchIconColor,
                    searchPrefixIcon: widget.searchInputDecoration?.prefixIcon ??
                        Icon(Icons.search, color: widget.searchIconColor ?? Theme.of(context).iconTheme.color),
                    isSearchEnabled: widget.searchEnabled ?? true,    
                    key: const Key('country_picker_search_input_key'),
                    searchContentPadding: widget.countryPickerStyle.searchInputPadding ??
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                 
                    searchInputBackgroundColor: widget.countryPickerStyle.searchContainerBackgroundColor ??
                        Theme.of(context).inputDecorationTheme.fillColor ??
                        Theme.of(context).colorScheme.surface,
                  searchFocusNode: widget.searchFocusNode,
                  searchInputBorderRadius: widget.countryPickerStyle.searchContainerBorderRadius?.topLeft.x ??
                        12.0,

                
                  ),
            ),
          if (widget.showSearchInput) const SizedBox(height: 16),
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
                          final isSelected = widget.countryPickerInitiallySelectedCountry != null &&
                              widget.countryPickerInitiallySelectedCountry!.code == country.code;
                          return widget.countryPickerItemBuilder?.call(context, country) ??
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
      height: widget.countryPickerItemHeight,
      color: isSelected
          ? widget.countryPickerSelectedItemColor ?? Theme.of(context).highlightColor
          : widget.countryPickerItemColor,
      child: ListTile(
        contentPadding: widget.countryPickerItemPadding ?? EdgeInsets.zero,
        leading: SvgPicture.asset(
          'packages/flutter_flag_selector/assets/images/${country.code.toUpperCase()}.svg',
          width: 30,
          height: 30,
          placeholderBuilder: (context) => Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: const Color.fromARGB(255, 216, 214, 214)),
            ),
            child: const Icon(Icons.flag, size: 16),
          ),
        ),
        title: Text(
          '${country.dialCode} ${country.getName(widget.countryPickerLanguageCode)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: isSelected ? const Icon(Icons.check) : null,
        onTap: () {
          widget.onCountryPickerSelected(country);
          Navigator.pop(context);
        },
      ),
    );
  }
}