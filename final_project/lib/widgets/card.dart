import 'package:flutter/material.dart';

class card extends StatelessWidget {
  card(
    this.image, {
    super.key,
    this.txt,
  });
  var image;
  var txt;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          image,
          fit: BoxFit.cover,
        ),
        txt != null
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0),
                    ],
                    begin: const FractionalOffset(0.0, 1.0),
                    end: const FractionalOffset(0.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  )),
                ))
            : SizedBox(),
        txt != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(txt,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold))),
              )
            : SizedBox(),
      ],
    );
  }
}
