import 'package:bloc/bloc.dart';
import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/models/user.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<EditUserEvent>(_edituser);
    on<GetUserEvent>(_getuser);
    on<LogOutUserEvent>(_logoutuser);
    on<SignUpUserEvent>(_signupuser);
  }

  FutureOr<void> _edituser(EditUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      var _user = await UserController().update(event.user);
      emit(Usersuccess());
    } catch (ex) {
      print(ex);
      print(ex.toString());
      emit(Userfailure());
    }
  }

  FutureOr<void> _getuser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      var _user = await UserController().getAll();
      emit(Usersuccess(user: _user));
    } catch (ex) {
      emit(Userfailure());
    }
  }

  FutureOr<void> _logoutuser(
      LogOutUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await UserController().signout();
      emit(Usersuccess());
    } catch (ex) {
      emit(Userfailure());
    }
  }

  FutureOr<void> _signupuser(
      SignUpUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await UserController().create(event.user);
      await UserController().signin(event.user.email, event.user.password);
      emit(Usersuccess(user: event.user));
    } catch (ex) {
      print(ex);
      print(ex.toString());
      emit(Userfailure());
    }
  }
}
