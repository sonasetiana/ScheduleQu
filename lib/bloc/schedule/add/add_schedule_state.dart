part of 'add_schedule_bloc.dart';

sealed class AddScheduleState extends Equatable {
  const AddScheduleState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class AddScheduleInitial extends AddScheduleState {
  const AddScheduleInitial(super.message);
}

final class AddScheduleLoading extends AddScheduleState {
  const AddScheduleLoading(super.message);
}

final class AddScheduleError extends AddScheduleState {
  const AddScheduleError(super.message);
}

final class AddScheduleSuccess extends AddScheduleState {
  const AddScheduleSuccess(super.message);
}
