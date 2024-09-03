import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../models/category.dart';

class CategoriesService {
  static List<Widget> getCategoriesList(List<Category> categories,
      VoidCallback navigateToRecipeList, WidgetRef ref) {
    List<Widget> widgets = [];

    for (Category category in categories) {
      widgets.add(SizedBox(
          height: 150.0,
          child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0))),
              onPressed: () {
                ref
                    .watch(recipeFilterProvider.notifier)
                    .update((state) => state = {"category_id": category.id});

                navigateToRecipeList();
              },
              child: SizedBox.expand(
                  child: Card(
                      child: Column(children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Text(category.name)),
                const SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Placeholder(color: Colors.brown)))
              ]))))));
    }

    return widgets;
  }
}
