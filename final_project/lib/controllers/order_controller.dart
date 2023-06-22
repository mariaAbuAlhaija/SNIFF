import 'package:final_project/models/order.dart';
import 'package:final_project/models/product.dart';
import 'api_helper.dart';

class OrderController {
  String path = "order/";
  Future<List<Order>> getAll({status}) async {
    if (status != null) {
      dynamic jsonObject =
          await ApiHelper().get(path, body: {"status": status});

      List<Order> result = [];
      jsonObject.forEach((json) {
        result.add(Order.fromJson(json));
      });
      return result;
    }
    dynamic jsonObject = await ApiHelper().get("${path}auth");

    List<Order> result = [];
    jsonObject.forEach((json) {
      result.add(Order.fromJson(json));
    });

    return result;
  }

  Future<Order> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Order result = Order.fromJson(jsonObject);
    return result;
  }

  Future<bool> create(Order order, List<Product> items) async {
    print(order.toJsonItems());
    dynamic jsonObject =
        await ApiHelper().postAuth(path, body: order.toJsonItems());
    return true;
  }

  Future<Order> update(Order order) async {
    dynamic jsonObject = await ApiHelper().put(path, order.toJson());
    Order result = Order.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // Order result = Order.fromJson(jsonObject);
    // return result;
  }
}
