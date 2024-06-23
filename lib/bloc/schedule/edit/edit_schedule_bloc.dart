import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/notification_controller.dart';
import '../../../data/models/schedule_model.dart';
import '../../../data/repository/schedule_repository.dart';

part 'edit_schedule_event.dart';
part 'edit_schedule_state.dart';

class EditScheduleBloc extends Bloc<EditScheduleEvent, EditScheduleState> {
  final ScheduleRepository repository;

  EditScheduleBloc(this.repository) : super(const EditScheduleInitial('')) {
    on<SubmitEditScheduleEvent>((event, emit) async {
      if (!event.isFieldValid) {
        emit(const EditScheduleError('Mohon lengkapi semua field'));
        return;
      }
      emit(EditScheduleLoading(state.message));
      final result = await repository.editSchedule(event.schedule);
      result.fold(
        (failure) {
          emit(EditScheduleError(failure.message));
        },
        (message) {
          NotificationController.scheduleNewNotification(event.schedule);
          NotificationController.cancelScheduleNotification(
            event.schedule.notifId,
          );
          emit(EditScheduleSuccess(message));
        },
      );
    });
  }
}
