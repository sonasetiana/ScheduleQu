import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_configs.dart';

part 'pick_date_time_state.dart';

class PickDateTimeCubit extends Cubit<PickDateTimeState> {
  PickDateTimeCubit()
      : super(
          PickDateTimeInitial(
            DateTime.now(),
            TimeOfDay.now(),
          ),
        );

  void init(Timestamp timeStamp) {
    emit(
      PickDateTimeInitial(
        timeStamp.toDate(),
        TimeOfDay.fromDateTime(
          timeStamp.toDate(),
        ),
      ),
    );
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: state.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      emit(PickDateTimeOnDatePick(pickedDate, state.timeOfDay));
      pickTime(context);
    }
  }

  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: state.timeOfDay,
    );
    if (pickedTime != null) {
      emit(PickDateTimeOnTimePick(state.dateTime, pickedTime));
    }
  }

  DateTime getDateTime() {
    DateTime dt = state.dateTime;
    TimeOfDay td = state.timeOfDay;
    return DateTime(dt.year, dt.month, dt.day, td.hour, td.minute);
  }

  String getDisplayDateTime() {
    return DateFormat(
      AppConfigs.formatDisplayDateSchedule,
      AppConfigs.localId,
    ).format(getDateTime());
  }
}
