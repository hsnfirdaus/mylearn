import 'package:flutter/material.dart';
import 'package:mylearn/components/custom_controller.dart';
import 'package:mylearn/style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectClass extends FormField<Map<String, dynamic>> {
  SelectClass({super.key, required this.label, super.validator, this.controller})
    : super(
        initialValue: controller?.value,
        builder: (state) {
          void setActiveItem(Map<String, dynamic> item) {
            state.didChange(item);
            controller?.setValue(item);
          }

          final future = Supabase.instance.client
              .from("class")
              .select("id,admission_year,full_class_name")
              .limit(20)
              .order('admission_year', ascending: false);

          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: state.hasError ? AppColors.error : AppColors.text,
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
                      isScrollControlled: true,
                      backgroundColor: AppColors.background,
                      builder: (BuildContext context) {
                        return SizedBox(
                          child: Column(
                            children: <Widget>[
                              // TODO: Search
                              Container(
                                padding: EdgeInsets.all(24),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Cari disini...",
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: FutureBuilder(
                                  future: future,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final classes = snapshot.data!;
                                    return ListView.builder(
                                      itemCount: classes.length,
                                      itemBuilder: ((context, index) {
                                        final item = classes[index];
                                        return Container(
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                          ),
                                          child: Material(
                                            type: MaterialType.transparency,
                                            surfaceTintColor:
                                                AppColors.background,
                                            child: ListTile(
                                              onTap: () {
                                                setActiveItem(item);
                                                Navigator.pop(context);
                                              },
                                              selected:
                                                  item['id'] ==
                                                  state.value?['id'],
                                              title: Text(
                                                item['full_class_name'],
                                              ),
                                              subtitle: Text(
                                                'Angkatan ${item['admission_year']}',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(24),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Tutup',
                                      style: AppTextStyles.elevatedButtonText,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.background200,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color:
                            state.hasError
                                ? AppColors.error
                                : AppColors.background200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.value == null
                          ? "Pilih Kelas"
                          : '${state.value!['full_class_name']} (${state.value!['admission_year']})',
                      style: TextStyle(color: AppColors.text),
                    ),
                  ),
                ),
              ),
              if (state.hasError)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 4),
                  child: Text(
                    state.errorText ?? "Silahkan Pilih Kelas!",
                    style: const TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          );
        },
      );

  final String label;
  final CustomController? controller;
}
