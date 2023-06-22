class OrderItem {
  int id;
  int orderId;
  int productId;
  int quantity;
  int price;

  OrderItem(
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
  );

  factory OrderItem.fromJson(json) {
    return OrderItem(
      json["id"] ?? 0,
      json["order_id"] ?? 0,
      json["product_id"] ?? 0,
      json["quantity"] ?? 0,
      int.parse(json["price"]) ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_id": orderId,
      "product_id": productId,
      "quantity": quantity,
      "price": price,
    };
  }
}
