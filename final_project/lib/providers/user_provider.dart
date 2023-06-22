import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? user;
  static final UserProvider _userProvider = UserProvider._internal();

  factory UserProvider() {
    return _userProvider;
  }

  UserProvider._internal() {
    fetchUser();
  }

  fetchUser() async {
    user = await UserController().getAll();
    notifyListeners();
  }

  // updateUser(User user2) async {
  //   UserController().update(user2);

  //   print("updating1 ${user!.sid}");
  //   user = user2;
  //   print("updating ${user2.sid}");
  //   print("updating1 ${user!.sid}");
  //   // fetchUser();
  //   notifyListeners();
  // }
}
