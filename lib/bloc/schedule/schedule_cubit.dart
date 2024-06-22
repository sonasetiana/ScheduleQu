import 'package:bloc/bloc.dart';

class ScheduleCubit extends Cubit<DateTime> {
  ScheduleCubit(super.initialState);
  void setSelectedDate(DateTime selectedDate) {
    emit(selectedDate);
  }
}
