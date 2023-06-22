import 'package:final_project/models/address.dart';
import 'package:final_project/models/order_item.dart';
import 'package:final_project/models/product.dart';
import 'package:final_project/providers/product_provider.dart';

class Order {
  int id;
  int userId;
  int addressId;
  int total;
  Status status;
  Address address;
  List<dynamic> dynamicItems;
  List<OrderItem> items = [];
  int itemsNum = 0;

  Order(
    this.id,
    this.userId,
    this.addressId,
    this.total,
    this.status,
    this.address,
    this.dynamicItems,
  ) {
    for (var item in dynamicItems) {
      OrderItem itemObj = OrderItem.fromJson(item);
      itemsNum += itemObj.quantity;
      items.add(itemObj);
    }
    if (itemsNum == 0) itemsNum += items.length;
  }

  factory Order.fromJson(json) {
    return Order(
      json["id"] ?? 0,
      json["user_id"] ?? 0,
      json["address_id"] ?? 0,
      json["total"] ?? 0,
      json["status"] == Status.pending.name
          ? Status.pending
          : json["status"] == Status.processing.name
              ? Status.processing
              : json["status"] == Status.shipped.name
                  ? Status.shipped
                  : json["status"] == Status.delivered.name
                      ? Status.delivered
                      : Status.cancelled,
      Address.fromJson(json["address"]),
      json["orderItem"] ?? [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "user_id": userId.toString(),
      "address_id": addressId.toString(),
      "status": status.name,
    };
  }

  Map<String, dynamic> toJsonItems() => {
        "id": id.toString(),
        "user_id": userId.toString(),
        "address_id": addressId.toString(),
        "status": status.name,
        'products':
            ProductsProvider().cart.map((Product e) => e.id).toList().toString()
      };
}

enum Status { pending, processing, shipped, delivered, cancelled }
