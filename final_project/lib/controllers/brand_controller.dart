import 'package:final_project/models/brand.dart';
import 'package:final_project/models/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_helper.dart';

class BrandController {
  String path = "brand/";
  Future<List<Brand>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Brand> result = [];
    jsonObject.forEach((json) {
      result.add(Brand.fromJson(json));
    });
    return result;
  }

  Future<Brand> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Brand result = Brand.fromJson(jsonObject);
    return result;
  }

  Future<Brand> create(Brand product) async {
    dynamic jsonObject = await ApiHelper().post(path, body: product.toJson());
    Brand result = Brand.fromJson(jsonObject);
    return result;
  }

  Future<Brand> update(Brand product) async {
    dynamic jsonObject = await ApiHelper().put(path, product.toJson());
    Brand result = Brand.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // Brand result = Brand.fromJson(jsonObject);
    // return result;
  }
}
