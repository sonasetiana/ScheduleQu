import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_qu/data/repository/schedule_repository.dart';

part 'delete_schedule_event.dart';
part 'delete_schedule_state.dart';

class DeleteScheduleBloc
    extends Bloc<DeleteScheduleEvent, DeleteScheduleState> {
  final ScheduleRepository repository;
  DeleteScheduleBloc(this.repository) : super(const DeleteScheduleInitial('')) {
    on<DoDeleteScheduleEvent>((event, emit) async {
      emit(DeleteScheduleLoading(state.message));
      final result = await repository.deleteSchedule(event.documentId);
      result.fold(
        (failure) {
          emit(DeleteScheduleError(failure.message));
        },
        (message) {
          emit(DeleteScheduleSuccess(message));
        },
      );
    });
  }
}
