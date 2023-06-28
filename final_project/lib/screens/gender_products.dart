import 'package:final_project/widgets/grid.dart';
import 'package:flutter/material.dart';

class GenderProducts extends StatelessWidget {
  GenderProducts(
    this.args, {
    super.key,
  });
  genderArgs args;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ),
      body: SingleChildScrollView(child: grid(provider: args.products)),
    );
  }
}

class genderArgs {
  genderArgs(
    this.products,
    this.title,
  );
  String title;
  var products;
}
