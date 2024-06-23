import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';
import 'package:schedule_qu/data/repository/schedule_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository repository;
  ScheduleBloc(this.repository) : super(const ScheduleInitial([], '')) {
    on<GetAllSchedule>((event, emit) async {
      emit(ScheduleLoading(state.schedules, state.message));
      final allSchedule = await repository.getAllSchedule(event.selectedDate);
      allSchedule.fold(
        (failure) {
          emit(ScheduleError(state.schedules, failure.message));
        },
        (items) {
          emit(ScheduleSuccess(items, state.message));
        },
      );
    });
  }

  @override
  void onTransition(Transition<ScheduleEvent, ScheduleState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
