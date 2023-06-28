import 'package:final_project/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Container(
          height: double.infinity,
          child: Consumer(
            builder: (context, ProductsProvider provider, child) {
              return provider.cart.isEmpty
                  ? empty()
                  : ListView.builder(
                      itemCount: provider.cart.length,
                      itemBuilder: ((context, index) {
                        return item(provider, index);
                      }),
                    );
            },
          )),
      bottomNavigationBar: bottomBar(context),
    );
  }

  Container item(ProductsProvider provider, int index) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(provider.cart[index].brand!.name),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${provider.cart[index].price}"),
                        quantity(provider, index),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox quantity(ProductsProvider provider, int index) {
    return SizedBox(
      width: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              provider.decreaseQty(provider.cart[index]);
            },
            child: const SizedBox(
              height: 25,
              width: 25,
              child: Center(child: Text("-")),
            ),
          ),
          Text(
            "${provider.cart[index].quantity}",
          ),
          InkWell(
              onTap: () {
                provider.addProduct(provider.cart[index]);
              },
              child: const SizedBox(
                  height: 25, width: 25, child: Center(child: Text("+")))),
        ],
      ),
    );
  }

  Center empty() {
    return const Center(
      child: Text("Cart is empty :("),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: const Text("Cart"),
      centerTitle: true,
    );
  }

  Container bottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 70.h,
      color: Colors.white,
      child: Consumer(builder:
          (BuildContext context, ProductsProvider provider, Widget? child) {
        return Row(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "\$${provider.total()}",
                  style: const TextStyle(fontSize: 17),
                )),
            Expanded(
              flex: 1,
              child: MaterialButton(
                onPressed: provider.cart.length == 0
                    ? null
                    : () {
                        Navigator.pushNamed(context, "/address",
                            arguments: true);
                      },
                child: const Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                disabledColor: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        );
      }),
    );
  }
}
