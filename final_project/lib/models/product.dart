import 'package:final_project/models/brand.dart';
import 'package:final_project/models/image.dart';
import 'package:final_project/models/review.dart';

class Product {
  int id;
  String name;
  int brandId;
  String description;
  int price;
  int stock;
  Gender gender;
  List<dynamic> dynamicImages;
  List<String> images = [];
  List<dynamic> dynamicReviews = [];
  List<Review> reviews = [];
  Brand? brand;
  int quantity;
  Product(
      this.id,
      this.name,
      this.brandId,
      this.description,
      this.price,
      this.stock,
      this.gender,
      this.dynamicImages,
      this.dynamicReviews,
      this.quantity,
      {this.brand}) {
    dynamicImages.forEach((json) {
      images.add(Image.fromJson(json).image);
    });
    dynamicReviews.forEach((json) {
      reviews.add(Review.fromJson(json));
    });
  }

  factory Product.fromJson(json) {
    return Product(
        json["id"] ?? 0,
        json["name"] ?? "",
        json["brand_id"] ?? 0,
        json["description"] ?? "",
        json["price"] ?? 0,
        json["stock"] ?? 0,
        json["gender"] == Gender.her.toString() ? Gender.her : Gender.him,
        json["image"] ?? [],
        json['review'] ?? [],
        json['quantity'],
        brand: Brand.fromJson(json["brand"]));
  }

  factory Product.fromObj(Product product,
      {id, name, brandId, description, price, stock, quantity}) {
    Product _product = Product(
      id ?? product.id,
      name ?? product.name,
      brandId ?? product.brandId,
      description ?? product.description,
      price ?? product.price,
      stock ?? product.stock,
      product.gender,
      product.dynamicImages,
      product.dynamicReviews,
      quantity ?? product.quantity,
      brand: product.brand,
    );
    return _product;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": name,
      "brand_id": brandId.toString(),
      "description": description,
      "price": price.toString(),
      "quantity": quantity.toString(),
      "stock": stock.toString(),
      "gender": gender.name,
    };
  }
}

enum Gender { him, her }
