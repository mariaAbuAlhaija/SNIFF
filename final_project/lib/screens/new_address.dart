import 'package:final_project/screens/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class NewAddress extends StatefulWidget {
  NewAddress(this.placeOrder, {super.key});
  bool placeOrder;
  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  @override
  Widget build(BuildContext context) {
    var address1Controller = TextEditingController();
    var address2Controller = TextEditingController();
    var phoneNumberController = TextEditingController();
    var zipCodeController = TextEditingController();
    var cityController = TextEditingController();
    var cityNameController = TextEditingController();
    var countryController = TextEditingController();
    final _formKey = GlobalKey<FormBuilderState>();
    return Builder(builder: (context) {
      return newAddress(
          context,
          countryController,
          _formKey,
          cityController,
          cityNameController,
          address1Controller,
          address2Controller,
          phoneNumberController,
          zipCodeController,
          widget.placeOrder);
    });
  }
}
