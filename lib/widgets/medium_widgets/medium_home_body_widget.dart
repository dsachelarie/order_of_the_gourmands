import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home_body_widget.dart';
import '../buttons/more_categories_button.dart';
import '../buttons/read_more_button.dart';
import '../buttons/add_recipe_button.dart';
import '../buttons/favorites_button.dart';
import '../buttons/my_recipes_button.dart';
import '../../models/recipe.dart';
import '../../providers.dart';
import '../../services/recipe_service.dart';

class MediumHomeBodyWidget extends HomeBodyWidget {
  const MediumHomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Recipe> recipes = ref.watch(recipesProvider);
    Recipe randomRecipe = recipes.isNotEmpty
        ? recipes[Random().nextInt(recipes.length)]
        : Recipe.empty();

    return Row(children: [
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 16,
                  right: MediaQuery.of(context).size.width / 16,
                  top: MediaQuery.of(context).size.height / 32),
              children: [
            Card(
                child: Column(children: [
              const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: AddRecipeButton()),
              const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: MyRecipesButton()),
              const FavoritesButton(),
              ref.watch(userProvider).value == null
                  ? const Center(
                      child: Text("Please log in to use these features"))
                  : const Text("")
            ])),
            recipes.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Card(
                        child: ListTile(
                            title: Text(randomRecipe.name),
                            subtitle: Text(
                                RecipeService.getTruncatedRecipeSteps(
                                    randomRecipe.steps, 300)),
                            trailing: ReadMoreButton(randomRecipe.id))))
                : Container(),
          ])),
      recipes.isNotEmpty
          ? Expanded(
              child: ListView(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 16,
                      right: MediaQuery.of(context).size.width / 16,
                      top: MediaQuery.of(context).size.height / 32),
                  children: [
                  const Center(
                      child: Text("Categories with most recipes:",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.brown))),
                  Column(children: buildCategoriesWidgets(ref)),
                  const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: MoreCategoriesButton())
                ]))
          : Container(),
    ]);
  }
}
