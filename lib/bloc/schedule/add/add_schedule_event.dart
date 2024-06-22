part of 'add_schedule_bloc.dart';

sealed class AddScheduleEvent extends Equatable {
  const AddScheduleEvent(this.data, this.isFieldValid);
  final ScheduleModel data;
  final bool isFieldValid;
  @override
  List<Object> get props => [data];
}

class SubmitScheduleEvent extends AddScheduleEvent {
  const SubmitScheduleEvent(super.data, super.isFieldValid);
}
