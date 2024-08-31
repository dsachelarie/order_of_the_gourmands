import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_recipe.dart';
import '../breakpoints.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../models/recipe.dart';
import '../providers/providers.dart';

class RecipeListScreen extends ConsumerWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Recipe> recipes = ref.watch(recipesProvider);
    List<CategoryRecipe> categoriesRecipes = ref.watch(recipeCategoryProvider);
    Map<String, dynamic> filters = ref.watch(recipeFilterProvider);

    if (filters.containsKey("name")) {
      recipes = recipes.where((recipe) {
        for (String seq in filters["name"]) {
          if (recipe.name.toLowerCase().contains(seq)) {
            return true;
          }
        }
        return false;
      }).toList();
    } else if (filters.containsKey("category")) {
      categoriesRecipes = categoriesRecipes
          .where((categoryRecipe) =>
              categoryRecipe.categoryId == filters["category"].id)
          .toList();

      recipes = recipes.where((recipe) {
        for (CategoryRecipe categoryRecipe in categoriesRecipes) {
          if (categoryRecipe.recipeId == recipe.id) {
            return true;
          }
        }

        return false;
      }).toList();
    }

    List<Widget> widgets = [];

    for (Recipe recipe in recipes) {
      widgets.add(Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
          child: ElevatedButton(
              onPressed: () {
                ref
                    .watch(activeRecipeProvider.notifier)
                    .update((state) => state = recipe);
                Navigator.pushNamed(context, '/recipe/');
              },
              child: Text(recipe.name))));

      break;
    }

    Widget body;

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = ListView(children: widgets);
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = GridView.count(
          crossAxisCount: 2, childAspectRatio: 8, children: widgets);
    } else {
      body = GridView.count(
          crossAxisCount: 4, childAspectRatio: 4, children: widgets);
    }

    return Scaffold(
        appBar: const TopBarWidget(),
        body: body,
        bottomNavigationBar: const BottomBarWidget());
  }
}
