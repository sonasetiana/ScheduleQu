part of 'delete_schedule_bloc.dart';

sealed class DeleteScheduleState extends Equatable {
  const DeleteScheduleState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class DeleteScheduleInitial extends DeleteScheduleState {
  const DeleteScheduleInitial(super.message);
}

final class DeleteScheduleLoading extends DeleteScheduleState {
  const DeleteScheduleLoading(super.message);
}

final class DeleteScheduleSuccess extends DeleteScheduleState {
  const DeleteScheduleSuccess(super.message);
}

final class DeleteScheduleError extends DeleteScheduleState {
  const DeleteScheduleError(super.message);
}
