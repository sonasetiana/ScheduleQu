import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_qu/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  UserBloc(this.repository) : super(const UserInitial('')) {
    on<UserLoginEvent>((event, emit) async {
      emit(UserLoading(state.message));
      if (event.username.isEmpty) {
        emit(const UserError('Username masih kosong'));
        return;
      }
      if (event.password.isEmpty) {
        emit(const UserError('Password masih kosong'));
        return;
      }
      final login = await repository.login(
        event.username,
        event.password,
      );
      login.fold(
        (failure) {
          emit(UserError(failure.message));
        },
        (message) {
          emit(UserLoginSuccess(message));
        },
      );
    });
    on<UserRegisterEvent>((event, emit) async {
      emit(UserLoading(state.message));
      if (event.username.isEmpty) {
        emit(const UserError('Username masih kosong'));
        return;
      }
      if (event.password.isEmpty) {
        emit(const UserError('Password masih kosong'));
        return;
      }
      final login = await repository.register(
        event.username,
        event.password,
      );
      login.fold(
        (failure) {
          emit(UserError(failure.message));
        },
        (message) {
          emit(UserRegisterSuccess(message));
        },
      );
    });
  }
}
