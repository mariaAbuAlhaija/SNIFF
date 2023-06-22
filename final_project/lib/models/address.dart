import 'package:final_project/controllers/city_controller.dart';
import 'package:final_project/controllers/country_controller.dart';
import 'package:final_project/models/city.dart';
import 'package:final_project/models/country.dart';

class Address {
  int id;
  int customerId;
  int cityId;
  String phoneNumber;
  String address;
  String zipCode;
  Country? country;
  City? city;
  bool? defaultAddress;

  Address(this.id, this.customerId, this.cityId, this.phoneNumber, this.address,
      this.zipCode,
      {this.city, this.country, this.defaultAddress = false}) {
    // fetchCity();
  }

  factory Address.fromJson(json) {
    return Address(
        json["id"] ?? 0,
        json["customer_id"] ?? 0,
        json["city_id"] ?? 0,
        json["phone_number"] ?? "",
        json["address"] ?? "",
        json["zip_code"] ?? "",
        city: City.fromJson(json["city"]),
        country: Country.fromJson(json["city"]["country"]),
        defaultAddress: json["default"] == 0 ? false : true);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "customer_id": customerId.toString(),
      "city_id": cityId.toString(),
      "phone_number": phoneNumber,
      "address": address,
      "zip_code": zipCode,
      "default": defaultAddress! ? 1.toString() : 0.toString(),
    };
  }

  // void fetchCity() async {
  //   var city = await CityController().getByID(cityId);
  //   city = city;
  //   var countryObj = await CountryController().getByID(city.countryId);
  //   country = countryObj;
  // }
}
