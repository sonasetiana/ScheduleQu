part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState(this.data, this.message);

  final String data;
  final String message;

  @override
  List<Object> get props => [message];
}

final class UserInitial extends UserState {
  const UserInitial(super.data, super.message);
}

final class UserLoading extends UserState {
  const UserLoading(super.data, super.message);
}

final class UserError extends UserState {
  const UserError(super.data, super.message);
}

final class UserSuccess extends UserState {
  const UserSuccess(super.data, super.message);
}
