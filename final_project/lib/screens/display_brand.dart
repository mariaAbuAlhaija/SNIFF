import 'package:final_project/controllers/product_controller.dart';
import 'package:final_project/models/brand.dart';
import 'package:final_project/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayBrand extends StatelessWidget {
  Brand brand;
  DisplayBrand(this.brand, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          appBar(context),
          content(), // Place sliver widgets here
        ],
      ),
    );
  }

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
        elevation: 5,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
            brand.image,
            fit: BoxFit.cover,
          ),
          collapseMode: CollapseMode.parallax,
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        backgroundColor: Colors.white,
        expandedHeight: 200.0,
        floating: true,
        pinned: true);
  }

  SliverList content() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          padding: EdgeInsets.only(left: 15.w),
          height: 50.h,
          color: Colors.grey.shade200,
          child: Center(
            child: Text(
              brand.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
          color: Colors.grey.shade200,
          child: Center(
            child: Text(
              brand.description,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        perfumes()
      ]),
    );
  }

  Column perfumes() {
    return Column(
      children: [
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
          future: ProductController().getAll(brandName: brand.name),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return grid(provider: snapshot.data);
          },
        ),
      ],
    );
  }

  List<Widget> _buildList(int count) {
    List<Widget> listItems = [];
    for (int i = 0; i < count; i++) {
      listItems.add(Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Sliver Item ${i.toString()}',
              style: const TextStyle(fontSize: 22.0))));
    }

    return listItems;
  }
}
