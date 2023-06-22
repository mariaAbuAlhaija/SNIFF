import 'package:final_project/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_helper.dart';

class UserController {
  String path = "user/";
  Future<User> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    print(jsonObject);
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<User> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<bool> create(User user) async {
    dynamic jsonObject = await ApiHelper().post(path, body: user.toJson());
    User result = User.fromJson(jsonObject);
    String type = jsonObject["type"];
    String token = jsonObject["token"];
    var storage = FlutterSecureStorage();
    await storage.write(key: "token", value: "$type $token");
    return true;
  }

  Future<User> update(User user) async {
    dynamic jsonObject = await ApiHelper().put(path, user.toJson());
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // User result = User.fromJson(jsonObject);
    // return result;
  }

  Future<bool> signin(email, password) async {
    try {
      print("signin");
      dynamic jsonObject = await ApiHelper().post(
        "${path}login/",
        body: ({'email': email, 'password': password}),
      );
      print("passed");
      String type = jsonObject["type"];
      String token = jsonObject["token"];
      var storage = FlutterSecureStorage();
      await storage.write(key: "token", value: "$type $token");
      return true;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<bool> signout() async {
    try {
      dynamic jsonObject = await ApiHelper().postAuth("${path}logout");
      var storage = FlutterSecureStorage();
      await storage.delete(key: "token");
      return true;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
