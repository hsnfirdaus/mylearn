import 'package:flutter/material.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/form/error_text.dart';
import 'package:mylearn/components/form/form_label.dart';

class SwitchInput extends FormField<bool> {
  final String label;
  final CustomController<bool>? controller;

  SwitchInput({
    super.key,
    required this.label,
    super.validator,
    this.controller,
  }) : super(
         initialValue: controller?.value,
         builder: (state) {
           void setActiveItem(bool? item) {
             state.didChange(item);
             controller?.setValue(item);
           }

           return Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Expanded(
                     child: FormLabel(
                       label: label,
                       isError: state.hasError,
                       width: double.minPositive,
                     ),
                   ),
                   SizedBox(width: 4),
                   Switch(value: state.value == true, onChanged: setActiveItem),
                 ],
               ),
               if (state.hasError)
                 ErrorText(message: state.errorText ?? "Kesalahan!"),
             ],
           );
         },
       );
}
