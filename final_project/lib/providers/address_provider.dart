import 'package:final_project/controllers/address_controller.dart';
import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/models/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = FutureProvider((ref) => AddressProvider());

class AddressProvider with ChangeNotifier {
  final List<Address> addresses = [];

  static final AddressProvider _addressProvider = AddressProvider._internal();

  factory AddressProvider() {
    return _addressProvider;
  }

  AddressProvider._internal() {
    address();
  }

  address() async {
    var result = await AddressController().get();
    addresses.addAll(result);
    notifyListeners();
    return addresses;
  }

  addAddress(Address address) async {
    Address addressAdded = await AddressController().create(address);
    print("added");
    addresses.add(addressAdded);
    notifyListeners();
    return addressAdded;
  }

  removeAddress(Address address) async {
    print("deleted");
    await AddressController().distroy(address.id);
    addresses.remove(address);
    notifyListeners();
  }
}
