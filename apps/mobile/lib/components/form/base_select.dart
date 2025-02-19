import 'package:flutter/material.dart';
import 'package:mylearn/components/bottom_sheet.dart';
import 'package:mylearn/components/form/base_select_sheet.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/form/error_text.dart';
import 'package:mylearn/components/form/form_label.dart';
import 'package:mylearn/components/form/input_button.dart';

class BaseSelect<T> extends FormField<T> {
  final String label;
  final CustomController<T>? controller;
  final String? placeholder;
  final String Function(T value) renderValue;
  final Future<List<T>> Function(BuildContext context, String searchTerm)
  fetchFn;
  final Widget Function(
    BuildContext context,
    T item,
    int index,
    T? currentValue,
    void Function() onSelect,
  )
  buildItem;

  BaseSelect({
    super.key,
    required this.label,
    super.validator,
    this.controller,
    required this.renderValue,
    this.placeholder,
    required this.fetchFn,
    required this.buildItem,
  }) : super(
         initialValue: controller?.value,
         builder: (state) {
           void setActiveItem(T? item) {
             state.didChange(item);
             controller?.setValue(item);
           }

           Future<void> onPressed() {
             return showDynamicBottomSheet<void>(
               context: state.context,
               useRootNavigator: true,
               expand: true,
               isDisableContainer: true,
               builder: (BuildContext context) {
                 return BaseSelectSheet(
                   fetchFn: fetchFn,
                   initialSearchTerm: (state as _BaseSelectState<T>).searchTerm,
                   onSearch: state.setSearchTerm,
                   buildItem: (context, item, index) {
                     return buildItem(context, item, index, state.value, () {
                       setActiveItem(item);
                       Navigator.pop(context);
                     });
                   },
                 );
               },
             );
           }

           return Column(
             children: [
               FormLabel(label: label, isError: state.hasError),
               SizedBox(height: 8),
               InputButton(
                 label:
                     state.value == null
                         ? placeholder ?? "Pilih Opsi"
                         : renderValue(state.value as T),
                 isError: state.hasError,
                 onPressed: onPressed,
               ),
               if (state.hasError)
                 ErrorText(message: state.errorText ?? "Silahkan Pilih Opsi!"),
             ],
           );
         },
       );

  @override
  FormFieldState<T> createState() {
    return _BaseSelectState<T>();
  }
}

class _BaseSelectState<T> extends FormFieldState<T> {
  String searchTerm = "";

  void setSearchTerm(String term) {
    setState(() {
      searchTerm = term;
    });
  }
}
