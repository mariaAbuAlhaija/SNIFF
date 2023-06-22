import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/models/brand.dart';
import 'package:final_project/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayBrand extends StatefulWidget {
  Brand brand;
  DisplayBrand(this.brand, {super.key});
  @override
  State<DisplayBrand> createState() => Display_BrandState();
}

class Display_BrandState extends State<DisplayBrand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              elevation: 5,
              flexibleSpace: FlexibleSpaceBar(
                // titlePadding: EdgeInsets.only(bottom: 50),
                background: Image.network(
                  widget.brand.image,
                  fit: BoxFit.cover,
                ),

                collapseMode: CollapseMode.parallax,
                // title: Text("data")
                // Stack(
                //   fit: StackFit.loose,
                //   children: [
                //     Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Container(
                //           height: 50,
                //           decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //             colors: [
                //               Colors.black.withOpacity(0.7),
                //               Colors.black.withOpacity(0),
                //             ],
                //             begin: const FractionalOffset(0.0, 1.0),
                //             end: const FractionalOffset(0.0, 0.0),
                //             stops: [0.0, 1.0],
                //             tileMode: TileMode.clamp,
                //           )),
                //         )),
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 10),
                //       child: Align(
                //           alignment: Alignment.bottomCenter,
                //           child: Text("txt",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 17,
                //                   fontWeight: FontWeight.bold))),
                //     )
                //   ],
                // )
              ),
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined)),
              backgroundColor: Colors.white,
              expandedHeight: 200.0,
              floating: true,
              pinned: true),

          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(left: 15.w),
                height: 50.h,
                color: Colors.grey.shade200,
                child: Center(
                  child: Text(
                    widget.brand.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                color: Colors.grey.shade200,
                child: Center(
                  child: Text(
                    widget.brand.description,
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.w),
                child: const Center(
                  child: Text(
                    "Perfumes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
              ),
              FutureBuilder(
                future: ProductController()
                    .getAll(brandName: "${widget.brand.name}"),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return grid(provider: snapshot.data);
                },
              )
            ]),
          ), // Place sliver widgets here
        ],
      ),
    );
  }

  List<Widget> _buildList(int count) {
    List<Widget> listItems = [];
    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Text('Sliver Item ${i.toString()}',
              style: new TextStyle(fontSize: 22.0))));
    }

    return listItems;
  }
}
