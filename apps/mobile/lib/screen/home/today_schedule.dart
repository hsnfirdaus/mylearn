import 'package:flutter/material.dart';
import 'package:mylearn/components/schedule_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodaySchedule extends StatelessWidget {
  TodaySchedule({super.key});

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final future = Supabase.instance.client
        .from("my_schedules")
        .select("*")
        .eq("day_of_week", now.weekday)
        .order("start_time", ascending: true);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final schedules = snapshot.data!;
        if (schedules.isEmpty) {
          return const Center(
            child: Column(
              children: [
                Text(
                  "Tidak Ada Jadwal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("Pastikan sudah menambahkan mata kuliah."),
              ],
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: schedules.length,
          padding: EdgeInsets.only(left: 24, right: 24),
          itemBuilder: ((context, index) {
            final item = schedules[index];

            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: ScheduleItem(item: item),
            );
          }),
        );
      },
    );
  }
}
