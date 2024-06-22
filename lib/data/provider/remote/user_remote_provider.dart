import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_qu/core/app_configs.dart';
import 'package:schedule_qu/data/models/collection_model.dart';
import 'package:schedule_qu/data/models/user_model.dart';

abstract class UserRemoteProvider {
  Future<CollectionModel?> login(String username, String password);
  Future<CollectionModel> register(String username, String password);
}

class UserRemoteProviderImpl extends UserRemoteProvider {
  final FirebaseFirestore firestore;

  UserRemoteProviderImpl({required this.firestore});

  @override
  Future<CollectionModel?> login(String username, String password) async {
    final snapshot =
        await firestore.collection(AppConfigs.userCollection).get();

    final user = snapshot.docs
        .map((e) => UserModel.fromCollection(e))
        .toList()
        .where((e) => e.username == username && e.password == password)
        .firstOrNull;

    if (user != null) {
      final schedule = await firestore
          .collection(AppConfigs.scheduleCollection)
          .doc(username)
          .get();

      return CollectionModel(
        collectionId: schedule.id,
        documentId: user.username,
      );
    }

    return null;
  }

  @override
  Future<CollectionModel> register(String username, String password) async {
    UserModel user = UserModel(
      username: username,
      password: password,
      createdAt: Timestamp.fromDate(DateTime.now()),
    );

    String collectionId = AppConfigs.genCollectionId;

    await firestore
        .collection(AppConfigs.userCollection)
        .doc()
        .set(user.toJson());

    await firestore
        .collection(AppConfigs.scheduleCollection)
        .doc(username)
        .collection(collectionId)
        .add(<String, dynamic>{});

    return CollectionModel(collectionId: collectionId, documentId: username);
  }
}
