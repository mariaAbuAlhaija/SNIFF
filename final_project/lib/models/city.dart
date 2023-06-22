class City {
  int id;
  int countryId;
  String name;

  City(this.id, this.countryId, this.name);

  factory City.fromJson(json) {
    return City(
      json["id"] ?? 0,
      json["country_id"] ?? 0,
      json["name"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "country_id": countryId,
      "name": name,
    };
  }
}
