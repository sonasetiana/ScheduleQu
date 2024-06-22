import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';

import '../../../core/app_configs.dart';

abstract class ScheduleRemoteProvider {
  Future<List<ScheduleModel>> getAllSchedule(String username);
}

class ScheduleRemoteProviderImpl extends ScheduleRemoteProvider {
  final FirebaseFirestore firestore;

  ScheduleRemoteProviderImpl({required this.firestore});

  @override
  Future<List<ScheduleModel>> getAllSchedule(String username) async {
    final collection = await firestore
        .collection(AppConfigs.defaultCollection)
        .doc(username)
        .collection('SC_1719044902656')
        .get();

    return collection.docs
        .map((e) => ScheduleModel.fromCollection(e.id, e.data()))
        .toList();
  }
}
