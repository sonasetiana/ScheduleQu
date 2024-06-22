import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:schedule_qu/core/date_utils.dart';
import 'package:schedule_qu/core/failure.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';
import 'package:schedule_qu/data/provider/local/user_local_provider.dart';
import 'package:schedule_qu/data/provider/remote/schedule_remote_provider.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<ScheduleModel>>> getAllSchedule(
    DateTime selectedDate,
  );
}

class ScheduleRepositoryImpl extends ScheduleRepository {
  final UserLocalProvider userLocalProvider;
  final ScheduleRemoteProvider remoteProvider;

  ScheduleRepositoryImpl({
    required this.userLocalProvider,
    required this.remoteProvider,
  });

  @override
  Future<Either<Failure, List<ScheduleModel>>> getAllSchedule(
      DateTime selectedDate) async {
    try {
      final allSchedule = await remoteProvider.getAllSchedule('');

      final filterSchedule = allSchedule
          .where((e) => isSameDate(e.scheduleTime.toDate(), selectedDate))
          .toList();
      return Right(filterSchedule);
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
