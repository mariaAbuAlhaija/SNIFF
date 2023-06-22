class Image {
  int id;
  int productId;
  String image;

  Image(this.id, this.productId, this.image);

  factory Image.fromJson(json) {
    return Image(
      json["id"] ?? 0,
      json["product_id"] ?? 0,
      json["image"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "product_id": productId,
      "image": image,
    };
  }
}
