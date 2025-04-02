import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/src/models/country_modell.dart';


typedef SearchInputBuilder = Widget Function(
    BuildContext context, TextEditingController controller);
typedef CountryItemBuilder = Widget Function(
    BuildContext context, Country country);
typedef ModalPickerBuilder = Widget Function(
  BuildContext context,
  List<Country> countries,
  ValueChanged<Country> onSelected,
);

enum FlagSelectorOptionType {
  modalBottomSheet,
  dialog,
  popupMenu,
  draggableSheet,
}