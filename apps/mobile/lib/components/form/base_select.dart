import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/form/base_select_sheet.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/theme/theme_extension.dart';

class BaseSelect<T> extends FormField<T> {
  final String label;
  final CustomController<T>? controller;
  final String? placeholder;
  final String Function(T value) renderValue;
  final Future<List<T>> Function(String searchTerm) fetchFn;
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
           final theme = state.context.appTheme;

           void setActiveItem(T? item) {
             state.didChange(item);
             controller?.setValue(item);
           }

           return Column(
             children: [
               SizedBox(
                 width: double.infinity,
                 child: Text(
                   label,
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: state.hasError ? theme.error : theme.text,
                   ),
                 ),
               ),
               SizedBox(height: 8),
               SizedBox(
                 width: double.infinity,
                 child: FilledButton(
                   onPressed: () {
                     showModalBottomSheet<void>(
                       context: state.context,
                       showDragHandle: true,
                       isScrollControlled: true,
                       backgroundColor: theme.background,
                       builder: (BuildContext context) {
                         return BaseSelectSheet(
                           fetchFn: fetchFn,
                           initialSearchTerm:
                               (state as _BaseSelectState<T>).searchTerm,
                           onSearch: state.setSearchTerm,
                           buildItem: (context, item, index) {
                             return buildItem(
                               context,
                               item,
                               index,
                               state.value,
                               () {
                                 setActiveItem(item);
                                 Navigator.pop(context);
                               },
                             );
                           },
                         );
                       },
                     );
                   },
                   style: FilledButton.styleFrom(
                     backgroundColor: theme.background200,
                     padding: EdgeInsets.symmetric(
                       vertical: 20,
                       horizontal: 20,
                     ),
                     shape: RoundedRectangleBorder(
                       side: BorderSide(
                         color:
                             state.hasError ? theme.error : theme.background200,
                         width: 2,
                       ),
                       borderRadius: BorderRadius.circular(10),
                     ),
                     splashFactory: NoSplash.splashFactory,
                   ),
                   child: Align(
                     alignment: Alignment.centerLeft,
                     child: Row(
                       children: [
                         Expanded(
                           child: Text(
                             state.value == null
                                 ? placeholder ?? "Pilih Opsi"
                                 : renderValue(state.value as T),
                             style: TextStyle(color: theme.text),
                           ),
                         ),
                         Icon(
                           LucideIcons.chevronRight,
                           color: theme.textPlaceholder,
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
               if (state.hasError)
                 Container(
                   width: double.infinity,
                   margin: EdgeInsets.only(top: 4),
                   child: Text(
                     state.errorText ?? "Silahkan Pilih Opsi!",
                     style: TextStyle(
                       color: theme.error,
                       fontWeight: FontWeight.bold,
                       fontSize: 12,
                     ),
                   ),
                 ),
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
