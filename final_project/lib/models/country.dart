import 'package:final_project/models/city.dart';

class Country {
  int id;
  String name;
  List<City>? cities = [];
  List<dynamic> dynamicCities = [];

  Country(this.id, this.name, this.dynamicCities) {
    dynamicCities.forEach((element) {
      cities!.add(City.fromJson(element));
    });
  }

  factory Country.fromJson(json) {
    return Country(
      json["id"] ?? 0,
      json["name"] ?? "",
      json["city"] ?? [], //!
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
