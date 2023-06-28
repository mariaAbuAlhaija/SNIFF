import 'package:final_project/providers/address_provider.dart';
import 'package:final_project/screens/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class NewAddress extends StatelessWidget {
  NewAddress(this.placeOrder, {super.key});
  bool placeOrder;
  @override
  Widget build(BuildContext context) {
    var address1Controller = TextEditingController();
    var address2Controller = TextEditingController();
    var phoneNumberController = TextEditingController();
    var zipCodeController = TextEditingController();
    var cityController = TextEditingController();
    var cityNameController = TextEditingController();
    var countryController = TextEditingController();
    final formKey = GlobalKey<FormBuilderState>();
    return Consumer(
      builder: (context, AddressProvider provider, child) {
        return newAddress(
            context,
            provider,
            countryController,
            formKey,
            cityController,
            cityNameController,
            address1Controller,
            address2Controller,
            phoneNumberController,
            zipCodeController,
            placeOrder);
      },
    );
  }
}
