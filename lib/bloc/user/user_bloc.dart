import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_qu/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  UserBloc(this.repository) : super(const UserInitial('', '')) {
    on<CheckUserEvent>((event, emit) async {
      emit(UserLoading(state.data, state.message));
      final result = await repository.checkUsername(event.username);
      result.fold(
        (failure) {
          emit(UserError(state.data, failure.message));
        },
        (username) {
          emit(UserSuccess(username, 'Username ditemukan'));
        },
      );
    });
  }
}
