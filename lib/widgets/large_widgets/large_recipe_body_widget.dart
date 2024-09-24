import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../recipe_body_widget.dart';
import '../buttons/edit_recipe_button.dart';
import '../buttons/star_button.dart';
import '../buttons/delete_recipe_button.dart';
import '../../models/recipe.dart';
import '../../providers.dart';

class LargeRecipeBodyWidget extends RecipeBodyWidget {
  const LargeRecipeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Recipe> recipes = ref.watch(recipesProvider);
    List<Recipe> filteredRecipes = recipes
        .where((recipe) => recipe.id == ref.watch(activeRecipeIdProvider))
        .toList();

    if (filteredRecipes.isEmpty) {
      return const Center(
          child: Text("Something went wrong",
              style: TextStyle(fontSize: 20.0, color: Colors.brown)));
    }

    Recipe recipe = filteredRecipes.first;
    bool starPressed = ref.watch(userProvider).value != null &&
        recipe.favoriteOf.contains(ref.watch(userProvider).value!.uid);

    return Row(children: [
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 32,
                  right: MediaQuery.of(context).size.width / 32,
                  top: MediaQuery.of(context).size.height / 32),
              children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(
                    child: Text(recipe.name,
                        style: const TextStyle(
                            fontSize: 30.0, color: Colors.brown)))),
            if (ref.watch(userProvider).value != null &&
                ref.watch(userProvider).value!.uid == recipe.creatorId)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(children: [
                  Row(children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: EditRecipeButton(recipe)),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 10.0, bottom: 20.0),
                        child: DeleteRecipeButton(recipe.id))
                  ])
                ]),
              ]),
            const Placeholder(color: Colors.brown)
          ])),
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 32,
                  right: MediaQuery.of(context).size.width / 32),
              children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(children: [
                Row(children: [
                  ref.watch(userProvider).value == null
                      ? const Text("Please log in to add to favorites")
                      : const Text(""),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: StarButton(starPressed, recipe)),
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text("${recipe.favoriteOf.length}")),
                ]),
              ]),
            ]),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 5.0),
                    child: Text("Ingredients:",
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.brown)))),
            Column(children: buildIngredientsWidgets(recipe.ingredients)),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Text("Cooking steps:",
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.brown)))),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildStepsWidgets(recipe.steps))
          ]))
    ]);
  }
}
