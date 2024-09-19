import 'package:flutter/material.dart';

class RecipeEditTextField extends StatelessWidget {
  final TextEditingController controller;

  const RecipeEditTextField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: SizedBox(
            width: 125.0,
            child: TextField(
                controller: controller,
                decoration:
                    const InputDecoration(border: OutlineInputBorder()))));
  }
}
