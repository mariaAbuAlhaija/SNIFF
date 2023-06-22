class Category {
  int id;
  String name;

  Category(this.id, this.name);

  factory Category.fromJson(json) {
    return Category(
      json["id"] ?? 0,
      json["name"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
