import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_qu/data/models/collection_model.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';

import '../../../core/app_configs.dart';

abstract class ScheduleRemoteProvider {
  Future<List<ScheduleModel>> getAllSchedule(CollectionModel? collection);
  Future<DocumentReference> submitSchedule(
    CollectionModel? collection,
    ScheduleModel schedule,
  );
  Future<void> delteSchedule(
    CollectionModel? collection,
    String documentId,
  );
  Future<void> updateSchedule(
    CollectionModel? collection,
    ScheduleModel schedule,
  );
}

class ScheduleRemoteProviderImpl extends ScheduleRemoteProvider {
  final FirebaseFirestore firestore;

  ScheduleRemoteProviderImpl({required this.firestore});

  @override
  Future<List<ScheduleModel>> getAllSchedule(
      CollectionModel? collection) async {
    final subCollection = await firestore
        .collection(AppConfigs.scheduleCollection)
        .doc(collection?.documentId)
        .collection(collection?.collectionId ?? '')
        .get();
    final emptyDoc = subCollection.docs.where((e) => e.data().isEmpty);

    if (emptyDoc.isNotEmpty) {
      await firestore
          .collection(AppConfigs.scheduleCollection)
          .doc(collection?.documentId)
          .collection(collection?.collectionId ?? '')
          .doc(emptyDoc.first.id)
          .delete();
    }

    return subCollection.docs
        .where((e) => e.data().isNotEmpty)
        .map((e) => ScheduleModel.fromCollection(e.id, e.data()))
        .toList();
  }

  @override
  Future<DocumentReference> submitSchedule(
    CollectionModel? collection,
    ScheduleModel schedule,
  ) async {
    return await firestore
        .collection(AppConfigs.scheduleCollection)
        .doc(collection?.documentId)
        .collection(collection?.collectionId ?? '')
        .add(schedule.toJson());
  }

  @override
  Future<void> delteSchedule(
    CollectionModel? collection,
    String documentId,
  ) async {
    return await firestore
        .collection(AppConfigs.scheduleCollection)
        .doc(collection?.documentId)
        .collection(collection?.collectionId ?? '')
        .doc(documentId)
        .delete();
  }

  @override
  Future<void> updateSchedule(
    CollectionModel? collection,
    ScheduleModel schedule,
  ) async {
    return await firestore
        .collection(AppConfigs.scheduleCollection)
        .doc(collection?.documentId)
        .collection(collection?.collectionId ?? '')
        .doc(schedule.docId)
        .set(schedule.toJson());
  }
}
