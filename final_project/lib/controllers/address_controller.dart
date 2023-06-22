import 'package:final_project/models/address.dart';
import 'package:final_project/models/address.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_helper.dart';

class AddressController {
  String path = "address/";
  Future<List<Address>> get() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Address> result = [];
    jsonObject.forEach((json) {
      result.add(Address.fromJson(json));
    });
    return result;
  }

  Future<Address> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Address result = Address.fromJson(jsonObject);
    return result;
  }

  Future<Address> create(Address address) async {
    dynamic jsonObject = await ApiHelper().post(path, body: address.toJson());
    Address result = Address.fromJson(jsonObject[0]);
    return result;
  }

  Future<Address> update(Address address) async {
    dynamic jsonObject = await ApiHelper().put(path, address.toJson());
    Address result = Address.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // Address result = Address.fromJson(jsonObject);
    // return result;
  }
}
