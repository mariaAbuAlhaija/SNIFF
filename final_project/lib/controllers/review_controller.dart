import 'package:final_project/models/review.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_helper.dart';

class ReviewController {
  String path = "review/";
  Future<List<Review>> getAll({productId}) async {
    if (productId != null) {
      dynamic jsonObject =
          await ApiHelper().get(path, body: {"product_id": productId});
      List<Review> result = [];
      jsonObject.forEach((json) {
        result.add(Review.fromJson(json));
      });
      return result;
    }
    dynamic jsonObject = await ApiHelper().get(path);
    List<Review> result = [];
    jsonObject.forEach((json) {
      result.add(Review.fromJson(json));
    });
    return result;
  }

  Future<double> getRate({productId}) async {
    var jsonObject = await ApiHelper()
        .get("${path}rating/", body: {"product_id": productId});
    var result = double.parse(jsonObject[0]["avg(`rating`)"]);

    return result;
  }

  Future<Review> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Review result = Review.fromJson(jsonObject);
    return result;
  }

  Future<bool> create(Review review) async {
    dynamic jsonObject = await ApiHelper().post(path, body: review.toJson());
    return true;
  }

  Future<Review> update(Review review) async {
    dynamic jsonObject = await ApiHelper().put(path, review.toJson());
    Review result = Review.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // Review result = Review.fromJson(jsonObject);
    // return result;
  }
}
