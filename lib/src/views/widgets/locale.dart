import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class LocaleInit extends StatelessWidget {
  const LocaleInit({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0,
      child: CalendarTimeline(
        showYears: true,
        // shrink: true,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now(),
        onDateSelected: (date) {},
        leftMargin: 20,
        selectableDayPredicate: (date) => date.day != 23,
        locale: 'vi',
      ),
    );
  }
}
