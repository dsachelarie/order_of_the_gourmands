import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_recipe.dart';
import '../providers.dart';
import '../models/category.dart';

const noCategoriesShown = 3;

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

  static List<Category> getMostPopularCategories(WidgetRef ref) {
    List<Category> categories = ref.watch(categoriesProvider);
    List<CategoryRecipe> categoriesRecipes = ref.watch(recipeCategoryProvider);
    List<Category> selectedCategories = List.filled(
        min(noCategoriesShown, categories.length), Category("", ""));
    List<int> recipeCounts =
        List.filled(min(noCategoriesShown, categories.length), 0);

    for (Category category in categories) {
      int noRecipes = categoriesRecipes
          .where((categoryRecipe) => categoryRecipe.categoryId == category.id)
          .toList()
          .length;
      int minNoRecipes = recipeCounts.reduce((a, b) => a < b ? a : b);

      if (noRecipes > minNoRecipes) {
        selectedCategories[recipeCounts.indexOf(minNoRecipes)] = category;
        recipeCounts[recipeCounts.indexOf(minNoRecipes)] = noRecipes;
      }
    }

    return selectedCategories;
  }
}
