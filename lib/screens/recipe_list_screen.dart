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
    } else if (filters.containsKey("favorite_of")) {
      recipes = recipes
          .where((recipe) => recipe.favoriteOf.contains(filters["favorite_of"]))
          .toList();
    }

    List<Widget> widgets = [];

    for (int i = 0; i < recipes.length; i++) {
      Recipe recipe = recipes[i];
      bool starPressed = ref.watch(userProvider).value != null &&
          recipe.favoriteOf.contains(ref.watch(userProvider).value!.uid);

      widgets.add(Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
          child: ElevatedButton(
              onPressed: () {
                ref
                    .watch(activeRecipeIndexProvider.notifier)
                    .update((state) => state = i);
                Navigator.pushNamed(context, '/recipe/');
              },
              child: Row(children: [
                Text(recipe.name),
                const Spacer(),
                IconButton(
                    icon: Stack(children: [
                      if (starPressed)
                        const Icon(Icons.star, color: Colors.yellow),
                      const Icon(Icons.star_border),
                    ]),
                    onPressed: ref.watch(userProvider).value == null
                        ? null
                        : () {
                            List favoriteOf = recipe.favoriteOf;

                            if (starPressed) {
                              favoriteOf
                                  .remove(ref.watch(userProvider).value!.uid);
                            } else {
                              favoriteOf
                                  .add(ref.watch(userProvider).value!.uid);
                            }

                            ref.watch(recipesProvider.notifier).updateRecipe(
                                recipe.id, {"favorite_of": favoriteOf});
                            starPressed = !starPressed;
                          }),
                Text("${recipe.favoriteOf.length}"),
              ]))));
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
          crossAxisCount: 3, childAspectRatio: 16 / 3, children: widgets);
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: body,
            bottomNavigationBar: const BottomBarWidget()));
  }
}
