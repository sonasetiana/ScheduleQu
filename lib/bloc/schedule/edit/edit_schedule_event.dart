part of 'edit_schedule_bloc.dart';

sealed class EditScheduleEvent extends Equatable {
  const EditScheduleEvent(this.schedule, this.isFieldValid);

  final ScheduleModel schedule;
  final bool isFieldValid;
  @override
  List<Object> get props => [schedule];
}

class SubmitEditScheduleEvent extends EditScheduleEvent {
  const SubmitEditScheduleEvent(super.schedule, super.isFieldValid);
}
