import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/form/error_text.dart';
import 'package:mylearn/components/form/form_label.dart';
import 'package:mylearn/components/form/input_button.dart';

class DateTimePicker extends FormField<DateTime> {
  final String label;
  final CustomController<DateTime>? controller;
  final String? placeholder;

  DateTimePicker({
    super.key,
    required this.label,
    super.validator,
    this.controller,
    this.placeholder,
  }) : super(
         initialValue: controller?.value,
         builder: (state) {
           final context = state.context;
           void setActiveItem(DateTime? item) {
             state.didChange(item);
             controller?.setValue(item);
           }

           Future<void> onPressed() async {
             final DateTime? selectedDate = await showDatePicker(
               context: context,
               initialDate: state.value ?? DateTime.now(),
               firstDate: DateTime(DateTime.now().year),
               lastDate: DateTime(DateTime.now().year + 5),
             );
             if (selectedDate == null) return;

             if (!context.mounted) return;

             final TimeOfDay? selectedTime = await showTimePicker(
               context: context,
               initialTime:
                   state.value != null
                       ? TimeOfDay.fromDateTime(state.value!)
                       : TimeOfDay(hour: 0, minute: 0),
             );
             if (selectedTime == null) return;

             final finalDateTime = DateTime(
               selectedDate.year,
               selectedDate.month,
               selectedDate.day,
               selectedTime.hour,
               selectedTime.minute,
             );
             setActiveItem(finalDateTime);
           }

           return Column(
             children: [
               FormLabel(label: label, isError: state.hasError),
               SizedBox(height: 8),
               InputButton(
                 label:
                     state.value == null
                         ? placeholder ?? "Pilih Tanggal & Waktu"
                         : DateFormat.yMMMMd().add_jm().format(state.value!),
                 isError: state.hasError,
                 onPressed: onPressed,
               ),
               if (state.hasError)
                 ErrorText(
                   message:
                       state.errorText ?? "Silahkan Pilih Tanggal & Waktu!",
                 ),
             ],
           );
         },
       );
}
