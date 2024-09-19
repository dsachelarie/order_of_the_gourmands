import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_of_the_gourmands/widgets/buttons/edit_recipe_button.dart';
import '../../services/recipe_service.dart';
import '../buttons/delete_recipe_button.dart';
import '../../models/recipe.dart';
import '../../providers.dart';

class SmallRecipeBodyWidget extends ConsumerWidget {
  const SmallRecipeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int recipeIndex = ref.watch(activeRecipeIndexProvider);
    List<Recipe> recipes = ref.watch(recipesProvider);
    Recipe recipe = recipes[recipeIndex];
    bool starPressed = ref.watch(userProvider).value != null &&
        recipe.favoriteOf.contains(ref.watch(userProvider).value!.uid);

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(children: [
          Row(children: [
            ref.watch(userProvider).value == null
                ? const Text("Please log in to add to favorites")
                : const Text(""),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: IconButton(
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
                          })),
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text("${recipe.favoriteOf.length}")),
          ]),
        ]),
      ]),
      Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(recipe.name,
              style: const TextStyle(fontSize: 30.0, color: Colors.brown))),
      if (ref.watch(userProvider).value != null &&
          ref.watch(userProvider).value!.uid == recipe.creatorId)
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            Row(children: [
              EditRecipeButton(recipe),
              Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: DeleteRecipeButton(recipe.id))
            ])
          ]),
        ]),
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 16,
                  right: MediaQuery.of(context).size.width / 16,
                  top: MediaQuery.of(context).size.height / 16),
              children: [
            const Placeholder(color: Colors.brown),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Text("Ingredients:",
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.brown)))),
            Column(
                children: RecipeService.getIngredientsList(recipe.ingredients)),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Text("Cooking steps:",
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.brown)))),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: RecipeService.getStepsList(recipe.steps))
          ])),
    ]);
  }
}
