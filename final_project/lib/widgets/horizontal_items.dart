import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class horizontalItemsView extends StatelessWidget {
  horizontalItemsView(
    this.list, {
    super.key,
  });
  List<dynamic> list;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10),
          width: 150,
          // height: 250.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 150.h,
                  child: Image.network(
                    list[index].images[0],
                    fit: BoxFit.cover,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100.w,
                    child: Text(
                      "${list[index].name}",
                      softWrap: true,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Text(
                    "\$${list[index].price}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Container(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${list[index].brand!.name}",
                        style: TextStyle(fontSize: 10)),
                    Text("X${list[index].quantity}",
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
