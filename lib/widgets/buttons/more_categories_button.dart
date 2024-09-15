import 'package:flutter/material.dart';

class MoreCategoriesButton extends StatelessWidget {
  const MoreCategoriesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.category_outlined),
        label: const Text("More categories"),
        onPressed: () => Navigator.pushNamed(context, '/categories/'));
  }
}
