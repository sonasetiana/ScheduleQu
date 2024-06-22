import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_qu/core/app_configs.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';

class UserBloc extends Cubit<bool> {
  UserBloc(super.initialState);

  void checkUsername(String username) async {
    emit(true);
    try {
      final fireUsername = await FirebaseFirestore.instance
          .collection(AppConfigs.defaultCollection)
          .doc(username)
          .get();

      if (fireUsername.exists) {
        print(fireUsername.id);
        var schedule = ScheduleModel(
          title: 'Ketemu Client',
          description: 'Hari Sabtu meeting dengan client PT. ABC',
          scheduleTime: Timestamp.fromDate(DateTime.now()),
          colorType: 'red',
        );

        await FirebaseFirestore.instance
            .collection(AppConfigs.defaultCollection)
            .doc(fireUsername.id)
            .collection(AppConfigs.genCollectionId)
            .add(schedule.toJson());
        emit(false);
      } else {
        await FirebaseFirestore.instance
            .collection(AppConfigs.defaultCollection)
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
