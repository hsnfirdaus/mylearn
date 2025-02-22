import 'package:flutter/material.dart';
import 'package:mylearn/components/form/base_select.dart';
import 'package:mylearn/components/form/custom_controller.dart';
import 'package:mylearn/components/tile_list_basic.dart';
import 'package:mylearn/models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectMySubject extends BaseSelect<Map<String, dynamic>> {
  SelectMySubject({
    super.key,
    required super.label,
    super.validator,
    super.controller,
  }) : super(
         renderValue: (value) => '[${value['code']}] ${value['name']}',
         placeholder: "Pilih Mata Kuliah",
         fetchFn: (BuildContext context, String search) async {
           final userProvider = Provider.of<UserProvider>(
             context,
             listen: false,
           );

           var query = Supabase.instance.client
               .from("enrollment")
               .select("student_nim, semester_id, subject(id, code, name)")
               .eq("student_nim", userProvider.student!.nim)
               .eq("semester_id", userProvider.semester!.id);
           if (search.isNotEmpty) {
             var searchTerm = search
                 .replaceAll(" ", "%")
                 .replaceAll(".", "")
                 .replaceAll(",", "");
             query = query.or(
               "subject.code.ilike.%$searchTerm%.subject.name.ilike.%$searchTerm%",
             );
           }
           final res = await query
               .limit(20)
               .order('subject(code)', ascending: true);

           return res
               .map((item) => item['subject'] as Map<String, dynamic>)
               .toList();
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

extension SelectMySubjectController on CustomController<Map<String, dynamic>> {
  String? get subjectId {
    return value?['id'];
  }
}
