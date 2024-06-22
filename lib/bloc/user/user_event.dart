part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class CheckUserEvent extends UserEvent {
  const CheckUserEvent(super.username);
}

class RegisterUserEvent extends UserEvent {
  const RegisterUserEvent(super.username);
}
