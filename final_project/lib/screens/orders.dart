import 'package:final_project/controllers/order_controller.dart';
import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/models/order.dart';
import 'package:final_project/models/product.dart';
import 'package:final_project/widgets/horizontal_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
        future: OrderController().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.stackTrace);
          }
          if (!snapshot.hasData) {
            return loading();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text("Orders"),
            ),
            body: snapshot.data!.isEmpty
                ? const Center(
                    child: Text("No orders yet"),
                  )
                : Container(
                    color: Colors.grey.withOpacity(0.2),
                    child: ListView.separated(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return order(context, snapshot, index);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 3,
                        );
                      },
                    ),
                  ),
          );
        });
  }

  Container order(
      BuildContext context, AsyncSnapshot<List<Order>> snapshot, int index) {
    return Container(
        height: 360.h,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/orderDetails",
                arguments: snapshot.data![index]);
          },
          child: Card(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Text(snapshot.data![index].status.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order #${snapshot.data![index].id}"),
                            Text("${snapshot.data![index].itemsNum} Items"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                items(snapshot, index),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Order total: \$${snapshot.data![index].total}')
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container items(AsyncSnapshot<List<Order>> snapshot, int index) {
    return Container(
      height: 230.h,
      child: FutureBuilder<List<Product>>(
        future:
            ProductController().getFromOrderItems(snapshot.data![index].items),
        builder: (BuildContext context, snapshott) {
          if (snapshott.hasError) {
            print(snapshott.error);
            print(snapshott.stackTrace);
          }
          if (!snapshott.hasData) {
            return loading();
          }
          return horizontalItemsView(snapshott.data!);
        },
      ),
    );
  }

  Center loading() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
