import 'package:final_project/main.dart';
import 'package:final_project/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/chip.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../globals.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var provider = Globals().productProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: Container(
          height: double.infinity,
          child: Consumer(
            builder: (context, ProductsProvider provider, child) {
              return provider.cart.length == 0
                  ? Center(
                      child: Text("Cart is empty :("),
                    )
                  : ListView.builder(
                      itemCount: provider.cart.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 170.h,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    width: 150.w,
                                    height: 150.h,
                                    child: Image.network(
                                      provider.cart[index].images[0],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Expanded(
                                flex: 2,
                                child: ListTile(
                                  title: Text(provider.cart[index].name),
                                  subtitle: Container(
                                    height: 120.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(provider.cart[index].brand!.name),
                                        Consumer(
                                          builder: (context,
                                              ProductsProvider provider,
                                              child) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "\$${provider.cart[index].price}"),
                                                SizedBox(
                                                  width: 75,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          provider.decreaseQty(
                                                              provider
                                                                  .cart[index]);
                                                        },
                                                        child: SizedBox(
                                                          height: 25,
                                                          width: 25,
                                                          child: Center(
                                                              child: Text("-")),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${provider.cart[index].quantity}",
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            provider.addProduct(
                                                                provider.cart[
                                                                    index]);
                                                          },
                                                          child: SizedBox(
                                                              height: 25,
                                                              width: 25,
                                                              child: Center(
                                                                  child: Text(
                                                                      "+")))),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   height: double.infinity,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.end,
                              //     children: [
                              //       Text("\$${provider.cart[index].price}"),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      }),
                    );
            },
          )),
      bottomNavigationBar: bottomBar(context),
    );
  }

  Container bottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 70.h,
      color: Colors.white,
      child: Row(
        children: [
          Consumer(builder:
              (BuildContext context, ProductsProvider provider, Widget? child) {
            return Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "\$${provider.total()}",
                  style: TextStyle(fontSize: 17),
                ));
          }),
          Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: provider.cart.length == 0
                  ? null
                  : () {
                      Navigator.pushNamed(context, "/address", arguments: true);
                    },
              child: Text(
                "Checkout",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              disabledColor: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
