import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_recipe.dart';
import '../providers.dart';
import '../models/category.dart';

const noCategoriesShown = 3;

class CategoriesService {
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
