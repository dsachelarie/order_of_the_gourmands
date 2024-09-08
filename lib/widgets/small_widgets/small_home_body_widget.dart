import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          Row(children: [
            ElevatedButton.icon(
                icon: const Icon(Icons.add_outlined),
                label: const Text("Add recipe"),
                onPressed: ref.watch(userProvider).value == null
                    ? null
                    : () {
                        print("1");
                      }),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.folder_outlined),
                    label: const Text("My recipes"),
                    onPressed: ref.watch(userProvider).value == null
                        ? null
                        : () {
                            ref.watch(recipeFilterProvider.notifier).update(
                                (state) => state = {
                                      "creator_id":
                                          ref.watch(userProvider).value?.uid
                                    });

                            Navigator.pushNamed(context, '/recipe-list/');
                          })),
            ElevatedButton.icon(
                icon: const Icon(Icons.star_outline_outlined),
                label: const Text("Favorites"),
                onPressed: ref.watch(userProvider).value == null
                    ? null
                    : () {
                        print("1");
                      })
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
                              trailing: TextButton(
                                  child: const Text("Read more"),
                                  onPressed: () => print("1"))))),
                  const Center(
                      child: Text("Categories with most recipes:",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.brown))),
                  Column(
                      children: CategoriesService.getCategoriesList(
                          CategoriesService.getMostPopularCategories(ref),
                          () => _navigateToRecipeList(context),
                          ref)),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.category_outlined),
                          label: const Text("More categories"),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/categories/')))
                ]))
          : Container(),
    ]);
  }
}
