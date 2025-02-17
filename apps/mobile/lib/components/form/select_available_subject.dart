import 'package:mylearn/components/form/base_select.dart';
import 'package:mylearn/components/tile_list_basic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectAvailableSubject extends BaseSelect<Map<String, dynamic>> {
  SelectAvailableSubject({
    super.key,
    required super.label,
    super.validator,
    super.controller,
  }) : super(
         renderValue: (value) => '[${value['code']}] ${value['name']}',
         placeholder: "Pilih Mata Kuliah",
         fetchFn: (String search) async {
           var query = Supabase.instance.client
               .from("available_subjects")
               .select("id,name,code");
           if (search.isNotEmpty) {
             var searchTerm = search
                 .replaceAll(" ", "%")
                 .replaceAll(".", "")
                 .replaceAll(",", "");
             query = query.or(
               "name.ilike.%$searchTerm%.code.ilike.%$searchTerm%",
             );
           }
           return query.limit(20).order('code', ascending: true);
         },
         buildItem: (context, item, index, currentValue, onSelect) {
           return TileListBasic(
             onTap: onSelect,
             selected: item['id'] == currentValue?['id'],
             title: item['name'],
             subtitle: item['code'],
           );
         },
       );
}
