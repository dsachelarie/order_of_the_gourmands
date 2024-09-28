import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home_body_widget.dart';
import '../buttons/more_categories_button.dart';
import '../buttons/read_more_button.dart';
import '../buttons/add_recipe_button.dart';
import '../buttons/favorites_button.dart';
import '../buttons/my_recipes_button.dart';
import '../../services/recipe_service.dart';
import '../../providers.dart';
import '../../models/recipe.dart';

class LargeHomeBodyWidget extends HomeBodyWidget {
  const LargeHomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Recipe> recipes = ref.watch(recipesProvider);
    Recipe randomRecipe = recipes.isNotEmpty
        ? recipes[Random().nextInt(recipes.length)]
        : Recipe.empty();

    return Row(children: [
      Expanded(
          flex: 1,
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 32,
                  right: MediaQuery.of(context).size.width / 32,
                  top: MediaQuery.of(context).size.height / 32),
              children: [
                const Center(
                    child: Text("Featured recipe",
                        style: TextStyle(fontSize: 20.0, color: Colors.brown))),
                recipes.isNotEmpty
                    ? Card(
                        child: ListTile(
                            title: Text(randomRecipe.name),
                            subtitle: Text(
                                RecipeService.getTruncatedRecipeSteps(
                                    randomRecipe.steps, 900)),
                            trailing: ReadMoreButton(randomRecipe.id)))
                    : Container(),
              ])),
      recipes.isNotEmpty
          ? Expanded(
              flex: 1,
              child: ListView(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 32,
                      right: MediaQuery.of(context).size.width / 32,
                      top: MediaQuery.of(context).size.height / 32),
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Column(children: [
                        const Row(children: [
                          AddRecipeButton(),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: MyRecipesButton()),
                          FavoritesButton()
                        ]),
                        ref.watch(userProvider).value == null
                            ? const Text("Please log in to use these features")
                            : const Text("")
                      ]),
                    ]),
                    const Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Categories with most recipes:",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.brown)))),
                    Column(children: buildCategoriesWidgets(ref)),
                    const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: MoreCategoriesButton())
                  ]))
          : Container()
    ]);
  }
}
