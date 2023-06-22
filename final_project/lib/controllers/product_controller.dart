import 'package:final_project/models/order_item.dart';
import 'package:final_project/models/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_helper.dart';

class ProductController {
  String path = "product/";
  Future<List<Product>> getAll({gender, brandName}) async {
    if (gender != null) {
      dynamic jsonObject =
          await ApiHelper().get(path, body: {"gender": gender});
      List<Product> result = [];
      jsonObject.forEach((json) {
        result.add(Product.fromJson(json));
      });
      return result;
    }
    if (brandName != null) {
      dynamic jsonObject =
          await ApiHelper().get(path, body: {"brand_name": brandName});
      List<Product> result = [];
      jsonObject.forEach((json) {
        result.add(Product.fromJson(json));
      });
      return result;
    }
    dynamic jsonObject = await ApiHelper().get(path);
    List<Product> result = [];
    jsonObject.forEach((json) {
      result.add(Product.fromJson(json));
    });
    return result;
  }

  Future<Product> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Product result = Product.fromJson(jsonObject);
    return result;
  }

  Future<List<Product>> getFromOrderItems(List<OrderItem> items) async {
    List<Product> result = [];
    for (OrderItem item in items) {
      dynamic jsonObject = await ApiHelper().get("$path${item.productId}");
      Product product = Product.fromJson(jsonObject[0]);
      product.quantity = item.quantity;
      result.add(product);
    }
    return result;
  }

  Future<Product> create(Product product) async {
    dynamic jsonObject = await ApiHelper().post(path, body: product.toJson());
    Product result = Product.fromJson(jsonObject);
    return result;
  }

  Future<bool> update(Product product) async {
    dynamic jsonObject = await ApiHelper().put(path, product.toJson());
    // Product result = Product.fromJson(jsonObject);
    return true;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // Product result = Product.fromJson(jsonObject);
    // return result;
  }
}
