part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class Usersuccess extends UserState {
  User? user;
  Usersuccess({this.user});
}

class Userfailure extends UserState {}
