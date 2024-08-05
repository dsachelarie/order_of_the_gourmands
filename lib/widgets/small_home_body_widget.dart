import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './limited_categories_widget.dart';
import './recipe_widget.dart';

class SmallHomeBodyWidget extends ConsumerWidget {
  const SmallHomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(children: [
      const Card(child: RecipeWidget()),
      const LimitedCategoriesWidget(),
      ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/categories/'),
          child: const Text("More categories"))
    ]);
  }
}
