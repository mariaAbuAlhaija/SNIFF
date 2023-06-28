import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/models/order.dart';
import 'package:final_project/models/product.dart';
import 'package:final_project/models/review.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/providers/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails(this.order, {super.key});
  Order order;
  int _rating = 0;

  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    reviewController.text = " ";
    return FutureBuilder<User>(
      future: UserController().getAll(),
      builder: (BuildContext context, userSnapshot) {
        if (userSnapshot.hasError) {
          print(userSnapshot.error);
        }
        if (!userSnapshot.hasData) {
          return loading();
        }
        return Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.2),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text("Order Details")),
          body: Column(
            children: [
              orderDetails(),
              SizedBox(height: 10.h),
              items(userSnapshot)
            ],
          ),
        );
      },
    );
  }

  Flexible items(AsyncSnapshot<User> userSnapshot) {
    return Flexible(
      child: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: ProductController().getFromOrderItems(order.items),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.stackTrace);
            }
            if (!snapshot.hasData) {
              return loading();
            }
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return item(snapshot, index, context, userSnapshot);
                  }),
            );
          },
        ),
      ),
    );
  }

  Stack item(
    AsyncSnapshot<List<Product>> snapshot,
    int index,
    BuildContext context,
    AsyncSnapshot<User> userSnapshot,
  ) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: 200.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 150.h,
                  width: 150.w,
                  child: Image.network(
                    snapshot.data![index].images[0],
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data![index].name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60.w,
                            child: Text(
                              snapshot.data![index].brand!.name,
                              softWrap: true,
                            ),
                          ),
                          Text(
                            "X${snapshot.data![index].quantity}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: MaterialButton(
            onPressed: () {
              bottomSheet(context, userSnapshot, snapshot, index);
            },
            color: Colors.black,
            child: const Text(
              "Review",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Future<dynamic> bottomSheet(
      BuildContext context,
      AsyncSnapshot<User> userSnapshot,
      AsyncSnapshot<List<Product>> snapshot,
      int index) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Provider.of<ReviewProvider>(context, listen: false)
                    .checkReviewed(userSnapshot.data!.id) ==
                true
            ? Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    height: 350,
                    width: double.infinity,
                    child: Image.network(
                      snapshot.data![index].images[0],
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Text("Product Reviewed")
                ]))
            : StatefulBuilder(builder: (context, setModalState) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 350,
                          width: double.infinity,
                          child: Image.network(
                            snapshot.data![index].images[0],
                            fit: BoxFit.fill,
                          ),
                        ),
                        Row(
                            children: List.generate(5, (index) {
                          final filledIcon = _rating >= index + 1
                              ? Icons.star
                              : Icons.star_border;
                          final color = _rating >= index + 1
                              ? Colors.yellow
                              : Colors.grey;

                          return IconButton(
                            icon: Icon(
                              filledIcon,
                              color: color,
                            ),
                            onPressed: () {
                              setModalState(() {
                                if (_rating == index + 1) {
                                  _rating = index;
                                } else {
                                  _rating = index + 1;
                                }
                              });
                            },
                          );
                        })),
                        TextFormField(
                          controller: reviewController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          minLines: 1,
                          maxLines: 3,
                          maxLength: 60,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: "Write a review",
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Review review = Review(
                                0,
                                userSnapshot.data!.id,
                                snapshot.data![index].id,
                                _rating,
                                reviewController.text);
                            Provider.of<ReviewProvider>(context, listen: false)
                                .addReview(review);
                            Navigator.pop(context);
                          },
                          color: Colors.black,
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
      },
    );
  }

  Container orderDetails() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 100.h,
      color: Colors.white,
      child: ListTile(
        title: Text(order.status.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order #${order.id}"),
                Text("${order.itemsNum} Items"),
              ],
            ),
            Text(
                "${order.address.address}, ${order.address.city!.name}, ${order.address.country!.name}"),
          ],
        ),
      ),
    );
  }

  Center loading() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
