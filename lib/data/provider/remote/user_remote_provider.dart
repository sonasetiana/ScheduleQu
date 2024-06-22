import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRemoteProvider {
  Future<DocumentSnapshot> checkUsername(String username);
  Future<void> registerUsername(String username);
}

class UserRemoteProviderImpl extends UserRemoteProvider {
  final CollectionReference reference;

  UserRemoteProviderImpl({required this.reference});

  @override
  Future<DocumentSnapshot> checkUsername(String username) async {
    return await reference.doc(username).get();
  }

  @override
  Future<void> registerUsername(String username) async {
    return await reference.doc(username).set(<String, dynamic>{});
  }
}
