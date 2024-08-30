import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../limited_categories_widget.dart';
import '../recipe_widget.dart';

class SmallHomeBodyWidget extends ConsumerWidget {
  const SmallHomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      const Text("Order of the Gourmands",
          style: TextStyle(fontSize: 30.0, color: Colors.brown)),
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4,
                  right: MediaQuery.of(context).size.width / 4,
                  top: MediaQuery.of(context).size.height / 10),
              children: [
            const Card(child: RecipeWidget()),
            const LimitedCategoriesWidget(),
            ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("More recipe categories"),
                onPressed: () => Navigator.pushNamed(context, '/categories/'))
          ]))
    ]);
  }
}
