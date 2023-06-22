import 'package:final_project/controllers/brand_controller.dart';
import 'package:final_project/providers/product_provider.dart';
import 'package:final_project/screens/gender_products.dart';
import 'package:final_project/widgets/grid.dart';
import 'package:final_project/widgets/card.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_project/constants/images.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return home();
  }

// ProviderScope(
//       child: Consumer(builder: (context, ref, child) {
//         return ref.watch(productProvider).when(
//           data: (value) {
//             return ListView.builder(
//               itemCount: value.allProducts.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Text(value.allProducts[index].name);
//               },
//             );
//           },
//           error: (Object error, StackTrace stackTrace) {
//             print(error);
//             return Container(
//               color: Colors.amber,
//             );
//           },
//           loading: () {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: Colors.black,
//               ),
//             );
//           },
//         );
//       }),
//     );
  Consumer home() {
    return Consumer<ProductsProvider>(builder: (context, provider, child) {
      if (provider.empty()) return loading();

      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: slider(provider),
            ),
            himVsHer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 230.h,
                  width: 180.w,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.grey,
                    child: InkWell(
                      onTap: () {
                        var args =
                            genderArgs(provider.forHerProducts, "For Her");
                        Navigator.pushNamed(context, "/gender_products",
                            arguments: args);
                      },
                      child: card(provider.forHerProducts[0].images[0],
                          txt: "For Her"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 230.h,
                  width: 180.w,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.grey,
                    child: InkWell(
                      onTap: () {
                        var args =
                            genderArgs(provider.forHimProducts, "For Him");
                        Navigator.pushNamed(context, "/gender_products",
                            arguments: args);
                      },
                      child: card(provider.forHimProducts[6].images[1],
                          txt: "For Him"),
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              title: Text(
                "Shop by Brand",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                width: double.infinity,
                height: 100,
                child: FutureBuilder(
                    future: BrandController().getAll(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && !snapshot.hasError) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 175.w,
                                padding: const EdgeInsets.all(2.5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/brand",
                                        arguments: snapshot.data![index]);
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 0.5,
                                    shadowColor: Colors.black.withOpacity(0.5),
                                    child: Image.network(
                                      snapshot.data![index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                      return Container();
                    })),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 20),
              height: 250.h,
              width: double.infinity,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.grey,
                child: card(Images().perfumesImage,
                    txt: "Explore Top Rated Scents!"),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            ListTile(
              title: Center(
                  child: Text(
                "Especially For You",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: 10.h,
            ),
            grid(provider: provider.allProducts)
          ],
        ),
      );
    });
  }

  ListTile himVsHer() {
    return ListTile(
      title: Text(
        "Her VS Him",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  ImageSlideshow slider(ProductsProvider provider) {
    return ImageSlideshow(
      width: double.infinity,
      height: 350,
      initialPage: 0,
      indicatorColor: Colors.white,
      indicatorBackgroundColor: Colors.grey.withOpacity(0.5),
      indicatorRadius: 6,
      autoPlayInterval: 3000,
      isLoop: true,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/product",
                arguments: provider.allProducts[5]);
          },
          child: Image.network(
            provider.allProducts[5].images[2],
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/product",
                arguments: provider.allProducts[26]);
          },
          child: Image.network(
            provider.allProducts[26].images[2],
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/product",
                arguments: provider.allProducts[16]);
          },
          child: Image.network(
            provider.allProducts[16].images[2],
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Center loading() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
