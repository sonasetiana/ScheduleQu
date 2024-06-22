import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';

abstract class ScheduleRemoteProvider {
  Future<List<ScheduleModel>> getAllSchedule(String username);
}

class ScheduleRemoteProviderImpl extends ScheduleRemoteProvider {
  final CollectionReference reference;

  ScheduleRemoteProviderImpl({required this.reference});

  @override
  Future<List<ScheduleModel>> getAllSchedule(String username) async {
    final collection =
        await reference.doc(username).collection('SC_1719044902656').get();

    return collection.docs
        .map((e) => ScheduleModel.fromCollection(e.id, e.data()))
        .toList();
  }
}
