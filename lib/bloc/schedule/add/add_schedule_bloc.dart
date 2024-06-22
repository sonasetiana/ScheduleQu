import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';

import '../../../data/repository/schedule_repository.dart';

part 'add_schedule_event.dart';
part 'add_schedule_state.dart';

class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  final ScheduleRepository repository;
  AddScheduleBloc(this.repository) : super(const AddScheduleInitial('')) {
    on<SubmitScheduleEvent>((event, emit) async {
      if (!event.isFieldValid) {
        emit(const AddScheduleError('Mohon lengkapi semua field'));
        return;
      }
      emit(AddScheduleLoading(state.message));
      final result = await repository.submitSchedule(event.data);
      result.fold(
        (failure) {
          emit(AddScheduleError(failure.message));
        },
        (message) {
          emit(AddScheduleSuccess(message));
        },
      );
    });
  }
}
