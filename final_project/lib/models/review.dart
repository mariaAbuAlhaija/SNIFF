class Review {
  int id;
  int userId;
  int productId;
  int rating;
  String comment;

  Review(
    this.id,
    this.userId,
    this.productId,
    this.rating,
    this.comment,
  );

  factory Review.fromJson(json) {
    return Review(
      json["id"] ?? 0,
      json["user_id"] ?? 0,
      json["product_id"] ?? 0,
      json["rating"] ?? 0,
      json["comment"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "user_id": userId.toString(),
      "product_id": productId.toString(),
      "rating": rating.toString(),
      "comment": comment,
    };
  }
}
