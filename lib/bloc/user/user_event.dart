part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent(this.username, this.password);

  final String username;
  final String password;

  @override
  List<Object> get props => [username];
}

class UserLoginEvent extends UserEvent {
  const UserLoginEvent(super.username, super.password);
}

class UserRegisterEvent extends UserEvent {
  const UserRegisterEvent(super.username, super.password);
}
