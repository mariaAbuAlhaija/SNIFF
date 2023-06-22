import 'package:final_project/models/country.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_helper.dart';

class CountryController {
  String path = "country/";
  Future<List<Country>> get() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Country> result = [];
    jsonObject.forEach((json) {
      result.add(Country.fromJson(json));
    });
    return result;
  }

  Future<Country> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Country result = Country.fromJson(jsonObject);
    return result;
  }

  Future<Country> create(Country country) async {
    dynamic jsonObject = await ApiHelper().post(path, body: country.toJson());
    Country result = Country.fromJson(jsonObject);
    return result;
  }

  Future<Country> update(Country country) async {
    dynamic jsonObject = await ApiHelper().put(path, country.toJson());
    Country result = Country.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // Country result = Country.fromJson(jsonObject);
    // return result;
  }
}
