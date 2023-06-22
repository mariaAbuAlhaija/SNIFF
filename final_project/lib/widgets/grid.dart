import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class grid extends StatelessWidget {
  grid({super.key, required this.provider});
  var provider;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: provider.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            index.isEven ? SizedBox(height: 5.h) : SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/product",
                    arguments: provider[index]);
              },
              child: SizedBox(
                // height: 500,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                      height: 250,
                      child: Card(
                        shadowColor: Colors.transparent,
                        color: Colors.white,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            provider[index].images[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("${provider[index].name}"),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${provider[index].brand!.name}"),
                          Text(
                            "\$${provider[index].price}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400, childAspectRatio: 0.61),
    );
  }
}
