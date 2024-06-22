part of 'pick_date_time_cubit.dart';

sealed class PickDateTimeState extends Equatable {
  const PickDateTimeState(this.dateTime, this.timeOfDay);
  final DateTime dateTime;
  final TimeOfDay timeOfDay;

  @override
  List<Object> get props => [];
}

final class PickDateTimeInitial extends PickDateTimeState {
  const PickDateTimeInitial(super.dateTime, super.timeOfDay);
}

final class PickDateTimeOnDatePick extends PickDateTimeState {
  const PickDateTimeOnDatePick(super.dateTime, super.timeOfDay);
}

final class PickDateTimeOnTimePick extends PickDateTimeState {
  const PickDateTimeOnTimePick(super.dateTime, super.timeOfDay);
}
