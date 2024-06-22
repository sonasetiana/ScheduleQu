import 'package:flutter/material.dart';
import 'package:schedule_qu/core/app_configs.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar(
      {super.key, required this.focusDate, required this.onDaySelected});
  final DateTime focusDate;
  final Function(DateTime, DateTime) onDaySelected;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: AppConfigs.localId,
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: focusDate,
      calendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.purple[50],
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          color: Colors.purple[500],
          fontSize: 16.0,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.purple[100],
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          color: Colors.purple[700],
          fontSize: 16.0,
        ),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(focusDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected.call(selectedDay, focusedDay);
      },
    );
  }
}
