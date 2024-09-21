import 'package:flutter/material.dart';

class RecipeEditTextField extends StatelessWidget {
  final TextEditingController controller;
  final double size;

  const RecipeEditTextField(this.controller, {this.size = 0.0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: SizedBox(
            width: size,
            child: TextField(
                controller: controller,
                decoration:
                    const InputDecoration(border: OutlineInputBorder()))));
  }
}
