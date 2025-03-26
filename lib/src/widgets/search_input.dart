import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final FocusNode? focusNode;
  
  // Container styling
  final EdgeInsetsGeometry? padding;
  final Color? containerColor;
  final BorderRadius? containerBorderRadius;
  final BoxBorder? containerBorder;
  final List<BoxShadow>? containerShadow;
  final EdgeInsetsGeometry? margin;
  
  // Input field styling
  final Color? fillColor;
  final double? borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? inputPadding;

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
    this.containerColor,
    this.containerBorderRadius,
    this.containerBorder,
    this.containerShadow,
    this.margin,
    this.fillColor,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.inputPadding,
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
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.inputPadding,
      decoration: BoxDecoration(
        color: widget.containerColor,
        borderRadius: widget.containerBorderRadius,
        border: widget.containerBorder,
        boxShadow: widget.containerShadow,
      ),
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: TextField(
          controller: _controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
          decoration: widget.decoration ?? _defaultDecoration(context),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  InputDecoration _defaultDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.hintText,
      prefixIcon: widget.prefixIcon ?? const Icon(Icons.search),
      suffixIcon: widget.suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      filled: true,
      fillColor: widget.fillColor ??
          Theme.of(context).inputDecorationTheme.fillColor ??
          Theme.of(context).colorScheme.surface,
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}