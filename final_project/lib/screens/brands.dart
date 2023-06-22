import 'package:final_project/controllers/brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Brands extends StatefulWidget {
  const Brands({super.key});

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Center(
                  child: Text(
                "Brands",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              )),
            ),
            FutureBuilder(
                future: BrandController().getAll(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return loading();
                  if (snapshot.hasData && !snapshot.hasError) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/brand",
                                arguments: snapshot.data![index]);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                                height: 100,
                                child: Card(
                                  shadowColor: Colors.black,
                                  elevation: 1,
                                  color: Colors.white,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Image.network(
                                      snapshot.data![index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text("${snapshot.data![index].name}"),
                              )
                            ],
                          ),
                        );
                        // Container(
                        //   color: Colors.white,
                        //   margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        //   child: ListTile(
                        //     contentPadding: EdgeInsets.all(5),
                        //     title: Stack(
                        //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Align(
                        //           alignment: Alignment.centerRight,
                        //           child: Card(
                        //             elevation: 0,
                        //             color: Colors.transparent,
                        //             child: Container(
                        //               width: 75.w,
                        //               height: 100.h,
                        //               padding: const EdgeInsets.all(2.5),
                        //               child: Image.network(
                        //                 snapshot.data![index].image,
                        //                 fit: BoxFit.fill,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: SizedBox(
                        //             height: 50.h,
                        //             width: 100.w,
                        //             child: Text(
                        //               snapshot.data![index].name,
                        //               style: TextStyle(color: Colors.black),
                        //               // maxLines: 3,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300, childAspectRatio: 1.25.h),
                    );
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }

  Center loading() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
