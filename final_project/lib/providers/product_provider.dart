import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = FutureProvider((ref) => ProductsProvider());

class ProductsProvider with ChangeNotifier {
  final List<Product> forHerProducts = [];
  final List<Product> forHimProducts = [];
  final List<Product> allProducts = [];
  List<Product> cart = [];

  // ProductsProvider() {
  //   products();
  //   herProducts();
  //   himProducts();
  // }
  static final ProductsProvider _productsProvider =
      ProductsProvider._internal();

  factory ProductsProvider() {
    return _productsProvider;
  }

  ProductsProvider._internal() {
    products();
    herProducts();
    himProducts();
  }

  bool empty() {
    return forHerProducts.isEmpty ||
        forHerProducts.isEmpty ||
        allProducts.isEmpty;
  }

  products() async {
    var result = await ProductController().getAll();
    allProducts.addAll(result);
    notifyListeners();
    return allProducts;
  }

  herProducts() async {
    var result = await ProductController().getAll(gender: "her");
    forHerProducts.addAll(result);
    notifyListeners();
    return forHerProducts;
  }

  himProducts() async {
    forHimProducts.addAll(await ProductController().getAll(gender: "him"));
    notifyListeners();

    return forHerProducts;
  }

  addProduct(Product product) {
    print("added");
    print(product.toJson());
    if (!cart.contains(product)) {
      cart.add(product);

      increaseQty(product);
    } else {
      increaseQty(product);
    }
    print(cart.length);
    total();
    notifyListeners();
  }

  increaseQty(Product product) {
    print("inc");
    if (product.quantity != 100) {
      product.quantity++;
    }
    notifyListeners();
  }

  decreaseQty(Product product) {
    print("dec");
    if (product.quantity != 1) {
      product.quantity--;
    } else {
      product.quantity--;
      removeProduct(product);
    }
    total();
    notifyListeners();
  }

  removeProduct(Product product) {
    print("deleted");
    cart.remove(product);
    notifyListeners();
  }

  updateStock() async {
    for (var element in cart) {
      element.stock -= element.quantity;
      Product _product = Product.fromObj(element);
      await ProductController().update(_product);
    }
    notifyListeners();
  }

  restoreStock() async {
    for (var element in cart) {
      element.stock += element.quantity;
      Product _product = Product.fromObj(element);
      await ProductController().update(_product);
    }
    notifyListeners();
  }

  emptyCart() async {
    print("deleted");
    for (var element in cart) {
      element.quantity = 0;
      Product _product = Product.fromObj(element);
      await ProductController().update(_product);
    }
    notifyListeners();
    cart.clear();
    notifyListeners();
  }

  total() {
    var total = 0;
    for (var element in cart) {
      total += (element.price * element.quantity);
    }
    return total;
  }

  itemsTotal() {
    var total = 0;
    for (var element in cart) {
      total += element.quantity;
    }
    return total;
  }
}
