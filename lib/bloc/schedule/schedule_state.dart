part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState(this.schedules, this.message);
  final List<ScheduleModel> schedules;
  final String message;

  @override
  List<Object> get props => [];
}

final class ScheduleInitial extends ScheduleState {
  const ScheduleInitial(super.schedules, super.message);
}

final class ScheduleLoading extends ScheduleState {
  const ScheduleLoading(super.schedules, super.message);
}

final class ScheduleSuccess extends ScheduleState {
  const ScheduleSuccess(super.schedules, super.message);
}

final class ScheduleError extends ScheduleState {
  const ScheduleError(super.schedules, super.message);
}
