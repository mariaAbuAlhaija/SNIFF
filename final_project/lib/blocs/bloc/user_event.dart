part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class EditUserEvent extends UserEvent {
  User user;
  EditUserEvent({required this.user});
}

class GetUserEvent extends UserEvent {}

class LogOutUserEvent extends UserEvent {}

class SignUpUserEvent extends UserEvent {
  User user;
  SignUpUserEvent({required this.user});
}

class deleteUserEvent extends UserEvent {
  int index;
  deleteUserEvent(this.index);
}
