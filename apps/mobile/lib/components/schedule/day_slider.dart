import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mylearn/theme/theme_extension.dart';

class DaySlider extends StatelessWidget {
  const DaySlider({super.key, this.onPress, required this.activeDayOfWeek});

  final int activeDayOfWeek;
  final void Function(int dayOfWeek)? onPress;

  @override
  Widget build(BuildContext context) {
    final currentDt = DateTime.now();
    final dayOfWeek = currentDt.weekday;

    List<String> dateList() {
      final formatter = DateFormat.d();
      List<String> items = [];

      for (var i = 0; i < 7; i++) {
        final date = currentDt.subtract(Duration(days: dayOfWeek - 1 - i));
        items.add(formatter.format(date));
      }

      return items;
    }

    final labels = dateList();
    const List<String> dayNames = [
      "Sen",
      "Sel",
      "Rab",
      "Kam",
      "Jum",
      "Sab",
      "Min",
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        return DateItem(
          date: labels[index],
          day: dayNames[index],
          isActive: activeDayOfWeek - 1 == index,
          onPress:
              activeDayOfWeek - 1 != index && onPress != null
                  ? () => onPress!(index + 1)
                  : null,
        );
      }),
    );
  }
}

class DateItem extends StatelessWidget {
  const DateItem({
    super.key,
    required this.day,
    required this.date,
    required this.isActive,
    this.onPress,
  });

  final String day;
  final String date;
  final bool isActive;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment:
            isActive
                ? AlignmentDirectional.topCenter
                : AlignmentDirectional.bottomCenter,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: isActive ? 62 : 0,
            width: 45,
            color: theme.primary,
          ),
          SizedBox(
            width: 45,
            height: 62,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: onPress,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      AnimatedDefaultTextStyle(
                        style: TextStyle(
                          color:
                              isActive
                                  ? theme.textLight
                                  : theme.textPlaceholder,
                        ),
                        duration: Duration(milliseconds: 300),
                        child: Text(day),
                      ),
                      SizedBox(height: 4),
                      AnimatedDefaultTextStyle(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: isActive ? theme.textLight : theme.textPrimary,
                        ),
                        duration: Duration(milliseconds: 300),
                        child: Text(date),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
