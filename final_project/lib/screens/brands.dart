import 'package:final_project/controllers/brand_controller.dart';
import 'package:final_project/models/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Brands extends StatelessWidget {
  const Brands({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(
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
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return grid(snapshot);
                }),
          ],
        ),
      ),
    );
  }

  GridView grid(AsyncSnapshot<List<Brand>> snapshot) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
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
                title: Text(snapshot.data![index].name),
              )
            ],
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 1.25.h,
      ),
    );
  }

  Center loading() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
