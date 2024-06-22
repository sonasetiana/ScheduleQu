import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserBloc extends Cubit<bool> {
  UserBloc(super.initialState);

  void checkUsername(String username) async {
    emit(true);
    try {
      final fireUsername = await FirebaseFirestore.instance
          .collection('jadwal')
          .doc(username)
          .get();

      if (fireUsername.exists) {
        print(fireUsername.id);
        emit(false);
      } else {
        await FirebaseFirestore.instance
            .collection('jadwal')
            .doc(username)
            .set({});
        emit(false);
      }
    } catch (e) {
      print(e);
      emit(false);
    }
    // FirebaseFirestore.instance.collection('jadwal').doc(username).get().then(
    //   (value) {
    //     print(value.exists);
    //     print(value.id);
    //   },
    // ).onError(
    //   (error, stackTrace) {
    //     print('error: $error');
    //     print('stackTrace: $stackTrace');
    //     emit(false);
    //   },
    // );
  }
}
