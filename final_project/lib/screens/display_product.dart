import 'package:carousel_images/carousel_images.dart';
import 'package:final_project/controllers/review_controller.dart';
import 'package:final_project/models/review.dart';
import 'package:final_project/providers/product_provider.dart';
import 'package:final_project/providers/review_provider.dart';
import 'package:final_project/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../globals.dart';

class DisplayProduct extends StatelessWidget {
  DisplayProduct(this.product, {super.key});
  Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            images(),
            nameAndPrice(),
            descriptionAndRate(),
            SizedBox(
              height: 20.h,
            ),
            reviews()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        height: 70.h,
        color: Colors.white,
        child: Consumer(builder: (context, ProductsProvider provider, child) {
          return MaterialButton(
            onPressed: () {
              provider.addProduct(product);
            },
            child: Text(
              "Add to cart",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.black,
          );
        }),
      ),
    );
  }

  Consumer<ReviewProvider> reviews() {
    return Consumer(
      builder: (context, ReviewProvider provider, child) {
        return FutureBuilder(
          future: provider.fetchProductReviews(product.id),
          builder: (BuildContext context,
              AsyncSnapshot<List<Review>> reviewsSnapshot) {
            if (reviewsSnapshot.hasError) {
              print(reviewsSnapshot.error);
            }
            if (!reviewsSnapshot.hasData) {
              return loading();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Comments (${reviewsSnapshot.data!.length})",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20.h),
                    height: reviewsSnapshot.data!.length > 0 ? 200.h : 100.h,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: reviewsSnapshot.data!.length > 0
                        ? ListView.separated(
                            itemCount: reviewsSnapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: chip(
                                    txt:
                                        "${reviewsSnapshot.data![index].rating}"),
                                title:
                                    Text(reviewsSnapshot.data![index].comment),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: Colors.white,
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "No Reviews",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
              ],
            );
          },
        );
      },
    );
  }

  Row descriptionAndRate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.w),
          height: 100.h,
          width: 300.w,
          child: SingleChildScrollView(
            child: Text(
              "${product.description}",
              softWrap: true,
              maxLines: 50,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
        FutureBuilder<double>(
          future: ReviewController().getRate(productId: "${product.id}"),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return chip(txt: "0");
            }
            if (snapshot.hasData)
              return chip(txt: snapshot.data!.toStringAsFixed(2));
            return SizedBox();
          },
        ),
      ],
    );
  }

  ListTile nameAndPrice() {
    return ListTile(
      title: Text(
        product.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      trailing: Text(
        "\$${product.price}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  SizedBox images() {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: CarouselImages(
        scaleFactor: 0.5,
        listImages: product.images,
        height: double.infinity,
        viewportFraction: 0.95,
        borderRadius: 0,
        cachedNetworkImage: true,
        verticalAlignment: Alignment.center,
      ),
    );
  }

  Center loading() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
