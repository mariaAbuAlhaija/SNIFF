import 'package:final_project/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GenderProducts extends StatefulWidget {
  GenderProducts(
    this.args, {
    super.key,
  });
  genderArgs args;
  @override
  State<GenderProducts> createState() => _GenderProductsState();
}

class _GenderProductsState extends State<GenderProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.args.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ),
      body: SingleChildScrollView(child: grid(provider: widget.args.products)),
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
