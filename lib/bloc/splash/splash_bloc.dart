import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';

class SplashBloc extends Cubit<void> {
  SplashBloc() : super(Void) {
    runTimer();
  }

  void runTimer() {
    Timer(const Duration(seconds: 3), () {
      emit(state);
    });
  }
}
