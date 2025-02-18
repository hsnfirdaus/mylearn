import 'package:flutter/material.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/form/error_text.dart';
import 'package:mylearn/components/form/form_label.dart';

class ChoicePicker extends FormField<String> {
  final String label;
  final CustomController<String>? controller;
  final List<ChoicePickerItem> items;

  ChoicePicker({
    super.key,
    required this.label,
    required this.items,
    super.validator,
    this.controller,
  }) : super(
         initialValue: controller?.value,
         builder: (state) {
           void setActiveItem(String? item) {
             state.didChange(item);
             controller?.setValue(item);
           }

           return Column(
             children: [
               FormLabel(label: label, isError: state.hasError),
               SizedBox(height: 8),
               SizedBox(
                 width: double.infinity,
                 child: Wrap(
                   spacing: 8,
                   runSpacing: 8,
                   alignment: WrapAlignment.start,
                   children:
                       items.map((item) {
                         return ChoiceChip(
                           avatar: item.icon != null ? Icon(item.icon) : null,
                           label: Text(item.label),
                           selected: item.value == state.value,
                           onSelected: (bool selected) {
                             setActiveItem(selected ? item.value : null);
                           },
                         );
                       }).toList(),
                 ),
               ),
               if (state.hasError)
                 ErrorText(message: state.errorText ?? "Silahkan Pilih Opsi!"),
             ],
           );
         },
       );
}

class ChoicePickerItem {
  final IconData? icon;
  final String label;
  final String value;

  ChoicePickerItem({this.icon, required this.label, required this.value});
}
