import 'package:final_project/models/city.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_helper.dart';

class CityController {
  String path = "city/";
  Future<List<City>> get() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<City> result = [];
    jsonObject.forEach((json) {
      result.add(City.fromJson(json));
    });
    return result;
  }

  Future<City> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    City result = City.fromJson(jsonObject);
    return result;
  }

  Future<City> create(City city) async {
    dynamic jsonObject = await ApiHelper().post(path, body: city.toJson());
    City result = City.fromJson(jsonObject);
    return result;
  }

  Future<City> update(City city) async {
    dynamic jsonObject = await ApiHelper().put(path, city.toJson());
    City result = City.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // City result = City.fromJson(jsonObject);
    // return result;
  }
}
