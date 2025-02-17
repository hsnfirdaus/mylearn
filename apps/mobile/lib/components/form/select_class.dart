import 'package:mylearn/components/form/base_select.dart';
import 'package:mylearn/components/tile_list_basic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectClass extends BaseSelect<Map<String, dynamic>> {
  SelectClass({
    super.key,
    required super.label,
    super.validator,
    super.controller,
  }) : super(
         renderValue:
             (value) =>
                 '${value['full_class_name']} (${value['admission_year']})',
         placeholder: "Pilih Kelas",
         fetchFn: (String search) async {
           var query = Supabase.instance.client
               .from("class")
               .select("id,admission_year,full_class_name");
           if (search.isNotEmpty) {
             query = query.ilike(
               "full_class_name",
               "%${search.replaceAll(" ", "%")}%",
             );
           }
           return query.limit(20).order('full_class_name', ascending: true);
         },
         buildItem: (context, item, index, currentValue, onSelect) {
           return TileListBasic(
             onTap: onSelect,
             selected: item['id'] == currentValue?['id'],
             title: item['full_class_name'],
             subtitle: 'Angkatan ${item['admission_year']}',
           );
         },
       );
}
