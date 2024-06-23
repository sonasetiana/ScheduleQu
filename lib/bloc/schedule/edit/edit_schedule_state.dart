part of 'edit_schedule_bloc.dart';

sealed class EditScheduleState extends Equatable {
  const EditScheduleState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class EditScheduleInitial extends EditScheduleState {
  const EditScheduleInitial(super.message);
}

final class EditScheduleLoading extends EditScheduleState {
  const EditScheduleLoading(super.message);
}

final class EditScheduleSuccess extends EditScheduleState {
  const EditScheduleSuccess(super.message);
}

final class EditScheduleError extends EditScheduleState {
  const EditScheduleError(super.message);
}
