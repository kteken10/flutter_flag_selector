import 'package:flutter/material.dart';

/// A customizable search input field with built-in styling defaults
///
/// This widget provides a ready-to-use search input with optional customization
/// for all visual aspects. It includes default search icon and styling that
/// matches Material Design guidelines while allowing full customization.
class SearchInput extends StatefulWidget {
  /// Controller for the search text field
  final TextEditingController? controller;

  /// Decoration for the input field (overrides other styling parameters)
  final InputDecoration? decoration;

  /// Text style for the input text
  final TextStyle? textStyle;

  /// Hint text displayed when the input is empty
  final String hintText;

  /// Callback when the text changes
  final ValueChanged<String>? onChanged;

  /// Whether the field should autofocus when displayed
  final bool autofocus;

  /// Focus node for controlling focus programmatically
  final FocusNode? focusNode;

  /// Padding around the search field
  final EdgeInsetsGeometry? padding;

  /// Background fill color
  final Color? fillColor;

  /// Border radius for the input field
  final double? borderRadius;

  /// Widget to display before the input (defaults to search icon)
  final Widget? prefixIcon;

  /// Widget to display after the input
  final Widget? suffixIcon;

  /// Padding around the input content
  final EdgeInsetsGeometry? contentPadding;

  /// Creates a search input field
  const SearchInput({
    super.key,
    this.controller,
    this.decoration,
    this.textStyle,
    this.hintText = 'Search...',
    this.onChanged,
    this.autofocus = false,
    this.focusNode,
    this.padding,
    this.fillColor,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Only dispose the controller if we created it ourselves
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      child: TextField(
        controller: _controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
        decoration: widget.decoration ?? _defaultDecoration(context),
        onChanged: widget.onChanged,
      ),
    );
  }

  /// Creates the default input decoration with fallback to theme values
  InputDecoration _defaultDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.hintText,
      prefixIcon: widget.prefixIcon ?? const Icon(Icons.search),
      suffixIcon: widget.suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        borderSide: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
      filled: true,
      fillColor: widget.fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
      contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(
        horizontal: 16, 
        vertical: 12,
      ),
    );
  }
}