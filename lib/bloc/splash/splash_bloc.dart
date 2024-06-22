import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:schedule_qu/data/models/collection_model.dart';

class SplashBloc extends Cubit<bool> {
  final CollectionModel? collection;
  SplashBloc(this.collection) : super(collection != null) {
    runTimer();
  }

  void runTimer() {
    Timer(const Duration(seconds: 3), () {
      emit(collection != null);
    });
  }
}
