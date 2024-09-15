import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../buttons/more_categories_button.dart';
import '../buttons/read_more_button.dart';
import '../buttons/add_recipe_button.dart';
import '../buttons/favorites_button.dart';
import '../buttons/my_recipes_button.dart';
import '../../services/categories_service.dart';
import '../../models/recipe.dart';
import '../../services/recipe_service.dart';
import '../../providers.dart';

class SmallHomeBodyWidget extends ConsumerWidget {
  const SmallHomeBodyWidget({super.key});

  void _navigateToRecipeList(BuildContext context) {
    Navigator.pushNamed(context, '/recipe-list/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Recipe> recipes = ref.watch(recipesProvider);
    Recipe randomRecipe = recipes.isNotEmpty
        ? recipes[Random().nextInt(recipes.length)]
        : Recipe.empty();

    return Column(children: [
      const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text("Order of the Gourmands",
              style: TextStyle(fontSize: 30.0, color: Colors.brown))),
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
      recipes.isNotEmpty
          ? Expanded(
              child: ListView(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 8,
                      right: MediaQuery.of(context).size.width / 8,
                      top: MediaQuery.of(context).size.height / 16),
                  children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                          child: ListTile(
                              title: Text(randomRecipe.name),
                              subtitle: Text(
                                  RecipeService.getTruncatedRecipeSteps(
                                      randomRecipe.steps, 300)),
                              trailing: ReadMoreButton(
                                  recipes.indexOf(randomRecipe))))),
                  const Center(
                      child: Text("Categories with most recipes:",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.brown))),
                  Column(
                      children: CategoriesService.getCategoriesList(
                          CategoriesService.getMostPopularCategories(ref),
                          () => _navigateToRecipeList(context),
                          ref)),
                  const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: MoreCategoriesButton())
                ]))
          : Container(),
    ]);
  }
}
