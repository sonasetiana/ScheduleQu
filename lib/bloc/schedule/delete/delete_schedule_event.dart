part of 'delete_schedule_bloc.dart';

sealed class DeleteScheduleEvent extends Equatable {
  const DeleteScheduleEvent(this.documentId);

  final String documentId;

  @override
  List<Object> get props => [documentId];
}

class DoDeleteScheduleEvent extends DeleteScheduleEvent {
  const DoDeleteScheduleEvent(super.documentId);
}
