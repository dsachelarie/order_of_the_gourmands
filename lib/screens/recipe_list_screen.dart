import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_recipe.dart';
import '../breakpoints.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../models/recipe.dart';
import '../providers.dart';

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
    } else if (filters.containsKey("category_id")) {
      categoriesRecipes = categoriesRecipes
          .where((categoryRecipe) =>
              categoryRecipe.categoryId == filters["category_id"])
          .toList();

      recipes = recipes.where((recipe) {
        for (CategoryRecipe categoryRecipe in categoriesRecipes) {
          if (categoryRecipe.recipeId == recipe.id) {
            return true;
          }
        }

        return false;
      }).toList();
    } else if (filters.containsKey("creator_id")) {
      recipes = recipes
          .where((recipe) => recipe.creatorId == filters["creator_id"])
          .toList();
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
    }

    Widget body;

    if (recipes.isEmpty) {
      body = const Center(
          child: Text("No recipes were found",
              style: TextStyle(fontSize: 20.0, color: Colors.brown)));
    } else if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = ListView(children: widgets);
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = GridView.count(
          crossAxisCount: 2, childAspectRatio: 8, children: widgets);
    } else {
      body = GridView.count(
          crossAxisCount: 4, childAspectRatio: 4, children: widgets);
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: body,
            bottomNavigationBar: const BottomBarWidget()));
  }
}
