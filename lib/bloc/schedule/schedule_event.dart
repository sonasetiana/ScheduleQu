part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent(this.selectedDate);
  final DateTime selectedDate;

  @override
  List<Object> get props => [selectedDate];
}

class GetAllSchedule extends ScheduleEvent {
  const GetAllSchedule(super.selectedDate);
}
