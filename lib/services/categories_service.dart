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

  static void addCategoriesRecipes(
      Map<String, dynamic> recipeInfo, WidgetRef ref) {
    List<CategoryRecipe> categoriesRecipes = ref.watch(recipeCategoryProvider);

    for (String categoryId in recipeInfo["categories"]) {
      if (categoriesRecipes
          .where((categoryRecipe) =>
              categoryRecipe.categoryId == categoryId &&
              categoryRecipe.recipeId == recipeInfo["id"])
          .isEmpty) {
        ref
            .watch(recipeCategoryProvider.notifier)
            .addCategoryRecipe(recipeInfo["id"], categoryId);
      }
    }
  }

  static void updateCategoriesRecipes(
      Map<String, dynamic> recipeInfo, WidgetRef ref) {
    List<CategoryRecipe> categoriesRecipes = ref.watch(recipeCategoryProvider);

    for (CategoryRecipe categoryRecipe in categoriesRecipes) {
      if (categoryRecipe.recipeId == recipeInfo["id"] &&
          !recipeInfo["categories"].contains(categoryRecipe.categoryId)) {
        if (categoriesRecipes
                .where((recipeCategory) =>
                    recipeCategory.categoryId == categoryRecipe.categoryId)
                .length ==
            1) {
          ref
              .watch(categoriesProvider.notifier)
              .deleteCategory(categoryRecipe.categoryId);
        }

        ref
            .watch(recipeCategoryProvider.notifier)
            .deleteCategoryRecipe(categoryRecipe.id);
      }
    }

    addCategoriesRecipes(recipeInfo, ref);
  }
}
