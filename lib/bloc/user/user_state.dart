part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class UserInitial extends UserState {
  const UserInitial(super.message);
}

final class UserLoading extends UserState {
  const UserLoading(super.message);
}

final class UserError extends UserState {
  const UserError(super.message);
}

final class UserLoginSuccess extends UserState {
  const UserLoginSuccess(super.message);
}

final class UserRegisterSuccess extends UserState {
  const UserRegisterSuccess(super.message);
}
