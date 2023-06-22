import 'package:final_project/controllers/address_controller.dart';
import 'package:final_project/controllers/country_controller.dart';
import 'package:final_project/globals.dart';
import 'package:final_project/models/address.dart';
import 'package:final_project/models/country.dart';
import 'package:final_project/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

var productProvider = Globals().productProvider;
var userProvider = Globals().userProvider;

class AddressScreen extends StatefulWidget {
  AddressScreen(this.placeOrder, {super.key});
  bool placeOrder = true;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  Address? _selectedAddress = null;
  int? _selectedIndex = -1;

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
    return FutureBuilder<List<Address>>(
      future: AddressController().get(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        return snapshot.data!.length == 0
            ? newAddress(
                context,
                countryController,
                _formKey,
                cityController,
                cityNameController,
                address1Controller,
                address2Controller,
                phoneNumberController,
                zipCodeController,
                widget.placeOrder)
            : pickAddress(context, snapshot);
      },
    );
  }

  Scaffold pickAddress(
      BuildContext context, AsyncSnapshot<List<Address>> snapshot) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Address"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/new_address",
                      arguments: widget.placeOrder);
                },
                child: Icon(
                  Icons.add,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.grey.withOpacity(0.2),
          child: ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 150.h,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAddress = snapshot.data![index];
                        _selectedIndex = index;
                      });
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Card(
                          color: Colors.white,
                          shape: _selectedIndex == index && widget.placeOrder
                              ? RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 2,
                                    color: Colors.blueAccent,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : null,
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${snapshot.data![index].address}"),
                                Text("${snapshot.data![index].phoneNumber}"),
                              ],
                            ),
                            subtitle: Text(
                                "${snapshot.data![index].city!.name}, ${snapshot.data![index].country!.name}"),
                          ),
                        ),
                        Visibility(
                          visible: !widget.placeOrder,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 10, bottom: 20),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 3,
              );
            },
          ),
        ),
        bottomNavigationBar: widget.placeOrder
            ? Container(
                padding: EdgeInsets.all(10),
                height: 60.h,
                color: Colors.white,
                child: MaterialButton(
                  onPressed: _selectedAddress == null
                      ? null
                      : () {
                          print(_selectedAddress!.address);
                          Navigator.pushNamed(context, "/order",
                              arguments: _selectedAddress!);
                        },
                  child: Text(
                    "Place Order",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                  disabledColor: Colors.black.withOpacity(0.7),
                ),
              )
            : null);
  }

  StatefulBuilder city(AsyncSnapshot<List<Country>> snapshot,
      TextEditingController cityController, cityNameController) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return FormBuilderDropdown(
          validator: FormBuilderValidators.required(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: true,
          // initialValue: "${snapshot.data![0].cities![0]}",
          decoration: InputDecoration(label: Text("City")),
          items: snapshot.data![0].cities!
              .map(
                (city) => DropdownMenuItem(
                  value: "${city.name}",
                  child: Text("${city.name}"),
                  onTap: () {
                    setState(() {
                      cityController.text = "${city.id}";
                      cityNameController.text = "${city.name}";
                    });
                  },
                ),
              )
              .toList(),
          name: 'City',
        );
      },
    );
  }

  FormBuilderDropdown<String> country(AsyncSnapshot<List<Country>> snapshot,
      TextEditingController countryController) {
    return FormBuilderDropdown(
      enabled: false,
      initialValue: "${snapshot.data![0].name}",
      decoration: InputDecoration(label: Text("Country")),
      items: [
        DropdownMenuItem(
          value: "${snapshot.data![0].name}",
          child: Text("${snapshot.data![0].name}"),
          onTap: () {
            setState(() {
              countryController.text = snapshot.data![0].name;
            });
          },
        ),
      ],
      name: 'Country',
    );
  }
}

Scaffold newAddress(
    context,
    TextEditingController countryController,
    GlobalKey<FormBuilderState> _formKey,
    TextEditingController cityController,
    TextEditingController cityNameController,
    TextEditingController address1Controller,
    TextEditingController address2Controller,
    TextEditingController phoneNumberController,
    TextEditingController zipCodeController,
    placeOrder) {
  return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("New Address"),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20),
        //     child: InkWell(
        //       onTap: () {
        //         Navigator.pushNamed(context, "/new_address");
        //       },
        //       child: Icon(
        //         Icons.add,
        //         size: 25,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: FutureBuilder(
        future: CountryController().get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          countryController.text = snapshot.data![0].name;
          return FormBuilder(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              height: 500.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _AddressScreenState().country(snapshot, countryController),
                  _AddressScreenState()
                      .city(snapshot, cityController, cityNameController),
                  TextFormField(
                    validator: FormBuilderValidators.required(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: address1Controller,
                    decoration: InputDecoration(label: Text("Address 1")),
                  ),
                  TextFormField(
                      controller: address2Controller,
                      decoration: InputDecoration(label: Text("Address 2"))),
                  TextFormField(
                      validator: FormBuilderValidators.required(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Phone number"),
                          prefixText: '+962 ',
                          prefixStyle: TextStyle(fontWeight: FontWeight.bold))),
                  TextFormField(
                      validator: FormBuilderValidators.required(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      controller: zipCodeController,
                      decoration: InputDecoration(label: Text("Zip code"))),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        height: 60.h,
        color: Colors.white,
        child: MaterialButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Address address = Address(
                0,
                userProvider.user!.id,
                int.parse(cityController.text),
                "+962 ${phoneNumberController.text.toString()}",
                "${address1Controller.text}, ${address2Controller.text}",
                zipCodeController.text,
              );
              Address addressAdded = await AddressController().create(address);
              placeOrder
                  ? Navigator.pushNamed(context, "/order",
                      arguments: addressAdded)
                  : Navigator.pop(context);
            }
          },
          child: Text(
            "Save Address",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
          disabledColor: Colors.black.withOpacity(0.7),
        ),
      ));
}
