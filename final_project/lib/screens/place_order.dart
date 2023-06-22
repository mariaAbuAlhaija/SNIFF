import 'package:final_project/controllers/order_controller.dart';
import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/models/address.dart';
import 'package:final_project/models/order.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/providers/product_provider.dart';
import 'package:final_project/widgets/horizontal_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends StatefulWidget {
  PlaceOrder(this.address, {super.key});
  Address address;
  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserController().getAll(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Order"),
          ),
          body: Container(
            color: Colors.grey.withOpacity(0.2),
            child: Column(
              children: [
                address(),
                SizedBox(height: 5.h),
                Container(
                  height: 275.h,
                  padding: EdgeInsets.only(left: 10),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Items",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                          height: 230.h,
                          child: Consumer(
                            builder: (BuildContext context,
                                ProductsProvider provider, Widget? child) {
                              return horizontalItemsView(provider.cart);
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Consumer(builder: (BuildContext context,
                      ProductsProvider provider, Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment summary",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total amount"),
                            Text(
                              "\$${provider.total()}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total items"),
                            Text(
                              "${provider.itemsTotal()}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Payment method"),
                            Text(
                              "Cash",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            height: 60.h,
            color: Colors.white,
            child: Consumer(builder: (BuildContext context,
                ProductsProvider provider, Widget? child) {
              return MaterialButton(
                onPressed: () async {
                  Order order = Order(0, snapshot.data!.id, widget.address.id,
                      0, Status.pending, widget.address, []);

                  await provider.updateStock();
                  OrderController().create(order, provider.cart).then((value) {
                    provider.emptyCart();
                    EasyLoading.showSuccess("Ordered!",
                        duration: Duration(seconds: 3));
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/home",
                      (Route<dynamic> route) => false,
                    );
                  }).onError((error, stackTrace) {
                    print(error);
                    print("error");
                    print(stackTrace);
                    provider.restoreStock();
                  });
                },
                child: Text(
                  "Place Order",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                disabledColor: Colors.black.withOpacity(0.7),
              );
            }),
          ),
        );
      },
    );
  }

  Container address() {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      padding: EdgeInsets.only(right: 10, left: 10),
      height: 120.h,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          SizedBox(
              height: 50.h,
              child: ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Colors.black.withOpacity(0.9),
                  size: 30,
                ),
                minLeadingWidth: 5,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${widget.address.address}"),
                    Text("${widget.address.phoneNumber}"),
                  ],
                ),
                subtitle: Text(
                    "${widget.address.city!.name}, ${widget.address.country!.name}"),
              )),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}
