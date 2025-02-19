import 'package:flutter/material.dart';
import 'package:mylearn/components/schedule/day_slider.dart';
import 'package:mylearn/components/schedule/schedule_list.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int dayOfWeek = DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: DaySlider(
            activeDayOfWeek: dayOfWeek,
            onPress: (newWeekday) {
              setState(() {
                dayOfWeek = newWeekday;
              });
            },
          ),
        ),
        ScheduleList(weekday: dayOfWeek),
      ],
    );
  }
}
