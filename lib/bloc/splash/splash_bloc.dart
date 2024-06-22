import 'dart:async';
import 'package:bloc/bloc.dart';

class SplashBloc extends Cubit<String?> {
  final String? username;
  SplashBloc(this.username) : super(username) {
    runTimer();
  }

  void runTimer() {
    Timer(const Duration(seconds: 3), () {
      emit(username);
    });
  }
}
