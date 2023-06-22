import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class chip extends StatelessWidget {
  const chip({
    super.key,
    required this.txt,
  });

  final txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.w),
      height: 25.h,
      width: 50.w,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            txt,
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
          Icon(
            Icons.star_rounded,
            color: Colors.white,
            size: 21,
          ),
        ],
      ),
    );
  }
}
