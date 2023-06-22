class Payment {
  int id;
  int orderId;
  int amount;
  String paymentStatus;

  Payment(
    this.id,
    this.orderId,
    this.amount,
    this.paymentStatus,
  );

  factory Payment.fromJson(json) {
    return Payment(
      json["id"] ?? 0,
      json["customer_id"] ?? 0,
      json["city_id"] ?? 0,
      json["payment_status"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_id": orderId,
      "amount": amount,
      "payment_status": paymentStatus,
    };
  }
}
