class Brand {
  int id;
  String name;
  String image;
  String description;

  Brand(this.id, this.name, this.image, this.description);

  factory Brand.fromJson(json) {
    return Brand(
      json["id"] ?? 0,
      json["name"] ?? "",
      json["image"] ?? "",
      json["description"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "description": description,
    };
  }
}
