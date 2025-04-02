import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  // Core input properties
  final TextEditingController? searchController;
  final InputDecoration? searchInputDecoration;
  final TextStyle? searchTextStyle;
  final String searchHintText;
  final ValueChanged<String>? onSearchTextChanged;
  final ValueChanged<String>? onSearchTextSubmitted;
  final VoidCallback? onSearchEditingComplete;
  final VoidCallback? onSearchTap;
  final bool searchAutofocus;
  final bool isSearchEnabled;
  final FocusNode? searchFocusNode;
  final TextInputAction? searchTextInputAction;

  // Container styling
  final EdgeInsetsGeometry? searchContainerMargin;
  final EdgeInsetsGeometry? searchContainerPadding;
  final Color? searchContainerColor;
  final BorderRadius? searchContainerBorderRadius;
  final BoxBorder? searchContainerBorder;
  final List<BoxShadow>? searchContainerShadow;
  final double? searchContainerWidth;
  final double? searchContainerHeight;
  final BoxConstraints? searchContainerConstraints;

  // Input field styling
  final EdgeInsetsGeometry? searchInputPadding;
  final Color? searchInputBackgroundColor;
  final double? searchInputBorderRadius;
  final InputBorder? searchInputEnabledBorder;
  final InputBorder? searchInputFocusedBorder;
  final Widget? searchPrefixIcon;
  final Widget? searchSuffixIcon;
  final Color? searchIconColor;
  final EdgeInsetsGeometry? searchContentPadding;

  const SearchInput({
    super.key,
    // Core input properties
    this.searchController,
    this.searchInputDecoration,
    this.searchTextStyle,
    this.searchHintText = 'Search...',
    this.onSearchTextChanged,
    this.onSearchTextSubmitted,
    this.onSearchEditingComplete,
    this.onSearchTap,
    this.searchAutofocus = false,
    this.isSearchEnabled = true,
    this.searchFocusNode,
    this.searchTextInputAction,
    
    // Container styling
    this.searchContainerMargin,
    this.searchContainerPadding,
    this.searchContainerColor,
    this.searchContainerBorderRadius,
    this.searchContainerBorder,
    this.searchContainerShadow,
    this.searchContainerWidth,
    this.searchContainerHeight,
    this.searchContainerConstraints,
    
    // Input field styling
    this.searchInputPadding,
    this.searchInputBackgroundColor,
    this.searchInputBorderRadius,
    this.searchInputEnabledBorder,
    this.searchInputFocusedBorder,
    this.searchPrefixIcon,
    this.searchSuffixIcon,
    this.searchIconColor,
    this.searchContentPadding,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.searchController ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.searchController == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.searchContainerWidth,
      height: widget.searchContainerHeight,
      constraints: widget.searchContainerConstraints,
      margin: widget.searchContainerMargin,
      padding: widget.searchInputPadding,
      decoration: BoxDecoration(
        color: widget.searchContainerColor,
        borderRadius: widget.searchContainerBorderRadius,
        border: widget.searchContainerBorder,
        boxShadow: widget.searchContainerShadow,
      ),
      child: Padding(
        padding: widget.searchContainerPadding ?? EdgeInsets.zero,
        child: TextField(
          controller: _internalController,
          focusNode: widget.searchFocusNode,
          autofocus: widget.searchAutofocus,
          enabled: widget.isSearchEnabled,
          style: widget.searchTextStyle ?? Theme.of(context).textTheme.bodyMedium,
          decoration: widget.searchInputDecoration ?? _buildDefaultSearchDecoration(context),
          onChanged: widget.onSearchTextChanged,
          onSubmitted: widget.onSearchTextSubmitted,
          onEditingComplete: widget.onSearchEditingComplete,
          onTap: widget.onSearchTap,
          textInputAction: widget.searchTextInputAction,
        ),
      ),
    );
  }

  InputDecoration _buildDefaultSearchDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.searchHintText,
      prefixIcon: widget.searchPrefixIcon ??
          Icon(Icons.search, color: widget.searchIconColor ?? Theme.of(context).iconTheme.color),
      suffixIcon: widget.searchSuffixIcon,
      border: widget.searchInputEnabledBorder ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.searchInputBorderRadius ?? 12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
      enabledBorder: widget.searchInputEnabledBorder ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.searchInputBorderRadius ?? 12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
      focusedBorder: widget.searchInputFocusedBorder ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.searchInputBorderRadius ?? 12),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
      filled: true,
      fillColor: widget.searchInputBackgroundColor ??
          Theme.of(context).inputDecorationTheme.fillColor ??
          Theme.of(context).colorScheme.surface,
      contentPadding: widget.searchContentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}